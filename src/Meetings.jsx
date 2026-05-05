import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';

const API = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

function auth() {
  return { Authorization: `Bearer ${localStorage.getItem('access_token')}` };
}

async function apiFetch(path, opts = {}) {
  const r = await fetch(`${API}${path}`, {
    headers: { 'Content-Type': 'application/json', ...auth(), ...(opts.headers || {}) },
    ...opts,
  });
  if (!r.ok) {
    const msg = await r.json().catch(() => ({ detail: `HTTP ${r.status}` }));
    throw new Error(msg.detail || 'Request failed');
  }
  return r.json();
}

const STATUS_LABELS = {
  draft:         { label: 'Draft',         color: '#6b7280' },
  agenda_sent:   { label: 'Agenda Sent',   color: '#2563eb' },
  minutes:       { label: 'In Minutes',    color: '#d97706' },
  minutes_sent:  { label: 'Minutes Sent',  color: '#16a34a' },
};

const SCOPE_OPTIONS = [
  { value: 'none',    label: 'None' },
  { value: 'company', label: 'Company-Wide Accounting' },
  { value: 'project', label: 'Project Accounting' },
];

function Badge({ status }) {
  const s = STATUS_LABELS[status] || { label: status, color: '#6b7280' };
  return (
    <span style={{
      background: s.color, color: '#fff', borderRadius: 4,
      padding: '2px 8px', fontSize: 11, fontWeight: 600,
    }}>{s.label}</span>
  );
}

function Btn({ onClick, children, variant = 'primary', disabled, small, danger }) {
  const bg = danger ? '#dc2626' : variant === 'secondary' ? '#fff' : '#3D6B34';
  const color = (variant === 'secondary' && !danger) ? '#374151' : '#fff';
  const border = variant === 'secondary' ? '1px solid #d1d5db' : 'none';
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      style={{
        background: bg, color, border, borderRadius: 6,
        padding: small ? '4px 10px' : '7px 16px',
        fontSize: small ? 12 : 13, fontWeight: 600, cursor: disabled ? 'not-allowed' : 'pointer',
        opacity: disabled ? 0.5 : 1,
      }}
    >{children}</button>
  );
}

function Input({ label, value, onChange, type = 'text', placeholder }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
      {label && <label style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>{label}</label>}
      <input
        type={type} value={value || ''} onChange={e => onChange(e.target.value)}
        placeholder={placeholder}
        style={{
          border: '1px solid #d1d5db', borderRadius: 6, padding: '7px 10px',
          fontSize: 13, color: '#111',
        }}
      />
    </div>
  );
}

function Textarea({ label, value, onChange, rows = 3, placeholder }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
      {label && <label style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>{label}</label>}
      <textarea
        value={value || ''} onChange={e => onChange(e.target.value)}
        rows={rows} placeholder={placeholder}
        style={{
          border: '1px solid #d1d5db', borderRadius: 6, padding: '7px 10px',
          fontSize: 13, color: '#111', resize: 'vertical',
        }}
      />
    </div>
  );
}

function Select({ label, value, onChange, options }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
      {label && <label style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>{label}</label>}
      <select
        value={value || ''} onChange={e => onChange(e.target.value)}
        style={{
          border: '1px solid #d1d5db', borderRadius: 6, padding: '7px 10px',
          fontSize: 13, color: '#111', background: '#fff',
        }}
      >
        {options.map(o => <option key={o.value} value={o.value}>{o.label}</option>)}
      </select>
    </div>
  );
}

function Card({ children, style }) {
  return (
    <div style={{
      background: '#fff', border: '1px solid #e5e7eb',
      borderRadius: 10, padding: 20, ...style,
    }}>{children}</div>
  );
}

function SectionHeader({ title, action }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
      <h3 style={{ margin: 0, fontSize: 15, fontWeight: 700, color: '#1f2937' }}>{title}</h3>
      {action}
    </div>
  );
}

// ─── Projects Manager ─────────────────────────────────────────────────────────

function ProjectsManager({ businessId, onClose }) {
  const [projects, setProjects] = useState([]);
  const [form, setForm] = useState({ name: '', description: '', color: '#3D6B34' });
  const [saving, setSaving] = useState(false);
  const [editId, setEditId] = useState(null);

  const load = useCallback(() => {
    apiFetch(`/api/meetings/projects?business_id=${businessId}`)
      .then(setProjects).catch(() => {});
  }, [businessId]);

  useEffect(() => { load(); }, [load]);

  const save = async () => {
    setSaving(true);
    try {
      if (editId) {
        await apiFetch(`/api/meetings/projects/${editId}?business_id=${businessId}`, {
          method: 'PUT', body: JSON.stringify(form),
        });
      } else {
        await apiFetch(`/api/meetings/projects?business_id=${businessId}`, {
          method: 'POST', body: JSON.stringify(form),
        });
      }
      setForm({ name: '', description: '', color: '#3D6B34' });
      setEditId(null);
      load();
    } catch (e) { alert(e.message); }
    setSaving(false);
  };

  const del = async (id) => {
    if (!confirm('Delete this project?')) return;
    await apiFetch(`/api/meetings/projects/${id}?business_id=${businessId}`, { method: 'DELETE' });
    load();
  };

  return (
    <div style={{
      position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)',
      display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000,
    }}>
      <div style={{ background: '#fff', borderRadius: 12, width: 520, maxHeight: '80vh', overflow: 'auto', padding: 24 }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 16 }}>
          <h2 style={{ margin: 0, fontSize: 17, fontWeight: 700 }}>Manage Projects</h2>
          <button onClick={onClose} style={{ background: 'none', border: 'none', fontSize: 20, cursor: 'pointer', color: '#6b7280' }}>×</button>
        </div>

        <Card style={{ marginBottom: 16 }}>
          <div style={{ display: 'grid', gap: 10 }}>
            <Input label="Project Name" value={form.name} onChange={v => setForm(p => ({ ...p, name: v }))} />
            <Textarea label="Description" value={form.description} onChange={v => setForm(p => ({ ...p, description: v }))} rows={2} />
            <div style={{ display: 'flex', gap: 8, alignItems: 'flex-end' }}>
              <div>
                <label style={{ fontSize: 12, fontWeight: 600, color: '#374151', display: 'block', marginBottom: 4 }}>Color</label>
                <input type="color" value={form.color} onChange={e => setForm(p => ({ ...p, color: e.target.value }))}
                  style={{ height: 34, width: 50, borderRadius: 6, border: '1px solid #d1d5db', cursor: 'pointer' }} />
              </div>
              <Btn onClick={save} disabled={saving || !form.name}>
                {saving ? 'Saving…' : editId ? 'Update' : 'Add Project'}
              </Btn>
              {editId && <Btn variant="secondary" onClick={() => { setEditId(null); setForm({ name: '', description: '', color: '#3D6B34' }); }}>Cancel</Btn>}
            </div>
          </div>
        </Card>

        <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
          {projects.map(p => (
            <div key={p.ProjectID} style={{
              display: 'flex', alignItems: 'center', gap: 10,
              padding: '10px 14px', background: '#f9fafb', borderRadius: 8,
              border: '1px solid #e5e7eb',
            }}>
              <div style={{ width: 14, height: 14, borderRadius: 3, background: p.Color, flexShrink: 0 }} />
              <div style={{ flex: 1 }}>
                <div style={{ fontWeight: 600, fontSize: 13 }}>{p.Name}</div>
                {p.Description && <div style={{ fontSize: 12, color: '#6b7280' }}>{p.Description}</div>}
              </div>
              <Btn small variant="secondary" onClick={() => { setEditId(p.ProjectID); setForm({ name: p.Name, description: p.Description || '', color: p.Color || '#3D6B34' }); }}>Edit</Btn>
              <Btn small danger onClick={() => del(p.ProjectID)}>Delete</Btn>
            </div>
          ))}
          {projects.length === 0 && <p style={{ color: '#9ca3af', fontSize: 13, margin: 0 }}>No projects yet.</p>}
        </div>
      </div>
    </div>
  );
}

// ─── Meeting Editor ───────────────────────────────────────────────────────────

function MeetingEditor({ businessId, meetingId, projects, onSaved, onBack }) {
  const [meeting, setMeeting] = useState(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [toast, setToast] = useState('');
  const [addingAttendee, setAddingAttendee] = useState({ name: '', email: '' });
  const [addingSection, setAddingSection] = useState('');
  const [editSection, setEditSection] = useState(null);
  const [editItem, setEditItem] = useState(null);
  const [newItem, setNewItem] = useState({});
  const [acctSnap, setAcctSnap] = useState(null);

  const isMinutes = meeting?.status === 'minutes' || meeting?.status === 'minutes_sent';

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const d = await apiFetch(`/api/meetings/${meetingId}?business_id=${businessId}`);
      setMeeting(d);
      if (d.accounting_scope !== 'none') {
        apiFetch(`/api/meetings/${meetingId}/accounting?business_id=${businessId}&scope=${d.accounting_scope}`)
          .then(setAcctSnap).catch(() => {});
      }
    } catch (e) { alert(e.message); }
    setLoading(false);
  }, [meetingId, businessId]);

  useEffect(() => { load(); }, [load]);

  const notify = (msg) => { setToast(msg); setTimeout(() => setToast(''), 3000); };

  const saveMeta = async () => {
    setSaving(true);
    try {
      await apiFetch(`/api/meetings/${meetingId}?business_id=${businessId}`, {
        method: 'PUT', body: JSON.stringify({
          title: meeting.title, description: meeting.description,
          meeting_date: meeting.meeting_date, location: meeting.location,
          project_id: meeting.project_id, accounting_scope: meeting.accounting_scope,
        }),
      });
      notify('Saved');
      if (onSaved) onSaved();
    } catch (e) { alert(e.message); }
    setSaving(false);
  };

  const addAttendee = async () => {
    if (!addingAttendee.email) return;
    await apiFetch(`/api/meetings/${meetingId}/attendees?business_id=${businessId}`, {
      method: 'POST', body: JSON.stringify(addingAttendee),
    });
    setAddingAttendee({ name: '', email: '' });
    load();
  };

  const removeAttendee = async (id) => {
    await apiFetch(`/api/meetings/${meetingId}/attendees/${id}?business_id=${businessId}`, { method: 'DELETE' });
    load();
  };

  const addSection = async () => {
    if (!addingSection) return;
    await apiFetch(`/api/meetings/${meetingId}/sections?business_id=${businessId}`, {
      method: 'POST', body: JSON.stringify({ title: addingSection }),
    });
    setAddingSection('');
    load();
  };

  const updateSection = async (sec) => {
    await apiFetch(`/api/meetings/${meetingId}/sections/${sec.section_id}?business_id=${businessId}`, {
      method: 'PUT', body: JSON.stringify(sec),
    });
    setEditSection(null);
    load();
  };

  const deleteSection = async (id) => {
    if (!confirm('Delete this section and all its items?')) return;
    await apiFetch(`/api/meetings/${meetingId}/sections/${id}?business_id=${businessId}`, { method: 'DELETE' });
    load();
  };

  const addItem = async (sectionId) => {
    const payload = newItem[sectionId];
    if (!payload?.title) return;
    await apiFetch(`/api/meetings/${meetingId}/sections/${sectionId}/items?business_id=${businessId}`, {
      method: 'POST', body: JSON.stringify(payload),
    });
    setNewItem(p => ({ ...p, [sectionId]: {} }));
    load();
  };

  const updateItem = async (item) => {
    await apiFetch(`/api/meetings/${meetingId}/items/${item.item_id}?business_id=${businessId}`, {
      method: 'PUT', body: JSON.stringify(item),
    });
    setEditItem(null);
    load();
  };

  const deleteItem = async (itemId) => {
    if (!confirm('Delete this agenda item?')) return;
    await apiFetch(`/api/meetings/${meetingId}/items/${itemId}?business_id=${businessId}`, { method: 'DELETE' });
    load();
  };

  const updateMinutes = async (itemId, minuteData) => {
    await apiFetch(`/api/meetings/${meetingId}/items/${itemId}/minutes?business_id=${businessId}`, {
      method: 'PUT', body: JSON.stringify(minuteData),
    });
    notify('Minutes saved');
    load();
  };

  const sendAction = async (action) => {
    setSaving(true);
    try {
      const r = await apiFetch(`/api/meetings/${meetingId}/${action}?business_id=${businessId}`, { method: 'POST' });
      notify(`Sent to ${r.sent} attendee(s)${r.failed?.length ? `, ${r.failed.length} failed` : ''}`);
      load();
    } catch (e) { alert(e.message); }
    setSaving(false);
  };

  const convertToMinutes = async () => {
    if (!confirm('Convert this meeting to minutes? You will be able to edit notes per agenda item.')) return;
    await apiFetch(`/api/meetings/${meetingId}/to-minutes?business_id=${businessId}`, { method: 'POST' });
    load();
  };

  if (loading || !meeting) return <div style={{ padding: 32, color: '#6b7280' }}>Loading…</div>;

  const projectOptions = [{ value: '', label: '— No project —' }, ...projects.map(p => ({ value: String(p.ProjectID), label: p.Name }))];

  return (
    <div>
      {toast && (
        <div style={{
          position: 'fixed', top: 20, right: 20, background: '#3D6B34', color: '#fff',
          borderRadius: 8, padding: '10px 18px', zIndex: 9999, fontSize: 13, fontWeight: 600,
        }}>{toast}</div>
      )}

      {/* Back + Actions */}
      <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 16, flexWrap: 'wrap' }}>
        <Btn variant="secondary" onClick={onBack}>← Back</Btn>
        <Badge status={meeting.status} />
        <div style={{ marginLeft: 'auto', display: 'flex', gap: 8, flexWrap: 'wrap' }}>
          <Btn variant="secondary" onClick={() => sendAction('send-agenda')} disabled={saving}>📤 Email Agenda</Btn>
          {!isMinutes && <Btn variant="secondary" onClick={convertToMinutes}>📋 Start Minutes</Btn>}
          {isMinutes  && <Btn variant="secondary" onClick={() => sendAction('send-minutes')} disabled={saving}>📨 Email Minutes</Btn>}
          <Btn onClick={saveMeta} disabled={saving}>{saving ? 'Saving…' : 'Save Changes'}</Btn>
        </div>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 320px', gap: 16, alignItems: 'start' }}>

        {/* Left column — meta + sections */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>

          {/* Meeting info */}
          <Card>
            <SectionHeader title="Meeting Details" />
            <div style={{ display: 'grid', gap: 10 }}>
              <Input label="Title" value={meeting.title} onChange={v => setMeeting(p => ({ ...p, title: v }))} />
              <Textarea label="Description / Notes" value={meeting.description} onChange={v => setMeeting(p => ({ ...p, description: v }))} rows={2} />
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
                <Input label="Date & Time" type="datetime-local" value={meeting.meeting_date?.slice(0, 16)} onChange={v => setMeeting(p => ({ ...p, meeting_date: v }))} />
                <Input label="Location" value={meeting.location} onChange={v => setMeeting(p => ({ ...p, location: v }))} placeholder="Room, Zoom link, etc." />
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
                <Select label="Project" value={String(meeting.project_id || '')} onChange={v => setMeeting(p => ({ ...p, project_id: v || null }))} options={projectOptions} />
                <Select label="Include Accounting" value={meeting.accounting_scope || 'none'} onChange={v => setMeeting(p => ({ ...p, accounting_scope: v }))} options={SCOPE_OPTIONS} />
              </div>
            </div>
          </Card>

          {/* Sections */}
          {meeting.sections.map(sec => (
            <Card key={sec.section_id}>
              {editSection?.section_id === sec.section_id ? (
                <div style={{ display: 'grid', gap: 10 }}>
                  <Input label="Section Title" value={editSection.title} onChange={v => setEditSection(p => ({ ...p, title: v }))} />
                  <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
                    <Select label="Linked Project" value={String(editSection.project_id || '')} onChange={v => setEditSection(p => ({ ...p, project_id: v || null }))} options={projectOptions} />
                    <Select label="Accounting" value={editSection.accounting_scope || 'none'} onChange={v => setEditSection(p => ({ ...p, accounting_scope: v }))} options={SCOPE_OPTIONS} />
                  </div>
                  <div style={{ display: 'flex', gap: 8 }}>
                    <Btn onClick={() => updateSection(editSection)}>Save Section</Btn>
                    <Btn variant="secondary" onClick={() => setEditSection(null)}>Cancel</Btn>
                  </div>
                </div>
              ) : (
                <SectionHeader
                  title={
                    <span>
                      {sec.title}
                      {sec.project_name && (
                        <span style={{ background: '#3D6B34', color: '#fff', borderRadius: 4, padding: '1px 7px', fontSize: 11, marginLeft: 8 }}>
                          {sec.project_name}
                        </span>
                      )}
                      {sec.accounting_scope !== 'none' && (
                        <span style={{ background: '#1d4ed8', color: '#fff', borderRadius: 4, padding: '1px 7px', fontSize: 11, marginLeft: 6 }}>
                          📊 {sec.accounting_scope === 'company' ? 'Company' : 'Project'} Acct
                        </span>
                      )}
                    </span>
                  }
                  action={
                    <div style={{ display: 'flex', gap: 6 }}>
                      <Btn small variant="secondary" onClick={() => setEditSection({ ...sec })}>Edit Section</Btn>
                      <Btn small danger onClick={() => deleteSection(sec.section_id)}>Delete</Btn>
                    </div>
                  }
                />
              )}

              {/* Agenda items */}
              <div style={{ display: 'flex', flexDirection: 'column', gap: 8, marginBottom: 12 }}>
                {sec.items.map(item => (
                  <div key={item.item_id}>
                    {editItem?.item_id === item.item_id && !isMinutes ? (
                      <div style={{ background: '#f9fafb', borderRadius: 8, padding: 12, display: 'grid', gap: 8 }}>
                        <Input label="Item Title" value={editItem.title} onChange={v => setEditItem(p => ({ ...p, title: v }))} />
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 8 }}>
                          <Input label="Presenter" value={editItem.presenter} onChange={v => setEditItem(p => ({ ...p, presenter: v }))} />
                          <Input label="Duration (min)" type="number" value={editItem.duration_minutes} onChange={v => setEditItem(p => ({ ...p, duration_minutes: v }))} />
                        </div>
                        <Textarea label="Notes / Context" value={editItem.notes_template} onChange={v => setEditItem(p => ({ ...p, notes_template: v }))} rows={2} />
                        <div style={{ display: 'flex', gap: 8 }}>
                          <Btn onClick={() => updateItem(editItem)}>Save Item</Btn>
                          <Btn variant="secondary" onClick={() => setEditItem(null)}>Cancel</Btn>
                        </div>
                      </div>
                    ) : isMinutes ? (
                      <MinuteItemEditor item={item} onSave={minuteData => updateMinutes(item.item_id, minuteData)} />
                    ) : (
                      <div style={{
                        display: 'flex', alignItems: 'flex-start', gap: 10,
                        padding: '8px 12px', background: '#f9fafb', borderRadius: 8,
                        border: '1px solid #e5e7eb',
                      }}>
                        <div style={{ flex: 1 }}>
                          <div style={{ fontWeight: 600, fontSize: 13 }}>{item.title}</div>
                          <div style={{ fontSize: 12, color: '#6b7280' }}>
                            {item.presenter && <span>{item.presenter}</span>}
                            {item.duration_minutes && <span style={{ marginLeft: 8 }}>{item.duration_minutes} min</span>}
                          </div>
                          {item.notes_template && <div style={{ fontSize: 12, color: '#374151', marginTop: 4 }}>{item.notes_template}</div>}
                        </div>
                        <div style={{ display: 'flex', gap: 6, flexShrink: 0 }}>
                          <Btn small variant="secondary" onClick={() => setEditItem({ ...item })}>Edit</Btn>
                          <Btn small danger onClick={() => deleteItem(item.item_id)}>×</Btn>
                        </div>
                      </div>
                    )}
                  </div>
                ))}
              </div>

              {/* Add item form */}
              {!isMinutes && (
                <div style={{ display: 'grid', gridTemplateColumns: '1fr auto auto auto', gap: 8, alignItems: 'end' }}>
                  <Input
                    placeholder="New agenda item…"
                    value={newItem[sec.section_id]?.title || ''}
                    onChange={v => setNewItem(p => ({ ...p, [sec.section_id]: { ...p[sec.section_id], title: v } }))}
                  />
                  <Input
                    placeholder="Presenter"
                    value={newItem[sec.section_id]?.presenter || ''}
                    onChange={v => setNewItem(p => ({ ...p, [sec.section_id]: { ...p[sec.section_id], presenter: v } }))}
                  />
                  <Input
                    type="number" placeholder="Min"
                    value={newItem[sec.section_id]?.duration_minutes || ''}
                    onChange={v => setNewItem(p => ({ ...p, [sec.section_id]: { ...p[sec.section_id], duration_minutes: v } }))}
                  />
                  <Btn onClick={() => addItem(sec.section_id)}>+ Add</Btn>
                </div>
              )}
            </Card>
          ))}

          {/* Add section */}
          {!isMinutes && (
            <div style={{ display: 'flex', gap: 8 }}>
              <input
                value={addingSection}
                onChange={e => setAddingSection(e.target.value)}
                onKeyDown={e => e.key === 'Enter' && addSection()}
                placeholder="New section title…"
                style={{
                  flex: 1, border: '1px dashed #d1d5db', borderRadius: 8,
                  padding: '10px 14px', fontSize: 13, color: '#374151',
                }}
              />
              <Btn onClick={addSection}>+ Add Section</Btn>
            </div>
          )}
        </div>

        {/* Right column — attendees + accounting preview */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>

          {/* Attendees */}
          <Card>
            <SectionHeader title="Attendees" />
            <div style={{ display: 'flex', flexDirection: 'column', gap: 8, marginBottom: 12 }}>
              {meeting.attendees.map(a => (
                <div key={a.attendee_id} style={{
                  display: 'flex', alignItems: 'center', gap: 8,
                  padding: '6px 10px', background: '#f9fafb', borderRadius: 6,
                }}>
                  <div style={{ flex: 1 }}>
                    <div style={{ fontWeight: 600, fontSize: 13 }}>{a.name}</div>
                    <div style={{ fontSize: 12, color: '#6b7280' }}>{a.email}</div>
                  </div>
                  <button onClick={() => removeAttendee(a.attendee_id)}
                    style={{ background: 'none', border: 'none', color: '#dc2626', cursor: 'pointer', fontSize: 16 }}>×</button>
                </div>
              ))}
              {meeting.attendees.length === 0 && (
                <p style={{ color: '#9ca3af', fontSize: 12, margin: 0 }}>No attendees added yet.</p>
              )}
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
              <Input placeholder="Name" value={addingAttendee.name} onChange={v => setAddingAttendee(p => ({ ...p, name: v }))} />
              <Input type="email" placeholder="Email" value={addingAttendee.email} onChange={v => setAddingAttendee(p => ({ ...p, email: v }))} />
              <Btn onClick={addAttendee}>+ Add Attendee</Btn>
            </div>
          </Card>

          {/* Accounting preview */}
          {acctSnap && (
            <Card>
              <SectionHeader title={acctSnap.label || 'Accounting Summary'} />
              <p style={{ margin: '0 0 10px', fontSize: 11, color: '#6b7280' }}>YTD {new Date().getFullYear()} — included in emailed agenda/minutes</p>
              <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
                <AccountingRow label="Revenue" value={acctSnap.revenue} color="#166534" />
                <AccountingRow label="Expenses" value={acctSnap.expenses} color="#991b1b" />
                <div style={{ borderTop: '1px solid #e5e7eb', paddingTop: 6 }}>
                  <AccountingRow label="Net Income" value={acctSnap.revenue - acctSnap.expenses}
                    color={(acctSnap.revenue - acctSnap.expenses) >= 0 ? '#166534' : '#b91c1c'} bold />
                </div>
                {acctSnap.outstanding_invoices > 0 && (
                  <AccountingRow label="Outstanding Invoices" value={acctSnap.outstanding_invoices} color="#92400e" small />
                )}
                {acctSnap.outstanding_bills > 0 && (
                  <AccountingRow label="Outstanding Bills" value={acctSnap.outstanding_bills} color="#92400e" small />
                )}
              </div>
            </Card>
          )}
        </div>
      </div>
    </div>
  );
}

function AccountingRow({ label, value, color, bold, small }) {
  return (
    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
      <span style={{ fontSize: small ? 12 : 13, color: '#374151' }}>{label}</span>
      <span style={{ fontSize: small ? 12 : 13, fontWeight: bold ? 700 : 600, color }}>
        ${(value || 0).toLocaleString('en-US', { minimumFractionDigits: 2 })}
      </span>
    </div>
  );
}

function MinuteItemEditor({ item, onSave }) {
  const [data, setData] = useState(
    item.minutes || { notes: '', decisions: '', action_items: '', assigned_to: '', due_date: '' }
  );
  const [open, setOpen] = useState(false);
  const [saving, setSaving] = useState(false);

  const save = async () => {
    setSaving(true);
    await onSave(data);
    setSaving(false);
  };

  return (
    <div style={{ border: '1px solid #e5e7eb', borderRadius: 8, overflow: 'hidden' }}>
      <button
        onClick={() => setOpen(p => !p)}
        style={{
          width: '100%', display: 'flex', alignItems: 'center', justifyContent: 'space-between',
          padding: '8px 12px', background: '#f9fafb', border: 'none', cursor: 'pointer',
          fontWeight: 600, fontSize: 13, color: '#1f2937',
        }}
      >
        <span>{item.title}</span>
        <span style={{ fontSize: 11, color: '#6b7280' }}>
          {item.duration_minutes ? `${item.duration_minutes} min` : ''}
          {item.presenter ? ` · ${item.presenter}` : ''}
          {open ? ' ▲' : ' ▼'}
        </span>
      </button>
      {open && (
        <div style={{ padding: 12, display: 'flex', flexDirection: 'column', gap: 8 }}>
          <Textarea label="Discussion Notes" value={data.notes} onChange={v => setData(p => ({ ...p, notes: v }))} rows={3} />
          <Textarea label="Decisions Made" value={data.decisions} onChange={v => setData(p => ({ ...p, decisions: v }))} rows={2} />
          <Textarea label="Action Items" value={data.action_items} onChange={v => setData(p => ({ ...p, action_items: v }))} rows={2} />
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 8 }}>
            <Input label="Assigned To" value={data.assigned_to} onChange={v => setData(p => ({ ...p, assigned_to: v }))} />
            <Input label="Due Date" type="date" value={data.due_date} onChange={v => setData(p => ({ ...p, due_date: v }))} />
          </div>
          <Btn onClick={save} disabled={saving}>{saving ? 'Saving…' : 'Save Minutes'}</Btn>
        </div>
      )}
    </div>
  );
}

// ─── Meetings List ────────────────────────────────────────────────────────────

function MeetingsList({ businessId, projects, onEdit, onCreate }) {
  const [meetings, setMeetings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [statusFilter, setStatusFilter] = useState('');

  const load = useCallback(async () => {
    setLoading(true);
    const qs = statusFilter ? `&status=${statusFilter}` : '';
    const d = await apiFetch(`/api/meetings?business_id=${businessId}${qs}`).catch(() => ({ meetings: [] }));
    setMeetings(d.meetings || []);
    setLoading(false);
  }, [businessId, statusFilter]);

  useEffect(() => { load(); }, [load]);

  const del = async (id) => {
    if (!confirm('Delete this meeting and all its data?')) return;
    await apiFetch(`/api/meetings/${id}?business_id=${businessId}`, { method: 'DELETE' });
    load();
  };

  const fmtDate = (d) => {
    if (!d) return '—';
    return new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric', hour: '2-digit', minute: '2-digit' });
  };

  return (
    <div>
      <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 16, flexWrap: 'wrap' }}>
        <select
          value={statusFilter}
          onChange={e => setStatusFilter(e.target.value)}
          style={{ border: '1px solid #d1d5db', borderRadius: 6, padding: '6px 10px', fontSize: 13 }}
        >
          <option value="">All Statuses</option>
          {Object.entries(STATUS_LABELS).map(([k, v]) => (
            <option key={k} value={k}>{v.label}</option>
          ))}
        </select>
        <div style={{ marginLeft: 'auto' }}>
          <Btn onClick={onCreate}>+ New Meeting</Btn>
        </div>
      </div>

      {loading ? (
        <div style={{ color: '#6b7280', padding: 24 }}>Loading…</div>
      ) : meetings.length === 0 ? (
        <Card>
          <p style={{ color: '#9ca3af', margin: 0, textAlign: 'center', padding: '24px 0' }}>
            No meetings yet. Create your first meeting to get started.
          </p>
        </Card>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          {meetings.map(m => (
            <Card key={m.MeetingID} style={{ cursor: 'default' }}>
              <div style={{ display: 'flex', alignItems: 'flex-start', gap: 12 }}>
                <div style={{ flex: 1 }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 4 }}>
                    <span style={{ fontWeight: 700, fontSize: 14, color: '#1f2937' }}>{m.Title}</span>
                    <Badge status={m.Status} />
                    {m.ProjectName && (
                      <span style={{
                        background: m.ProjectColor || '#3D6B34', color: '#fff',
                        borderRadius: 4, padding: '1px 7px', fontSize: 11, fontWeight: 600,
                      }}>{m.ProjectName}</span>
                    )}
                  </div>
                  <div style={{ fontSize: 12, color: '#6b7280', display: 'flex', gap: 12 }}>
                    <span>📅 {fmtDate(m.MeetingDate)}</span>
                    {m.Location && <span>📍 {m.Location}</span>}
                    <span>👥 {m.AttendeeCount} attendee{m.AttendeeCount !== 1 ? 's' : ''}</span>
                    <span>📋 {m.ItemCount} item{m.ItemCount !== 1 ? 's' : ''}</span>
                  </div>
                </div>
                <div style={{ display: 'flex', gap: 6, flexShrink: 0 }}>
                  <Btn small onClick={() => onEdit(m.MeetingID)}>Open</Btn>
                  <Btn small danger onClick={() => del(m.MeetingID)}>Delete</Btn>
                </div>
              </div>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}

// ─── New Meeting Modal ────────────────────────────────────────────────────────

function NewMeetingModal({ businessId, projects, onCreated, onClose }) {
  const [form, setForm] = useState({
    title: '', description: '', meeting_date: '', location: '',
    project_id: '', accounting_scope: 'none',
  });
  const [saving, setSaving] = useState(false);

  const create = async () => {
    if (!form.title) return;
    setSaving(true);
    try {
      const r = await apiFetch(`/api/meetings?business_id=${businessId}`, {
        method: 'POST', body: JSON.stringify({ ...form, project_id: form.project_id || null }),
      });
      onCreated(r.meeting_id);
    } catch (e) { alert(e.message); }
    setSaving(false);
  };

  const projectOptions = [
    { value: '', label: '— No project —' },
    ...projects.map(p => ({ value: String(p.ProjectID), label: p.Name })),
  ];

  return (
    <div style={{
      position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)',
      display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000,
    }}>
      <div style={{ background: '#fff', borderRadius: 12, width: 520, padding: 24 }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 16 }}>
          <h2 style={{ margin: 0, fontSize: 17, fontWeight: 700 }}>New Meeting</h2>
          <button onClick={onClose} style={{ background: 'none', border: 'none', fontSize: 20, cursor: 'pointer', color: '#6b7280' }}>×</button>
        </div>
        <div style={{ display: 'grid', gap: 10 }}>
          <Input label="Meeting Title *" value={form.title} onChange={v => setForm(p => ({ ...p, title: v }))} />
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
            <Input label="Date & Time" type="datetime-local" value={form.meeting_date} onChange={v => setForm(p => ({ ...p, meeting_date: v }))} />
            <Input label="Location" value={form.location} onChange={v => setForm(p => ({ ...p, location: v }))} placeholder="Room, Zoom, etc." />
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
            <Select label="Project" value={form.project_id} onChange={v => setForm(p => ({ ...p, project_id: v }))} options={projectOptions} />
            <Select label="Include Accounting" value={form.accounting_scope} onChange={v => setForm(p => ({ ...p, accounting_scope: v }))} options={SCOPE_OPTIONS} />
          </div>
          <Textarea label="Description" value={form.description} onChange={v => setForm(p => ({ ...p, description: v }))} rows={2} />
          <div style={{ display: 'flex', gap: 8, justifyContent: 'flex-end', marginTop: 4 }}>
            <Btn variant="secondary" onClick={onClose}>Cancel</Btn>
            <Btn onClick={create} disabled={saving || !form.title}>{saving ? 'Creating…' : 'Create Meeting'}</Btn>
          </div>
        </div>
      </div>
    </div>
  );
}

// ─── Root ─────────────────────────────────────────────────────────────────────

export default function Meetings() {
  const [params] = useSearchParams();
  const businessId = parseInt(params.get('BusinessID') || '0', 10);

  const [view, setView]             = useState('list'); // list | editor
  const [editMeetingId, setEditMeetingId] = useState(null);
  const [showNewModal, setShowNewModal]   = useState(false);
  const [showProjects, setShowProjects]   = useState(false);
  const [projects, setProjects]     = useState([]);

  const loadProjects = useCallback(() => {
    if (!businessId) return;
    apiFetch(`/api/meetings/projects?business_id=${businessId}`)
      .then(setProjects).catch(() => {});
  }, [businessId]);

  useEffect(() => { loadProjects(); }, [loadProjects]);

  const openEditor = (id) => { setEditMeetingId(id); setView('editor'); };
  const backToList  = () => { setView('list'); setEditMeetingId(null); };

  if (!businessId) {
    return (
      <AccountLayout pageTitle="Meetings">
        <p style={{ color: '#6b7280' }}>No business selected. Select a business from the sidebar.</p>
      </AccountLayout>
    );
  }

  return (
    <AccountLayout
      pageTitle="Meetings"
      breadcrumbs={[
        { label: 'Dashboard', to: '/dashboard' },
        { label: 'Meetings', to: `/meetings?BusinessID=${businessId}` },
        ...(view === 'editor' ? [{ label: 'Edit Meeting' }] : []),
      ]}
    >
      <div style={{ maxWidth: 1100, margin: '0 auto' }}>

        {/* Page header */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 20 }}>
          <div>
            <h1 style={{ margin: 0, fontSize: 22, fontWeight: 700, color: '#1f2937' }}>
              {view === 'editor' ? 'Meeting Editor' : 'Meetings'}
            </h1>
            <p style={{ margin: '2px 0 0', fontSize: 13, color: '#6b7280' }}>
              Build agendas, record minutes, and email to attendees
            </p>
          </div>
          {view === 'list' && (
            <div style={{ marginLeft: 'auto', display: 'flex', gap: 8 }}>
              <Btn variant="secondary" onClick={() => setShowProjects(true)}>⚙ Projects</Btn>
            </div>
          )}
        </div>

        {view === 'list' ? (
          <MeetingsList
            businessId={businessId}
            projects={projects}
            onEdit={openEditor}
            onCreate={() => setShowNewModal(true)}
          />
        ) : (
          <MeetingEditor
            businessId={businessId}
            meetingId={editMeetingId}
            projects={projects}
            onSaved={() => {}}
            onBack={backToList}
          />
        )}

        {showNewModal && (
          <NewMeetingModal
            businessId={businessId}
            projects={projects}
            onCreated={(id) => { setShowNewModal(false); openEditor(id); }}
            onClose={() => setShowNewModal(false)}
          />
        )}

        {showProjects && (
          <ProjectsManager
            businessId={businessId}
            onClose={() => { setShowProjects(false); loadProjects(); }}
          />
        )}
      </div>
    </AccountLayout>
  );
}
