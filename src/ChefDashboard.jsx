import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import PairsleyChat from './PairsleyChat';

const SAIGE_API = import.meta.env.VITE_SAIGE_API_URL || 'http://localhost:8000/saige';

function authHeaders() {
  const token = localStorage.getItem('access_token') || localStorage.getItem('AccessToken');
  return {
    'Content-Type': 'application/json',
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
  };
}

async function apiGet(path) {
  const r = await fetch(`${SAIGE_API}${path}`, { headers: authHeaders() });
  if (!r.ok) throw new Error(`HTTP ${r.status}`);
  return r.json();
}

async function apiSend(method, path, body) {
  const r = await fetch(`${SAIGE_API}${path}`, {
    method,
    headers: authHeaders(),
    body: body != null ? JSON.stringify(body) : undefined,
  });
  if (!r.ok) throw new Error(`HTTP ${r.status}`);
  return r.json();
}

// ─── Recipes & Costing ────────────────────────────────────────────────────────

function RecipesSection({ businessId }) {
  const [recipes, setRecipes]   = useState([]);
  const [loading, setLoading]   = useState(true);
  const [error, setError]       = useState('');
  const [costing, setCosting]   = useState({}); // { [recipeId]: reportString | '...' }
  const [openId, setOpenId]     = useState(null);
  const [creating, setCreating] = useState(false);

  const load = useCallback(async () => {
    if (!businessId) return;
    setLoading(true); setError('');
    try {
      const data = await apiGet(`/chef/recipes?business_id=${businessId}`);
      setRecipes(data.recipes || []);
    } catch (e) { setError(e.message); }
    finally { setLoading(false); }
  }, [businessId]);

  useEffect(() => { load(); }, [load]);

  const costRecipe = async (id) => {
    setCosting((c) => ({ ...c, [id]: '...' }));
    try {
      const data = await apiGet(`/chef/recipes/${id}/cost?business_id=${businessId}`);
      setCosting((c) => ({ ...c, [id]: data.report || '(no report)' }));
    } catch (e) {
      setCosting((c) => ({ ...c, [id]: `Error: ${e.message}` }));
    }
  };

  const deleteRecipe = async (id) => {
    if (!window.confirm('Delete this recipe?')) return;
    try {
      await apiSend('DELETE', `/chef/recipes/${id}?business_id=${businessId}`);
      await load();
    } catch (e) { alert(e.message); }
  };

  return (
    <section style={{ background: '#fff', border: '1px solid #e5e7eb', borderRadius: 12, padding: 18, marginBottom: 16 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
        <h2 style={{ margin: 0, fontSize: 18, color: '#14532d' }}>Recipes &amp; Plate Costing</h2>
        <button onClick={() => setCreating((v) => !v)} className="regsubmit2" style={{ minWidth: 140 }}>
          {creating ? 'Close' : '+ New recipe'}
        </button>
      </div>

      {creating && (
        <NewRecipeForm
          businessId={businessId}
          onCreated={() => { setCreating(false); load(); }}
        />
      )}

      {loading && <div style={{ color: '#6b7280' }}>Loading…</div>}
      {error && <div style={{ color: '#991b1b' }}>{error}</div>}
      {!loading && !recipes.length && <div style={{ color: '#6b7280' }}>No recipes yet. Save one to track live plate costs.</div>}

      <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
        {recipes.map((r) => {
          const id = r.recipeid;
          const isOpen = openId === id;
          return (
            <div key={id} style={{ border: '1px solid #e5e7eb', borderRadius: 10, padding: 12 }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div>
                  <div style={{ fontWeight: 600, color: '#111827' }}>{r.name}</div>
                  <div style={{ fontSize: 12, color: '#6b7280' }}>
                    Yields {r.portionyield || 1} portion(s)
                    {r.menuprice ? ` · menu $${Number(r.menuprice).toFixed(2)}` : ''}
                  </div>
                </div>
                <div style={{ display: 'flex', gap: 6 }}>
                  <button onClick={() => setOpenId(isOpen ? null : id)} style={btnGhost}>{isOpen ? 'Hide' : 'Items'}</button>
                  <button onClick={() => costRecipe(id)} style={btnPrimary}>Cost now</button>
                  <button onClick={() => deleteRecipe(id)} style={btnDanger}>Delete</button>
                </div>
              </div>
              {isOpen && <RecipeItems recipeId={id} />}
              {costing[id] && (
                <pre style={reportBox}>{costing[id]}</pre>
              )}
            </div>
          );
        })}
      </div>
    </section>
  );
}

function RecipeItems({ recipeId }) {
  const [items, setItems] = useState([]);
  useEffect(() => {
    apiGet(`/chef/recipes/${recipeId}/items`).then(d => setItems(d.items || [])).catch(() => {});
  }, [recipeId]);
  if (!items.length) return <div style={{ marginTop: 8, fontSize: 12, color: '#6b7280' }}>No items saved.</div>;
  return (
    <ul style={{ marginTop: 8, fontSize: 13, color: '#374151' }}>
      {items.map((i) => (
        <li key={i.itemid}>{i.quantity || '—'} {i.unit || ''} {i.ingredientname}</li>
      ))}
    </ul>
  );
}

function NewRecipeForm({ businessId, onCreated }) {
  const [name, setName]     = useState('');
  const [yld, setYld]       = useState(1);
  const [price, setPrice]   = useState('');
  const [rows, setRows]     = useState([{ ingredient: '', qty: '', unit: '' }]);
  const [saving, setSaving] = useState(false);
  const [error, setError]   = useState('');

  const addRow = () => setRows([...rows, { ingredient: '', qty: '', unit: '' }]);
  const setRow = (i, k, v) => setRows(rows.map((r, j) => (i === j ? { ...r, [k]: v } : r)));
  const removeRow = (i) => setRows(rows.filter((_, j) => j !== i));

  const submit = async (e) => {
    e.preventDefault();
    if (!name.trim()) return setError('Give the recipe a name.');
    const items = rows
      .filter((r) => r.ingredient.trim())
      .map((r) => ({ ingredient: r.ingredient.trim(), qty: Number(r.qty) || 0, unit: r.unit.trim() }));
    if (!items.length) return setError('Add at least one ingredient line.');
    setSaving(true); setError('');
    try {
      await apiSend('POST', '/chef/recipes', {
        business_id:   Number(businessId),
        name:          name.trim(),
        portion_yield: Number(yld) || 1,
        menu_price:    price ? Number(price) : null,
        items,
      });
      onCreated();
    } catch (e) { setError(e.message); }
    finally { setSaving(false); }
  };

  return (
    <form onSubmit={submit} style={{ background: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: 10, padding: 12, marginBottom: 12 }}>
      <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr 1fr', gap: 8, marginBottom: 8 }}>
        <input placeholder="Recipe name (e.g. Summer Burger)" value={name} onChange={(e) => setName(e.target.value)} style={inp} />
        <input placeholder="Yield (plates)" type="number" min={1} value={yld} onChange={(e) => setYld(e.target.value)} style={inp} />
        <input placeholder="Menu price $ (optional)" type="number" step="0.01" value={price} onChange={(e) => setPrice(e.target.value)} style={inp} />
      </div>
      <div style={{ fontSize: 12, fontWeight: 600, marginBottom: 4, color: '#374151' }}>Ingredients</div>
      {rows.map((r, i) => (
        <div key={i} style={{ display: 'grid', gridTemplateColumns: '2fr 1fr 1fr auto', gap: 8, marginBottom: 6 }}>
          <input placeholder="Ingredient (e.g. ground beef)" value={r.ingredient} onChange={(e) => setRow(i, 'ingredient', e.target.value)} style={inp} />
          <input placeholder="Qty" type="number" step="0.01" value={r.qty} onChange={(e) => setRow(i, 'qty', e.target.value)} style={inp} />
          <input placeholder="Unit (lb, oz, each)" value={r.unit} onChange={(e) => setRow(i, 'unit', e.target.value)} style={inp} />
          <button type="button" onClick={() => removeRow(i)} style={btnGhost} disabled={rows.length === 1}>×</button>
        </div>
      ))}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 8 }}>
        <button type="button" onClick={addRow} style={btnGhost}>+ Add line</button>
        <div style={{ display: 'flex', gap: 6, alignItems: 'center' }}>
          {error && <span style={{ fontSize: 12, color: '#991b1b' }}>{error}</span>}
          <button type="submit" disabled={saving} style={btnPrimary}>{saving ? 'Saving…' : 'Save recipe'}</button>
        </div>
      </div>
    </form>
  );
}

// ─── Par Levels ───────────────────────────────────────────────────────────────

function ParSection({ businessId }) {
  const [items, setItems]       = useState([]);
  const [loading, setLoading]   = useState(true);
  const [error, setError]       = useState('');
  const [restock, setRestock]   = useState('');
  const [adding, setAdding]     = useState(false);

  const load = useCallback(async () => {
    if (!businessId) return;
    setLoading(true); setError('');
    try {
      const data = await apiGet(`/chef/par?business_id=${businessId}`);
      setItems(data.par || []);
    } catch (e) { setError(e.message); }
    finally { setLoading(false); }
  }, [businessId]);

  useEffect(() => { load(); }, [load]);

  const draftRestock = async () => {
    setRestock('…');
    try {
      const data = await apiSend('POST', `/chef/restock-draft?business_id=${businessId}`);
      setRestock(data.report || '(none)');
    } catch (e) { setRestock(`Error: ${e.message}`); }
  };

  const removeRow = async (id) => {
    if (!window.confirm('Remove this par item?')) return;
    try {
      await apiSend('DELETE', `/chef/par/${id}?business_id=${businessId}`);
      await load();
    } catch (e) { alert(e.message); }
  };

  const below = items.filter((i) => i.onhand != null && i.reorderat != null && Number(i.onhand) <= Number(i.reorderat));

  return (
    <section style={{ background: '#fff', border: '1px solid #e5e7eb', borderRadius: 12, padding: 18, marginBottom: 16 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
        <h2 style={{ margin: 0, fontSize: 18, color: '#14532d' }}>
          Par Levels{below.length ? ` · ${below.length} below threshold` : ''}
        </h2>
        <div style={{ display: 'flex', gap: 6 }}>
          <button onClick={() => setAdding((v) => !v)} style={btnGhost}>{adding ? 'Close' : '+ Add item'}</button>
          <button onClick={draftRestock} style={btnPrimary} disabled={!items.length}>Draft restock order</button>
        </div>
      </div>

      {adding && <NewParForm businessId={businessId} onSaved={() => { setAdding(false); load(); }} />}

      {loading && <div style={{ color: '#6b7280' }}>Loading…</div>}
      {error && <div style={{ color: '#991b1b' }}>{error}</div>}
      {!loading && !items.length && <div style={{ color: '#6b7280' }}>No par items set. Add one to start tracking restocks.</div>}

      {!!items.length && (
        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 13 }}>
          <thead>
            <tr style={{ textAlign: 'left', color: '#6b7280' }}>
              <th style={th}>Ingredient</th>
              <th style={th}>Unit</th>
              <th style={th}>On hand</th>
              <th style={th}>Par</th>
              <th style={th}>Reorder at</th>
              <th style={th}></th>
            </tr>
          </thead>
          <tbody>
            {items.map((i) => {
              const low = Number(i.onhand || 0) <= Number(i.reorderat || 0);
              return (
                <tr key={i.parid} style={{ borderTop: '1px solid #f3f4f6', background: low ? '#fef2f2' : 'transparent' }}>
                  <td style={td}>{i.ingredientname}</td>
                  <td style={td}>{i.unit}</td>
                  <td style={td}>{i.onhand}</td>
                  <td style={td}>{i.parlevel}</td>
                  <td style={td}>{i.reorderat}</td>
                  <td style={td}><button onClick={() => removeRow(i.parid)} style={btnGhost}>×</button></td>
                </tr>
              );
            })}
          </tbody>
        </table>
      )}

      {restock && <pre style={reportBox}>{restock}</pre>}
    </section>
  );
}

function NewParForm({ businessId, onSaved }) {
  const [f, setF]     = useState({ ingredient_name: '', unit: '', on_hand: 0, par_level: 0, reorder_at: 0 });
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState('');

  const submit = async (e) => {
    e.preventDefault();
    if (!f.ingredient_name.trim()) return setError('Ingredient name required.');
    setBusy(true); setError('');
    try {
      await apiSend('POST', '/chef/par', {
        business_id:     Number(businessId),
        ingredient_name: f.ingredient_name.trim(),
        unit:            f.unit.trim(),
        on_hand:         Number(f.on_hand) || 0,
        par_level:       Number(f.par_level) || 0,
        reorder_at:      Number(f.reorder_at) || 0,
      });
      onSaved();
    } catch (e) { setError(e.message); }
    finally { setBusy(false); }
  };

  return (
    <form onSubmit={submit} style={{ background: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: 10, padding: 12, marginBottom: 12,
      display: 'grid', gridTemplateColumns: '2fr 1fr 1fr 1fr 1fr auto', gap: 8, alignItems: 'center' }}>
      <input placeholder="Ingredient" value={f.ingredient_name} onChange={(e) => setF({ ...f, ingredient_name: e.target.value })} style={inp} />
      <input placeholder="Unit" value={f.unit} onChange={(e) => setF({ ...f, unit: e.target.value })} style={inp} />
      <input placeholder="On hand" type="number" step="0.01" value={f.on_hand} onChange={(e) => setF({ ...f, on_hand: e.target.value })} style={inp} />
      <input placeholder="Par level" type="number" step="0.01" value={f.par_level} onChange={(e) => setF({ ...f, par_level: e.target.value })} style={inp} />
      <input placeholder="Reorder at" type="number" step="0.01" value={f.reorder_at} onChange={(e) => setF({ ...f, reorder_at: e.target.value })} style={inp} />
      <button type="submit" disabled={busy} style={btnPrimary}>{busy ? '…' : 'Save'}</button>
      {error && <div style={{ gridColumn: '1 / -1', color: '#991b1b', fontSize: 12 }}>{error}</div>}
    </form>
  );
}

// ─── Seasonal Menu Planner ────────────────────────────────────────────────────

function SeasonalSection({ businessId }) {
  const [state, setState]       = useState('');
  const [category, setCategory] = useState('');
  const [report, setReport]     = useState('');
  const [busy, setBusy]         = useState(false);

  const run = async () => {
    setBusy(true); setReport('…');
    try {
      const qs = new URLSearchParams();
      if (businessId) qs.set('business_id', String(businessId));
      if (state) qs.set('state', state);
      if (category) qs.set('category', category);
      const data = await apiGet(`/chef/seasonal?${qs.toString()}`);
      setReport(data.report || '(no listings)');
    } catch (e) { setReport(`Error: ${e.message}`); }
    finally { setBusy(false); }
  };

  return (
    <section style={{ background: '#fff', border: '1px solid #e5e7eb', borderRadius: 12, padding: 18, marginBottom: 16 }}>
      <h2 style={{ margin: 0, fontSize: 18, color: '#14532d', marginBottom: 12 }}>Seasonal Menu Planner</h2>
      <div style={{ display: 'flex', gap: 8, marginBottom: 8, flexWrap: 'wrap' }}>
        <input placeholder="State (defaults to your state)" value={state} onChange={(e) => setState(e.target.value)} style={{ ...inp, flex: 1 }} />
        <select value={category} onChange={(e) => setCategory(e.target.value)} style={{ ...inp, flex: 1 }}>
          <option value="">All categories</option>
          <option value="Vegetable">Vegetables</option>
          <option value="Fruit">Fruit</option>
          <option value="Herb">Herbs</option>
          <option value="Meat">Meat</option>
          <option value="Grain">Grain</option>
        </select>
        <button onClick={run} disabled={busy} style={btnPrimary}>{busy ? 'Loading…' : "What's in season"}</button>
      </div>
      {report && <pre style={reportBox}>{report}</pre>}
    </section>
  );
}

// ─── Provenance Cards ─────────────────────────────────────────────────────────

function ProvenanceSection() {
  const [ingredients, setIngredients] = useState('');
  const [cards, setCards]             = useState('');
  const [busy, setBusy]               = useState(false);

  const run = async () => {
    const clean = ingredients.trim();
    if (!clean) return;
    setBusy(true); setCards('…');
    try {
      const data = await apiGet(`/chef/provenance?ingredients=${encodeURIComponent(clean)}`);
      setCards(data.cards || '(no cards)');
    } catch (e) { setCards(`Error: ${e.message}`); }
    finally { setBusy(false); }
  };

  const copy = () => { navigator.clipboard?.writeText(cards); };

  return (
    <section style={{ background: '#fff', border: '1px solid #e5e7eb', borderRadius: 12, padding: 18, marginBottom: 16 }}>
      <h2 style={{ margin: 0, fontSize: 18, color: '#14532d', marginBottom: 12 }}>Provenance Cards</h2>
      <div style={{ display: 'flex', gap: 8, marginBottom: 8 }}>
        <input
          placeholder="Ingredients, comma-separated (e.g. tomatoes, basil, mozzarella)"
          value={ingredients}
          onChange={(e) => setIngredients(e.target.value)}
          style={{ ...inp, flex: 1 }}
        />
        <button onClick={run} disabled={busy} style={btnPrimary}>{busy ? '…' : 'Build cards'}</button>
        {cards && cards !== '…' && (
          <button onClick={copy} style={btnGhost}>Copy markdown</button>
        )}
      </div>
      {cards && <pre style={reportBox}>{cards}</pre>}
    </section>
  );
}

// ─── Shared styles ────────────────────────────────────────────────────────────

const inp = {
  padding: '8px 10px', border: '1px solid #d1d5db', borderRadius: 6,
  fontSize: 13, background: '#fff', minWidth: 0,
};
const th = { padding: '6px 8px', fontWeight: 500, fontSize: 12 };
const td = { padding: '6px 8px' };
const btnPrimary = {
  fontSize: 13, padding: '6px 14px', borderRadius: 6,
  border: 'none', background: '#166534', color: '#fff', cursor: 'pointer',
};
const btnGhost = {
  fontSize: 13, padding: '6px 12px', borderRadius: 6,
  border: '1px solid #d1d5db', background: '#fff', color: '#374151', cursor: 'pointer',
};
const btnDanger = {
  fontSize: 13, padding: '6px 12px', borderRadius: 6,
  border: '1px solid #fecaca', background: '#fff', color: '#991b1b', cursor: 'pointer',
};
const reportBox = {
  marginTop: 10, padding: 10, background: '#f9fafb',
  border: '1px solid #e5e7eb', borderRadius: 8, fontSize: 12,
  whiteSpace: 'pre-wrap', color: '#111827', maxHeight: 420, overflowY: 'auto',
};

// ─── Root ─────────────────────────────────────────────────────────────────────

export default function ChefDashboard() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id') || localStorage.getItem('PeopleID');
  const { Business, LoadBusiness } = useAccount();

  useEffect(() => {
    if (BusinessID) LoadBusiness(BusinessID);
  }, [BusinessID]);

  return (
    <AccountLayout
      Business={Business}
      BusinessID={BusinessID}
      PeopleID={PeopleID}
      pageTitle="Chef Dashboard"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Chef' }]}
    >
      <div style={{ maxWidth: 1100, margin: '0 auto' }}>
        <div style={{
          background: '#fff', border: '1px solid #e5e7eb', borderRadius: 12,
          padding: 18, marginBottom: 16,
        }}>
          <h1 style={{ margin: 0, fontSize: 22, color: '#14532d' }}>Chef Dashboard</h1>
          <p style={{ margin: '6px 0 0 0', fontSize: 14, color: '#4b5563' }}>
            Live plate costing, par levels, seasonal planning, and provenance cards — all wired to the OFN marketplace.
          </p>
        </div>

        {!BusinessID && (
          <div style={{ background: '#fef9c3', border: '1px solid #fde68a', borderRadius: 10, padding: 14, marginBottom: 16, color: '#713f12' }}>
            Open this page from a restaurant business (add <code>?BusinessID=...</code> to the URL) to see your recipes and pars.
          </div>
        )}

        {BusinessID && <RecipesSection businessId={BusinessID} />}
        {BusinessID && <ParSection businessId={BusinessID} />}
        <SeasonalSection businessId={BusinessID} />
        <ProvenanceSection />
      </div>
      <PairsleyChat businessId={BusinessID} />
    </AccountLayout>
  );
}
