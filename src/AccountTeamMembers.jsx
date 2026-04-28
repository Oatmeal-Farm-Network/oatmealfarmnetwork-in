import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';
const OTF_API = import.meta.env.VITE_OTF_API_URL || import.meta.env.VITE_API_URL || '';

async function syncOTFCommunity(businessId) {
  try {
    const token    = localStorage.getItem('access_token') || '';
    const peopleId = localStorage.getItem('people_id') || '0';
    await fetch(`${OTF_API}/api/admin/mill/communities/sync-business/${businessId}`, {
      method: 'POST',
      headers: { Authorization: `Bearer ${token}`, 'x-people-id': peopleId },
    });
  } catch { /* non-blocking */ }
}

const ACCESS_LEVELS = [
  { id: 1, label: 'View only' },
  { id: 2, label: 'Editor' },
  { id: 3, label: 'Admin / Owner' },
];

function authHeaders() {
  const token = localStorage.getItem('access_token');
  return token ? { Authorization: `Bearer ${token}` } : {};
}

export default function AccountTeamMembers() {
  const [params] = useSearchParams();
  const BusinessID = parseInt(params.get('BusinessID') || '0', 10);
  const PeopleID = parseInt(localStorage.getItem('people_id') || localStorage.getItem('PeopleID') || '0', 10);
  const { Business, LoadBusiness } = useAccount();

  const [members, setMembers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [savedMessage, setSavedMessage] = useState(null);

  const [showAdd, setShowAdd] = useState(false);
  const [addForm, setAddForm] = useState({
    Email: '',
    PeopleFirstName: '',
    PeopleLastName: '',
    AccessLevelID: 2,
    Role: 'Staff',
  });
  const [addBusy, setAddBusy] = useState(false);

  const [editingId, setEditingId] = useState(null);
  const [editForm, setEditForm] = useState({ AccessLevelID: 1, Role: '' });
  const [editBusy, setEditBusy] = useState(false);

  useEffect(() => {
    if (BusinessID) LoadBusiness(BusinessID);
  }, [BusinessID]);

  const loadMembers = async () => {
    if (!BusinessID) return;
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`${API_URL}/auth/business-members?BusinessID=${BusinessID}`, {
        headers: authHeaders(),
      });
      if (!res.ok) {
        const d = await res.json().catch(() => ({}));
        throw new Error(d.detail || 'Could not load team members.');
      }
      setMembers(await res.json());
    } catch (e) {
      setError(e.message || 'Load failed.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { loadMembers(); }, [BusinessID]);

  const flash = (msg) => {
    setSavedMessage(msg);
    setTimeout(() => setSavedMessage(null), 3000);
  };

  const handleAdd = async (e) => {
    e.preventDefault();
    if (!addForm.Email.trim()) return;
    setAddBusy(true);
    setError(null);
    try {
      const res = await fetch(`${API_URL}/auth/business-members`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', ...authHeaders() },
        body: JSON.stringify({ BusinessID, ...addForm }),
      });
      if (!res.ok) {
        const d = await res.json().catch(() => ({}));
        throw new Error(d.detail || 'Could not add team member.');
      }
      setAddForm({ Email: '', PeopleFirstName: '', PeopleLastName: '', AccessLevelID: 2, Role: 'Staff' });
      setShowAdd(false);
      flash('Team member added.');
      syncOTFCommunity(BusinessID);
      await loadMembers();
    } catch (e) {
      setError(e.message || 'Add failed.');
    } finally {
      setAddBusy(false);
    }
  };

  const startEdit = (m) => {
    setEditingId(m.BusinessAccessID);
    setEditForm({ AccessLevelID: m.AccessLevelID || 1, Role: m.Role || '' });
  };

  const handleSaveEdit = async (id) => {
    setEditBusy(true);
    setError(null);
    try {
      const res = await fetch(`${API_URL}/auth/business-members/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json', ...authHeaders() },
        body: JSON.stringify(editForm),
      });
      if (!res.ok) {
        const d = await res.json().catch(() => ({}));
        throw new Error(d.detail || 'Could not update team member.');
      }
      setEditingId(null);
      flash('Team member updated.');
      await loadMembers();
    } catch (e) {
      setError(e.message || 'Update failed.');
    } finally {
      setEditBusy(false);
    }
  };

  const handleDelete = async (m, hard = false) => {
    if (m.PeopleID === PeopleID) {
      setError("You can't remove yourself. Ask another admin to do it.");
      return;
    }
    const name = `${m.PeopleFirstName || ''} ${m.PeopleLastName || ''}`.trim() || m.PeopleEmail;
    const prompt = hard
      ? `Permanently delete ${name}'s record? This removes the row from the database — there's no undo.`
      : `Remove ${name}'s access to this business?`;
    if (!window.confirm(prompt)) return;
    setError(null);
    try {
      const url = `${API_URL}/auth/business-members/${m.BusinessAccessID}${hard ? '?hard=true' : ''}`;
      const res = await fetch(url, { method: 'DELETE', headers: authHeaders() });
      if (!res.ok) {
        const d = await res.json().catch(() => ({}));
        throw new Error(d.detail || 'Could not remove team member.');
      }
      flash(hard ? 'Team member permanently deleted.' : 'Team member removed.');
      await loadMembers();
    } catch (e) {
      setError(e.message || 'Remove failed.');
    }
  };

  const handleReactivate = async (m) => {
    setError(null);
    try {
      const res = await fetch(`${API_URL}/auth/business-members/${m.BusinessAccessID}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json', ...authHeaders() },
        body: JSON.stringify({ Active: 1 }),
      });
      if (!res.ok) {
        const d = await res.json().catch(() => ({}));
        throw new Error(d.detail || 'Could not reactivate team member.');
      }
      flash('Team member reactivated.');
      await loadMembers();
    } catch (e) {
      setError(e.message || 'Reactivate failed.');
    }
  };

  const accessLabel = (id) => ACCESS_LEVELS.find(a => a.id === id)?.label || `Level ${id ?? '?'}`;

  return (
    <AccountLayout
      pageTitle="Team Members"
      breadcrumbs={[
        { label: 'Dashboard', to: '/dashboard' },
        { label: 'Team Members' },
      ]}
    >
      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6 max-w-5xl mx-auto">
        <div className="flex items-start justify-between gap-4 mb-4">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Team Members</h1>
            <p className="text-sm text-gray-500 mt-1">
              People with access to <span className="font-semibold">{Business?.BusinessName || 'this business'}</span>.
            </p>
          </div>
          {!showAdd && (
            <button
              type="button"
              onClick={() => setShowAdd(true)}
              className="bg-[#3D6B34] hover:bg-[#2f5427] text-white rounded-lg px-4 py-2 text-sm font-semibold whitespace-nowrap"
            >
              + Add User
            </button>
          )}
        </div>

        {error && (
          <div className="bg-red-50 border border-red-300 text-red-700 rounded px-3 py-2 text-sm mb-4">
            {error}
          </div>
        )}
        {savedMessage && (
          <div className="bg-green-50 border border-green-300 text-green-700 rounded px-3 py-2 text-sm mb-4">
            {savedMessage}
          </div>
        )}

        {showAdd && (
          <form
            onSubmit={handleAdd}
            className="bg-gray-50 border border-gray-200 rounded-xl p-4 mb-6"
          >
            <h2 className="text-sm font-semibold text-gray-700 mb-3">Add a user</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
              <div className="md:col-span-2">
                <label className="block text-xs font-semibold text-gray-600 mb-1">Email *</label>
                <input
                  type="email"
                  required
                  value={addForm.Email}
                  onChange={e => setAddForm(f => ({ ...f, Email: e.target.value }))}
                  className="w-full border border-gray-300 rounded px-3 py-2 text-sm"
                  placeholder="user@example.com"
                />
                <p className="text-[11px] text-gray-500 mt-1">
                  If they already have an Oatmeal account, we'll attach them. Otherwise we'll create one — first/last name required in that case.
                </p>
              </div>
              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1">First name</label>
                <input
                  type="text"
                  value={addForm.PeopleFirstName}
                  onChange={e => setAddForm(f => ({ ...f, PeopleFirstName: e.target.value }))}
                  className="w-full border border-gray-300 rounded px-3 py-2 text-sm"
                />
              </div>
              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1">Last name</label>
                <input
                  type="text"
                  value={addForm.PeopleLastName}
                  onChange={e => setAddForm(f => ({ ...f, PeopleLastName: e.target.value }))}
                  className="w-full border border-gray-300 rounded px-3 py-2 text-sm"
                />
              </div>
              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1">Access level</label>
                <select
                  value={addForm.AccessLevelID}
                  onChange={e => setAddForm(f => ({ ...f, AccessLevelID: parseInt(e.target.value, 10) }))}
                  className="w-full border border-gray-300 rounded px-3 py-2 text-sm"
                >
                  {ACCESS_LEVELS.map(a => (
                    <option key={a.id} value={a.id}>{a.label}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1">Role</label>
                <input
                  type="text"
                  value={addForm.Role}
                  onChange={e => setAddForm(f => ({ ...f, Role: e.target.value }))}
                  className="w-full border border-gray-300 rounded px-3 py-2 text-sm"
                  placeholder="Staff, Manager, etc."
                />
              </div>
            </div>
            <div className="flex justify-end gap-2 mt-4">
              <button
                type="button"
                onClick={() => setShowAdd(false)}
                className="border border-gray-300 rounded px-4 py-2 text-sm text-gray-700 hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                type="submit"
                disabled={addBusy || !addForm.Email.trim()}
                className="bg-[#3D6B34] hover:bg-[#2f5427] text-white rounded px-4 py-2 text-sm font-semibold disabled:opacity-50"
              >
                {addBusy ? 'Adding…' : 'Add User'}
              </button>
            </div>
          </form>
        )}

        {loading ? (
          <p className="text-gray-500 text-sm">Loading team members…</p>
        ) : members.length === 0 ? (
          <p className="text-gray-500 text-sm italic">No team members yet.</p>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-xs uppercase tracking-wide text-gray-500 border-b border-gray-200">
                  <th className="py-2 pr-3">Name</th>
                  <th className="py-2 pr-3">Email</th>
                  <th className="py-2 pr-3">Access</th>
                  <th className="py-2 pr-3">Role</th>
                  <th className="py-2 pr-3">Status</th>
                  <th className="py-2 pr-3 text-right">Actions</th>
                </tr>
              </thead>
              <tbody>
                {members.map(m => {
                  const isEditing = editingId === m.BusinessAccessID;
                  const isSelf = m.PeopleID === PeopleID;
                  const isActive = Number(m.Active) === 1;
                  const fullName = `${m.PeopleFirstName || ''} ${m.PeopleLastName || ''}`.trim() || '—';
                  return (
                    <tr key={m.BusinessAccessID} className="border-b border-gray-100">
                      <td className="py-2 pr-3 text-gray-800">
                        {fullName}
                        {isSelf && <span className="ml-2 text-[10px] uppercase tracking-wide text-gray-400">You</span>}
                      </td>
                      <td className="py-2 pr-3 text-gray-600">{m.PeopleEmail || '—'}</td>
                      <td className="py-2 pr-3">
                        {isEditing ? (
                          <select
                            value={editForm.AccessLevelID}
                            onChange={e => setEditForm(f => ({ ...f, AccessLevelID: parseInt(e.target.value, 10) }))}
                            className="border border-gray-300 rounded px-2 py-1 text-xs"
                          >
                            {ACCESS_LEVELS.map(a => (
                              <option key={a.id} value={a.id}>{a.label}</option>
                            ))}
                          </select>
                        ) : (
                          accessLabel(m.AccessLevelID)
                        )}
                      </td>
                      <td className="py-2 pr-3">
                        {isEditing ? (
                          <input
                            type="text"
                            value={editForm.Role}
                            onChange={e => setEditForm(f => ({ ...f, Role: e.target.value }))}
                            className="border border-gray-300 rounded px-2 py-1 text-xs w-32"
                          />
                        ) : (
                          m.Role || '—'
                        )}
                      </td>
                      <td className="py-2 pr-3">
                        {isActive ? (
                          <span className="text-green-700 text-xs font-semibold">Active</span>
                        ) : (
                          <span className="text-gray-400 text-xs">Revoked</span>
                        )}
                      </td>
                      <td className="py-2 pr-3">
                        <div className="flex justify-end gap-2">
                          {isEditing ? (
                            <>
                              <button
                                type="button"
                                onClick={() => setEditingId(null)}
                                className="text-xs border border-gray-300 rounded px-3 py-1 text-gray-700 hover:bg-gray-50"
                              >
                                Cancel
                              </button>
                              <button
                                type="button"
                                disabled={editBusy}
                                onClick={() => handleSaveEdit(m.BusinessAccessID)}
                                className="text-xs bg-[#3D6B34] hover:bg-[#2f5427] text-white rounded px-3 py-1 font-semibold disabled:opacity-50"
                              >
                                {editBusy ? 'Saving…' : 'Save'}
                              </button>
                            </>
                          ) : isActive ? (
                            <>
                              <button
                                type="button"
                                onClick={() => startEdit(m)}
                                className="text-xs border border-gray-300 rounded px-3 py-1 text-gray-700 hover:bg-gray-50"
                              >
                                Edit
                              </button>
                              <button
                                type="button"
                                onClick={() => handleDelete(m)}
                                disabled={isSelf}
                                title={isSelf ? "You can't remove yourself." : ''}
                                className="text-xs border border-red-300 rounded px-3 py-1 text-red-700 hover:bg-red-50 disabled:opacity-40 disabled:cursor-not-allowed"
                              >
                                Remove
                              </button>
                            </>
                          ) : (
                            <>
                              <button
                                type="button"
                                onClick={() => handleReactivate(m)}
                                className="text-xs bg-[#3D6B34] hover:bg-[#2f5427] text-white rounded px-3 py-1 font-semibold"
                              >
                                Reactivate
                              </button>
                              <button
                                type="button"
                                onClick={() => handleDelete(m, true)}
                                disabled={isSelf}
                                title={isSelf ? "You can't delete your own row." : 'Permanently delete this row from the database.'}
                                className="text-xs border border-red-300 rounded px-3 py-1 text-red-700 hover:bg-red-50 disabled:opacity-40 disabled:cursor-not-allowed"
                              >
                                Delete forever
                              </button>
                            </>
                          )}
                        </div>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}

        <div className="mt-6">
          <Link
            to="/dashboard"
            className="text-sm text-[#3D6B34] hover:underline"
          >
            ← Back to Dashboard
          </Link>
        </div>
      </div>
    </AccountLayout>
  );
}
