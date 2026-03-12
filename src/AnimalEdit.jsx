import { useState, useEffect, useCallback } from "react";
import { useSearchParams, useNavigate } from "react-router-dom";
import AccountLayout from "./AccountLayout";

const apiBase = import.meta.env.VITE_API_URL ?? "";

const FOWL_IDS = [13, 14, 15, 19, 22, 26, 28, 29, 30, 31];
const NO_TEMPERAMENT_IDS = [23, 33, 22, 19, 15, 14, 13];
const NO_COLOR_IDS = [26, 18, 21, 33, 28, 31, 23, 25, 22, 19, 15, 14, 13, 27];
const SINGLE_BREED_IDS = [2, 9, 23, 34, 33];

const SPECIES_MAP = {
  2:"Alpaca",3:"Dog",4:"Llama",5:"Horse",6:"Goat",7:"Donkey",8:"Cattle",9:"Bison",
  10:"Sheep",11:"Rabbit",12:"Pig",13:"Chicken",14:"Turkey",15:"Duck",16:"Cat",
  17:"Yak",18:"Camel",19:"Emu",21:"Deer",22:"Geese",23:"Bees",25:"Crocodile/Alligator",
  26:"Guinea Fowl",27:"Musk Ox",28:"Ostrich",29:"Pheasant",30:"Pigeon",31:"Quail",
  33:"Snail",34:"Buffalo"
};

const TABS = [
  { id: "basics", label: "Basics" },
  { id: "pricing", label: "Pricing" },
  { id: "description", label: "Description" },
  { id: "ancestry", label: "Ancestry" },
  { id: "fiber", label: "Fiber / Wool" },
  { id: "awards", label: "Awards" },
];

function SaveBar({ saving, saved, onSave, label = "Save Changes" }) {
  return (
    <div style={{ display:"flex", justifyContent:"flex-end", alignItems:"center", gap:12, marginTop:24 }}>
      {saved && <span style={{ color:"#4a7c3f", fontWeight:600, fontSize:14 }}>✓ Saved!</span>}
      <button
        onClick={onSave}
        disabled={saving}
        style={{
          background: saving ? "#9ab" : "#5a3e2b",
          color: "#fff",
          border: "none",
          borderRadius: 6,
          padding: "10px 28px",
          fontWeight: 700,
          fontSize: 15,
          cursor: saving ? "not-allowed" : "pointer",
          letterSpacing: "0.04em",
        }}
      >
        {saving ? "Saving…" : label}
      </button>
    </div>
  );
}

// ─── BASICS TAB ──────────────────────────────────────────────────────────────
function BasicsTab({ animalID, businessID }) {
  const [animal, setAnimal] = useState(null);
  const [breeds, setBreeds] = useState([]);
  const [colors, setColors] = useState([]);
  const [categories, setCategories] = useState([]);
  const [registrations, setRegistrations] = useState([]);
  const [form, setForm] = useState({});
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!animalID) return;
    setLoading(true);
    fetch(`${apiBase}/api/animals/${animalID}`, {
      headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` },
    })
      .then(r => r.json())
      .then(data => {
        setAnimal(data);
        const dobStr = data.DOBYear
          ? `${data.DOBYear}-${String(data.DOBMonth||1).padStart(2,"0")}-${String(data.DOBDay||1).padStart(2,"0")}`
          : "";
        setForm({
          Name: data.FullName || "",
          DOB: dobStr,
          Category: data.Category || "",
          BreedID: data.BreedID || "",
          BreedID2: data.BreedID2 || "",
          BreedID3: data.BreedID3 || "",
          BreedID4: data.BreedID4 || "",
          Color1: data.Color1 || "",
          Color2: data.Color2 || "",
          Color3: data.Color3 || "",
          Color4: data.Color4 || "",
          Color5: data.Color5 || "",
          Temperment: data.Temperment || "",
          Height: data.Height || "",
          Weight: data.Weight || "",
          Gaited: data.Gaited || "",
          Warmblood: data.Warmblood || "",
          Horns: data.Horns || "",
          Vaccinations: data.Vaccinations || "",
          AncestryDescription: data.AncestryDescription || "",
        });
        if (data.SpeciesID) {
          fetch(`${apiBase}/api/animals/species/${data.SpeciesID}/breeds`)
            .then(r => r.json()).then(setBreeds).catch(() => setBreeds([]));
          fetch(`${apiBase}/api/livestock/species-colors/${data.SpeciesID}`)
            .then(r => r.json()).then(d => setColors(Array.isArray(d) ? d : [])).catch(() => setColors([]));
          fetch(`${apiBase}/api/animals/species/${data.SpeciesID}/categories`)
            .then(r => r.json()).then(d => setCategories(Array.isArray(d) ? d : [])).catch(() => setCategories([]));
          fetch(`${apiBase}/api/animals/${animalID}/registrations`, {
            headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` },
          })
            .then(r => r.json()).then(d => setRegistrations(Array.isArray(d) ? d : [])).catch(() => setRegistrations([]));
        }
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, [animalID]);

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const save = async () => {
    setSaving(true);
    setSaved(false);
    const [dobYear, dobMonth, dobDay] = (form.DOB || "").split("-");
    const body = new URLSearchParams({
      ...form,
      AnimalID: animalID,
      DOBYear: dobYear || "", DOBMonth: dobMonth || "", DOBDay: dobDay || "",
    });
    try {
      await fetch(`${apiBase}/api/animals/${animalID}/update-basics`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${localStorage.getItem("access_token")}`,
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body,
      });
      setSaved(true);
      setTimeout(() => setSaved(false), 3000);
    } catch {}
    setSaving(false);
  };

  if (loading) return <div style={styles.loadingBox}>Loading animal details…</div>;
  if (!animal) return <div style={styles.loadingBox}>Animal not found.</div>;

  const sid = animal.SpeciesID;
  const isFowl = FOWL_IDS.includes(sid);
  const showTemperament = !NO_TEMPERAMENT_IDS.includes(sid) && animal.NumberofAnimals < 2;
  const showColors = !NO_COLOR_IDS.includes(sid);
  const showExtraBreeds = !SINGLE_BREED_IDS.includes(sid);
  const maxColors = sid === 9 ? 3 : 5;

  const Field = ({ label, children, hint }) => (
    <div style={styles.field}>
      <label style={styles.label}>{label}</label>
      {children}
      {hint && <div style={styles.hint}>{hint}</div>}
    </div>
  );

  const Input = ({ fkey, type = "text", ...rest }) => (
    <input
      type={type}
      value={form[fkey] ?? ""}
      onChange={e => set(fkey, e.target.value)}
      style={styles.input}
      {...rest}
    />
  );

  const Select = ({ fkey, children, ...rest }) => (
    <select value={form[fkey] ?? ""} onChange={e => set(fkey, e.target.value)} style={styles.select} {...rest}>
      {children}
    </select>
  );

  return (
    <div>
      <div style={styles.sectionHead}>Basic Facts</div>

      <Field label="Name / Title" hint="This can be a full name like XYZ Ranch's MagaStud">
        <Input fkey="Name" style={{ ...styles.input, maxWidth: 420 }} />
      </Field>

      <div style={{ display:"flex", gap:32, marginBottom:16 }}>
        <div>
          <div style={styles.label}>Species</div>
          <div style={styles.staticVal}>{SPECIES_MAP[sid] || "Unknown"}</div>
        </div>
        <div>
          <div style={styles.label}># Animals in Listing</div>
          <div style={styles.staticVal}>{animal.NumberofAnimals || 1}</div>
        </div>
      </div>

      {animal.NumberofAnimals === 1 && sid !== 33 && (
        <Field label="Date of Birth">
          <Input fkey="DOB" type="date" style={{ ...styles.input, maxWidth: 200 }} />
        </Field>
      )}

      {showTemperament && (
        <Field label="Temperament" hint="1 = Very Calm, 10 = Very High-Spirited">
          <Select fkey="Temperment" style={{ ...styles.select, maxWidth: 120 }}>
            <option value="">-</option>
            {[...Array(10)].map((_,i) => (
              <option key={i+1} value={String(i+1)}>{i+1}</option>
            ))}
          </Select>
        </Field>
      )}

      {!isFowl && (
        <>
          <Field label="Height (hands/inches)">
            <Input fkey="Height" type="number" style={{ ...styles.input, maxWidth: 140 }} />
          </Field>
          <Field label="Weight (lbs)">
            <Input fkey="Weight" type="number" style={{ ...styles.input, maxWidth: 140 }} />
          </Field>
          {[5,7].includes(sid) && (
            <Field label="Gaited?">
              <Select fkey="Gaited" style={{ ...styles.select, maxWidth: 140 }}>
                <option value="">-</option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
              </Select>
            </Field>
          )}
          {![23,33,34].includes(sid) && (
            <Field label="Horns?">
              <Select fkey="Horns" style={{ ...styles.select, maxWidth: 140 }}>
                <option value="">-</option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Polled">Polled</option>
              </Select>
            </Field>
          )}
        </>
      )}

      {categories.length > 0 && !([23,33].includes(sid)) && (
        <Field label="Category">
          <Select fkey="Category">
            <option value="">Select…</option>
            {categories.map(c => (
              <option key={c.id} value={c.id}>{c.name}</option>
            ))}
          </Select>
        </Field>
      )}

      {breeds.length > 0 && (
        <>
          <Field label={sid === 4 || sid === 23 ? "Type" : "Breed (Primary)"}>
            <Select fkey="BreedID">
              <option value="">Select a breed…</option>
              {breeds.map(b => <option key={b.id} value={b.id}>{b.name}</option>)}
            </Select>
          </Field>
          {showExtraBreeds && [2,3,4].map(n => (
            <Field key={n} label={`Breed ${n+1}`}>
              <Select fkey={`BreedID${n+1}`}>
                <option value="">-</option>
                {breeds.map(b => <option key={b.id} value={b.id}>{b.name}</option>)}
              </Select>
            </Field>
          ))}
        </>
      )}

      {showColors && (
        <>
          <div style={styles.sectionHead}>Colors</div>
          <div style={{ display:"grid", gridTemplateColumns:"1fr 1fr", gap:12, marginBottom:16 }}>
            {[...Array(maxColors)].map((_,i) => {
              const k = `Color${i+1}`;
              return (
                <Field key={k} label={`Color ${i+1}`}>
                  {colors.length > 0 ? (
                    <Select fkey={k}>
                      <option value="">--</option>
                      {colors.map(c => <option key={c} value={c}>{c}</option>)}
                    </Select>
                  ) : (
                    <Input fkey={k} />
                  )}
                </Field>
              );
            })}
          </div>
        </>
      )}

      {registrations.length > 0 && (
        <>
          <div style={styles.sectionHead}>Registrations</div>
          {registrations.map((reg, i) => (
            <Field key={i} label={reg.RegType}>
              <input
                value={reg.RegNumber || ""}
                onChange={e => {
                  const updated = [...registrations];
                  updated[i] = { ...updated[i], RegNumber: e.target.value };
                  setRegistrations(updated);
                }}
                style={styles.input}
              />
            </Field>
          ))}
        </>
      )}

      {sid !== 23 && (
        <Field label="Vaccinations">
          <textarea
            value={form.Vaccinations}
            onChange={e => set("Vaccinations", e.target.value)}
            rows={5}
            style={{ ...styles.input, resize:"vertical", fontFamily:"inherit" }}
          />
        </Field>
      )}

      <SaveBar saving={saving} saved={saved} onSave={save} />
    </div>
  );
}

// ─── PRICING TAB ─────────────────────────────────────────────────────────────
function PricingTab({ animalID }) {
  const [form, setForm] = useState({
    ForSale: "0", Sold: "0", Price: "", StudFee: "",
    EmbryoPrice: "", SemenPrice: "", Free: "0",
    PriceComments: "", Financeterms: "",
    CoOwnerName1:"", CoOwnerLink1:"", CoOwnerBusiness1:"",
    CoOwnerName2:"", CoOwnerLink2:"", CoOwnerBusiness2:"",
    CoOwnerName3:"", CoOwnerLink3:"", CoOwnerBusiness3:"",
  });
  const [animal, setAnimal] = useState(null);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);

  useEffect(() => {
    if (!animalID) return;
    Promise.all([
      fetch(`${apiBase}/api/animals/${animalID}`, {
        headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` },
      }).then(r => r.json()),
      fetch(`${apiBase}/api/animals/${animalID}/pricing`, {
        headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` },
      }).then(r => r.json()).catch(() => ({})),
    ]).then(([a, p]) => {
      setAnimal(a);
      setForm(f => ({
        ...f,
        ForSale: String(p.ForSale ?? a.PublishForSale ?? 0),
        Sold: String(p.Sold ?? 0),
        Free: String(p.Free ?? 0),
        Price: p.Price || "",
        StudFee: p.StudFee || "",
        EmbryoPrice: p.EmbryoPrice || "",
        SemenPrice: p.SemenPrice || "",
        PriceComments: p.PriceComments || "",
        Financeterms: p.Financeterms || "",
        CoOwnerName1: a.CoOwnerName1 || "",
        CoOwnerLink1: a.CoOwnerLink1 || "",
        CoOwnerBusiness1: a.CoOwnerBusiness1 || "",
        CoOwnerName2: a.CoOwnerName2 || "",
        CoOwnerLink2: a.CoOwnerLink2 || "",
        CoOwnerBusiness2: a.CoOwnerBusiness2 || "",
        CoOwnerName3: a.CoOwnerName3 || "",
        CoOwnerLink3: a.CoOwnerLink3 || "",
        CoOwnerBusiness3: a.CoOwnerBusiness3 || "",
      }));
    });
  }, [animalID]);

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const save = async () => {
    setSaving(true);
    setSaved(false);
    const body = new URLSearchParams({ ...form, AnimalID: animalID });
    try {
      await fetch(`${apiBase}/api/animals/${animalID}/update-pricing`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${localStorage.getItem("access_token")}`,
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body,
      });
      setSaved(true);
      setTimeout(() => setSaved(false), 3000);
    } catch {}
    setSaving(false);
  };

  const isFowl = animal && FOWL_IDS.includes(animal.SpeciesID);
  const isMale = animal && (String(animal.Category).toLowerCase().includes("male"));

  const RadioGroup = ({ label, fkey }) => (
    <div style={styles.field}>
      <label style={styles.label}>{label}</label>
      <div style={{ display:"flex", gap:20 }}>
        {["Yes","No"].map(v => (
          <label key={v} style={{ display:"flex", alignItems:"center", gap:6, cursor:"pointer" }}>
            <input
              type="radio"
              name={fkey}
              value={v === "Yes" ? "1" : "0"}
              checked={form[fkey] === (v === "Yes" ? "1" : "0")}
              onChange={() => set(fkey, v === "Yes" ? "1" : "0")}
            />
            {v}
          </label>
        ))}
      </div>
    </div>
  );

  return (
    <div>
      <div style={styles.sectionHead}>Sale Status</div>
      <RadioGroup label="For Sale?" fkey="ForSale" />
      <RadioGroup label="Sold?" fkey="Sold" />
      <RadioGroup label="Free?" fkey="Free" />

      {!isFowl && (
        <>
          <div style={styles.sectionHead}>Pricing</div>
          <div style={styles.field}>
            <label style={styles.label}>Price ($)</label>
            <input type="number" value={form.Price} onChange={e => set("Price", e.target.value)} style={{ ...styles.input, maxWidth:160 }} />
          </div>
          {isMale && (
            <div style={styles.field}>
              <label style={styles.label}>Stud Fee ($)</label>
              <input type="number" value={form.StudFee} onChange={e => set("StudFee", e.target.value)} style={{ ...styles.input, maxWidth:160 }} />
              <div style={styles.hint}>Set to 0 to show "Call For Price"</div>
            </div>
          )}
          {[2,4,10].includes(animal?.SpeciesID) && (
            <>
              <div style={styles.field}>
                <label style={styles.label}>Embryo Price ($)</label>
                <input type="number" value={form.EmbryoPrice} onChange={e => set("EmbryoPrice", e.target.value)} style={{ ...styles.input, maxWidth:160 }} />
              </div>
              <div style={styles.field}>
                <label style={styles.label}>Semen Price ($)</label>
                <input type="number" value={form.SemenPrice} onChange={e => set("SemenPrice", e.target.value)} style={{ ...styles.input, maxWidth:160 }} />
              </div>
            </>
          )}
          <div style={styles.field}>
            <label style={styles.label}>Finance Terms</label>
            <textarea value={form.Financeterms} onChange={e => set("Financeterms", e.target.value)} rows={4} style={{ ...styles.input, resize:"vertical", fontFamily:"inherit" }} />
          </div>
        </>
      )}

      <div style={styles.field}>
        <label style={styles.label}>Sales Comment</label>
        <textarea value={form.PriceComments} onChange={e => set("PriceComments", e.target.value)} rows={3} style={{ ...styles.input, resize:"vertical", fontFamily:"inherit" }} />
        <div style={styles.hint}>A short comment like "Great Price!" or "Great Progeny"</div>
      </div>

      {animal?.NumberofAnimals < 2 && (
        <>
          <div style={styles.sectionHead}>Co-Owners</div>
          {[1,2,3].map(n => (
            <div key={n} style={{ marginBottom:16, padding:"12px 16px", background:"#f9f6f2", borderRadius:8, border:"1px solid #e8e0d5" }}>
              <div style={{ fontWeight:600, marginBottom:8, color:"#5a3e2b" }}>Co-Owner {n}</div>
              {[
                ["Ranch Name", `CoOwnerBusiness${n}`],
                ["Name", `CoOwnerName${n}`],
                ["Profile Link", `CoOwnerLink${n}`],
              ].map(([lbl, key]) => (
                <div key={key} style={{ display:"flex", alignItems:"center", gap:12, marginBottom:8 }}>
                  <label style={{ ...styles.label, width:120, marginBottom:0 }}>{lbl}</label>
                  <input value={form[key] || ""} onChange={e => set(key, e.target.value)} style={{ ...styles.input, flex:1, marginBottom:0 }} />
                </div>
              ))}
            </div>
          ))}
        </>
      )}

      <SaveBar saving={saving} saved={saved} onSave={save} />
    </div>
  );
}

// ─── DESCRIPTION TAB ─────────────────────────────────────────────────────────
function DescriptionTab({ animalID }) {
  const [desc, setDesc] = useState("");
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!animalID) return;
    fetch(`${apiBase}/api/animals/${animalID}/description`, {
      headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` },
    })
      .then(r => r.json())
      .then(d => { setDesc(d.Description || ""); setLoading(false); })
      .catch(() => setLoading(false));
  }, [animalID]);

  const save = async () => {
    setSaving(true);
    try {
      await fetch(`${apiBase}/api/animals/${animalID}/update-description`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${localStorage.getItem("access_token")}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ Description: desc }),
      });
      setSaved(true);
      setTimeout(() => setSaved(false), 3000);
    } catch {}
    setSaving(false);
  };

  if (loading) return <div style={styles.loadingBox}>Loading…</div>;

  return (
    <div>
      <div style={styles.sectionHead}>Animal Description</div>
      <p style={{ color:"#7a6a5a", fontSize:14, marginBottom:16 }}>
        Describe your animal for potential buyers. Include personality traits, notable accomplishments, and any other relevant information.
      </p>
      <textarea
        value={desc}
        onChange={e => setDesc(e.target.value)}
        rows={16}
        placeholder="Describe your animal…"
        style={{ ...styles.input, width:"100%", resize:"vertical", fontFamily:"inherit", fontSize:15, lineHeight:1.6 }}
      />
      <SaveBar saving={saving} saved={saved} onSave={save} />
    </div>
  );
}

// ─── ANCESTRY TAB ────────────────────────────────────────────────────────────
function AncestryTab({ animalID }) {
  const ANCESTOR_FIELDS = [
    "Sire","SireColor","SireLink",
    "SireSire","SireSireColor","SireSireLink",
    "SireSireSire","SireSireSireColor","SireSireSireLink",
    "SireSireDam","SireSireDamColor","SireSireDamLink",
    "SireDam","SireDamColor","SireDamLink",
    "SireDamSire","SireDamSireColor","SireDamSireLink",
    "SireDamDam","SireDamDamColor","SireDamDamLink",
    "Dam","DamColor","DamLink",
    "DamSire","DamSireColor","DamSireLink",
    "DamSireSire","DamSireSireColor","DamSireSireLink",
    "DamSireDam","DamSireDamColor","DamSireDamLink",
    "DamDam","DamDamColor","DamDamLink",
    "DamDamSire","DamDamSireColor","DamDamSireLink",
    "DamDamDam","DamDamDamColor","DamDamDamLink",
  ];

  const [form, setForm] = useState({});
  const [colors, setColors] = useState([]);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!animalID) return;
    fetch(`${apiBase}/api/animals/${animalID}/ancestry`, {
      headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` },
    })
      .then(r => r.json())
      .then(d => {
        const init = {};
        ANCESTOR_FIELDS.forEach(f => { init[f] = d[f] || ""; });
        setForm(init);
        if (d.SpeciesID) {
          fetch(`${apiBase}/api/livestock/species-colors/${d.SpeciesID}`)
            .then(r => r.json()).then(c => setColors(Array.isArray(c) ? c : [])).catch(() => {});
        }
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, [animalID]);

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const save = async () => {
    setSaving(true);
    try {
      await fetch(`${apiBase}/api/animals/${animalID}/update-ancestry`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${localStorage.getItem("access_token")}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(form),
      });
      setSaved(true);
      setTimeout(() => setSaved(false), 3000);
    } catch {}
    setSaving(false);
  };

  const boxInput = {
    display: "block",
    width: "100%",
    padding: "5px 8px",
    border: "1px solid #d5c9bc",
    borderRadius: 4,
    fontSize: 12,
    background: "rgba(255,255,255,0.75)",
    boxSizing: "border-box",
    fontFamily: "inherit",
    marginBottom: 4,
  };

  const AncestorBox = ({ label, nameKey, colorKey, linkKey, gender }) => {
    const isMale = gender === "male";
    return (
      <div style={{
        background: isMale ? "#dbeafe" : "#fce7f3",
        border: `1px solid ${isMale ? "#93c5fd" : "#f9a8d4"}`,
        borderRadius: 6,
        padding: "8px 10px",
        width: "100%",
        boxSizing: "border-box",
      }}>
        <div style={{
          fontWeight: 700, fontSize: 11, color: "#5a3e2b",
          textTransform: "uppercase", letterSpacing: "0.05em", marginBottom: 6,
        }}>
          {label}
        </div>
        <input
          value={form[nameKey] || ""}
          onChange={e => set(nameKey, e.target.value)}
          placeholder="Name"
          style={boxInput}
        />
        {colors.length > 0 ? (
          <select
            value={form[colorKey] || ""}
            onChange={e => set(colorKey, e.target.value)}
            style={{ ...boxInput, marginBottom: 4 }}
          >
            <option value="">-- Color --</option>
            {colors.map(c => <option key={c} value={c}>{c}</option>)}
          </select>
        ) : (
          <input
            value={form[colorKey] || ""}
            onChange={e => set(colorKey, e.target.value)}
            placeholder="Color"
            style={boxInput}
          />
        )}
        <input
          value={form[linkKey] || ""}
          onChange={e => set(linkKey, e.target.value)}
          placeholder="Link (optional)"
          style={{ ...boxInput, fontSize: 11, marginBottom: 0 }}
        />
      </div>
    );
  };

  if (loading) return <div style={styles.loadingBox}>Loading ancestry…</div>;

  // Each "slot" in the pedigree tree is one of 8 rows.
  // The layout is a 4-column table:
  //   [Parents] [connector] [Grandparents] [connector] [Great-Grandparents]
  // Parents span 4 rows each, Grandparents span 2 rows each.

  const ColHead = ({ children }) => (
    <th style={{
      fontWeight: 700, fontSize: 12, color: "#5a3e2b",
      textTransform: "uppercase", letterSpacing: "0.05em",
      paddingBottom: 10, textAlign: "left", whiteSpace: "nowrap",
    }}>
      {children}
    </th>
  );

  const connectorV = {
    width: 20,
    padding: 0,
    position: "relative",
  };

  // Vertical + horizontal connector lines using borders
  const LineCell = ({ top, bottom }) => (
    <td style={{
      width: 20, padding: 0,
      borderRight: "2px solid #d5c9bc",
      borderTop: top ? "2px solid #d5c9bc" : "none",
      borderBottom: bottom ? "2px solid #d5c9bc" : "none",
    }} />
  );

  const Pad = ({ children }) => (
    <td style={{ padding: "4px 6px 4px 0", verticalAlign: "middle" }}>
      {children}
    </td>
  );

  return (
    <div>
      <div style={styles.sectionHead}>Pedigree</div>
      <p style={{ color: "#7a6a5a", fontSize: 13, marginBottom: 20 }}>
        Blue = male &nbsp;·&nbsp; Pink = female
      </p>

      <div style={{ overflowX: "auto" }}>
        <table style={{ borderCollapse: "collapse", minWidth: 820, width: "100%" }}>
          <thead>
            <tr>
              <ColHead>Parents</ColHead>
              <th style={{ width: 20 }} />
              <ColHead>Grandparents</ColHead>
              <th style={{ width: 20 }} />
              <ColHead>Great-Grandparents</ColHead>
            </tr>
          </thead>
          <tbody>
            {/* Row 1 of 8 — SireSireSire */}
            <tr>
              <td rowSpan={4} style={{ verticalAlign: "middle", paddingRight: 0, paddingBottom: 4 }}>
                <AncestorBox label="Sire" nameKey="Sire" colorKey="SireColor" linkKey="SireLink" gender="male" />
              </td>
              <LineCell top={false} bottom={true} />
              <td rowSpan={2} style={{ verticalAlign: "middle", paddingRight: 0, paddingBottom: 4 }}>
                <AncestorBox label="Sire's Sire" nameKey="SireSire" colorKey="SireSireColor" linkKey="SireSireLink" gender="male" />
              </td>
              <LineCell top={false} bottom={true} />
              <Pad><AncestorBox label="Sire's Sire's Sire" nameKey="SireSireSire" colorKey="SireSireSireColor" linkKey="SireSireSireLink" gender="male" /></Pad>
            </tr>
            {/* Row 2 — SireSireDam */}
            <tr>
              <td style={{ width: 20, padding: 0, borderRight: "2px solid #d5c9bc" }} />
              <LineCell top={true} bottom={false} />
              <Pad><AncestorBox label="Sire's Sire's Dam" nameKey="SireSireDam" colorKey="SireSireDamColor" linkKey="SireSireDamLink" gender="female" /></Pad>
            </tr>
            {/* Row 3 — SireDamSire */}
            <tr>
              <td style={{ width: 20, padding: 0, borderRight: "2px solid #d5c9bc" }} />
              <td rowSpan={2} style={{ verticalAlign: "middle", paddingRight: 0, paddingBottom: 4 }}>
                <AncestorBox label="Sire's Dam" nameKey="SireDam" colorKey="SireDamColor" linkKey="SireDamLink" gender="female" />
              </td>
              <LineCell top={false} bottom={true} />
              <Pad><AncestorBox label="Sire's Dam's Sire" nameKey="SireDamSire" colorKey="SireDamSireColor" linkKey="SireDamSireLink" gender="male" /></Pad>
            </tr>
            {/* Row 4 — SireDamDam */}
            <tr>
              <td style={{ width: 20, padding: 0 }} />
              <LineCell top={true} bottom={false} />
              <Pad><AncestorBox label="Sire's Dam's Dam" nameKey="SireDamDam" colorKey="SireDamDamColor" linkKey="SireDamDamLink" gender="female" /></Pad>
            </tr>

            {/* Spacer row */}
            <tr><td colSpan={5} style={{ height: 8 }} /></tr>

            {/* Row 5 — DamSireSire */}
            <tr>
              <td rowSpan={4} style={{ verticalAlign: "middle", paddingRight: 0, paddingBottom: 4 }}>
                <AncestorBox label="Dam" nameKey="Dam" colorKey="DamColor" linkKey="DamLink" gender="female" />
              </td>
              <LineCell top={false} bottom={true} />
              <td rowSpan={2} style={{ verticalAlign: "middle", paddingRight: 0, paddingBottom: 4 }}>
                <AncestorBox label="Dam's Sire" nameKey="DamSire" colorKey="DamSireColor" linkKey="DamSireLink" gender="male" />
              </td>
              <LineCell top={false} bottom={true} />
              <Pad><AncestorBox label="Dam's Sire's Sire" nameKey="DamSireSire" colorKey="DamSireSireColor" linkKey="DamSireSireLink" gender="male" /></Pad>
            </tr>
            {/* Row 6 — DamSireDam */}
            <tr>
              <td style={{ width: 20, padding: 0, borderRight: "2px solid #d5c9bc" }} />
              <LineCell top={true} bottom={false} />
              <Pad><AncestorBox label="Dam's Sire's Dam" nameKey="DamSireDam" colorKey="DamSireDamColor" linkKey="DamSireDamLink" gender="female" /></Pad>
            </tr>
            {/* Row 7 — DamDamSire */}
            <tr>
              <td style={{ width: 20, padding: 0, borderRight: "2px solid #d5c9bc" }} />
              <td rowSpan={2} style={{ verticalAlign: "middle", paddingRight: 0, paddingBottom: 4 }}>
                <AncestorBox label="Dam's Dam" nameKey="DamDam" colorKey="DamDamColor" linkKey="DamDamLink" gender="female" />
              </td>
              <LineCell top={false} bottom={true} />
              <Pad><AncestorBox label="Dam's Dam's Sire" nameKey="DamDamSire" colorKey="DamDamSireColor" linkKey="DamDamSireLink" gender="male" /></Pad>
            </tr>
            {/* Row 8 — DamDamDam */}
            <tr>
              <td style={{ width: 20, padding: 0 }} />
              <LineCell top={true} bottom={false} />
              <Pad><AncestorBox label="Dam's Dam's Dam" nameKey="DamDamDam" colorKey="DamDamDamColor" linkKey="DamDamDamLink" gender="female" /></Pad>
            </tr>
          </tbody>
        </table>
      </div>

      <SaveBar saving={saving} saved={saved} onSave={save} />
    </div>
  );
}

// ─── FIBER TAB ───────────────────────────────────────────────────────────────
function FiberTab({ animalID }) {
  const EMPTY_ROW = () => ({
    FiberID: null, SampleDateYear:"", Average:"", CF:"",
    StandardDev:"", CrimpPerInch:"", COV:"", Length:"",
    GreaterThan30:"", ShearWeight:"", Curve:"", BlanketWeight:"",
  });

  const [rows, setRows] = useState([EMPTY_ROW()]);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const [loading, setLoading] = useState(true);

  const currentYear = new Date().getFullYear();
  const years = Array.from({ length: currentYear - 1982 }, (_, i) => currentYear - i);

  useEffect(() => {
    if (!animalID) return;
    fetch(`${apiBase}/api/animals/${animalID}/fiber`, {
      headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` },
    })
      .then(r => r.json())
      .then(d => {
        const data = Array.isArray(d) ? d : [];
        const filled = data.filter(r => r.SampleDateYear || r.Average);
        setRows([...filled, ...Array(Math.max(0, 5 - filled.length)).fill(null).map(EMPTY_ROW)]);
        setLoading(false);
      })
      .catch(() => { setRows([EMPTY_ROW()]); setLoading(false); });
  }, [animalID]);

  const setCell = (i, k, v) => setRows(rs => rs.map((r, idx) => idx === i ? { ...r, [k]: v } : r));

  const save = async () => {
    setSaving(true);
    try {
      await fetch(`${apiBase}/api/animals/${animalID}/update-fiber`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${localStorage.getItem("access_token")}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(rows),
      });
      setSaved(true);
      setTimeout(() => setSaved(false), 3000);
    } catch {}
    setSaving(false);
  };

  const COLS = [
    { key:"Average", label:"AFD" },
    { key:"CF", label:"CF" },
    { key:"StandardDev", label:"SD" },
    { key:"CrimpPerInch", label:"Crimps/In" },
    { key:"COV", label:"COV" },
    { key:"Length", label:"Staple Len" },
    { key:"GreaterThan30", label:">30%" },
    { key:"ShearWeight", label:"Shear Wt" },
    { key:"Curve", label:"Curve" },
    { key:"BlanketWeight", label:"Blanket Wt" },
  ];

  if (loading) return <div style={styles.loadingBox}>Loading fiber data…</div>;

  return (
    <div>
      <div style={styles.sectionHead}>Fiber / Wool Test Results</div>
      <div style={{ overflowX:"auto", marginBottom:16 }}>
        <table style={{ width:"100%", borderCollapse:"collapse", fontSize:13 }}>
          <thead>
            <tr style={{ background:"#f2ebe3" }}>
              <th style={styles.th}>Year</th>
              {COLS.map(c => <th key={c.key} style={styles.th}>{c.label}</th>)}
            </tr>
          </thead>
          <tbody>
            {rows.map((row, i) => (
              <tr key={i} style={{ background: i % 2 === 0 ? "#fff" : "#faf7f4" }}>
                <td style={styles.td}>
                  <select
                    value={row.SampleDateYear || ""}
                    onChange={e => setCell(i, "SampleDateYear", e.target.value)}
                    style={{ ...styles.select, fontSize:12, padding:"4px 6px", width:"100%" }}
                  >
                    <option value="">--</option>
                    {years.map(y => <option key={y} value={y}>{y}</option>)}
                  </select>
                </td>
                {COLS.map(c => (
                  <td key={c.key} style={styles.td}>
                    <input
                      type="number"
                      value={row[c.key] || ""}
                      onChange={e => setCell(i, c.key, e.target.value)}
                      style={{ ...styles.input, padding:"4px 6px", fontSize:12, width:68, marginBottom:0 }}
                    />
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <button onClick={() => setRows(rs => [...rs, EMPTY_ROW()])} style={styles.addRowBtn}>
        + Add Row
      </button>
      <SaveBar saving={saving} saved={saved} onSave={save} />
    </div>
  );
}

// ─── AWARDS TAB ──────────────────────────────────────────────────────────────
function AwardsTab({ animalID }) {
  const EMPTY = () => ({ AwardsID: null, AwardYear:"", ShowName:"", Type:"", Placing:"", Awardcomments:"" });
  const [rows, setRows] = useState([]);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const [loading, setLoading] = useState(true);

  const currentYear = new Date().getFullYear();
  const years = Array.from({ length: currentYear - 1982 }, (_, i) => currentYear - i);

  useEffect(() => {
    if (!animalID) return;
    fetch(`${apiBase}/api/animals/${animalID}/awards`, {
      headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` },
    })
      .then(r => r.json())
      .then(d => { setRows([...(Array.isArray(d) ? d : []), EMPTY()]); setLoading(false); })
      .catch(() => { setRows([EMPTY()]); setLoading(false); });
  }, [animalID]);

  const setCell = (i, k, v) => setRows(rs => rs.map((r, idx) => idx === i ? { ...r, [k]: v } : r));

  const save = async () => {
    setSaving(true);
    try {
      await fetch(`${apiBase}/api/animals/${animalID}/update-awards`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${localStorage.getItem("access_token")}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(rows.filter(r => r.AwardYear || r.ShowName || r.Placing)),
      });
      setSaved(true);
      setTimeout(() => setSaved(false), 3000);
      setRows(rs => [...rs.filter(r => r.AwardYear || r.ShowName || r.Placing), EMPTY()]);
    } catch {}
    setSaving(false);
  };

  if (loading) return <div style={styles.loadingBox}>Loading awards…</div>;

  return (
    <div>
      <div style={styles.sectionHead}>Show Awards</div>
      <div style={{ overflowX:"auto", marginBottom:16 }}>
        <table style={{ width:"100%", borderCollapse:"collapse", fontSize:13 }}>
          <thead>
            <tr style={{ background:"#f2ebe3" }}>
              {["Year","Show Name","Class","Placing","Comments",""].map((h,i) => (
                <th key={i} style={styles.th}>{h}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {rows.map((row, i) => (
              <tr key={i} style={{ background: i % 2 === 0 ? "#fff" : "#faf7f4" }}>
                <td style={styles.td}>
                  <select
                    value={row.AwardYear || ""}
                    onChange={e => setCell(i, "AwardYear", e.target.value)}
                    style={{ ...styles.select, fontSize:12, padding:"4px 6px", width:90 }}
                  >
                    <option value="">Year</option>
                    {years.map(y => <option key={y} value={y}>{y}</option>)}
                  </select>
                </td>
                {[["ShowName","Show Name"],["Type","Class"],["Placing","Placing"],["Awardcomments","Comments"]].map(([k,ph]) => (
                  <td key={k} style={styles.td}>
                    <input
                      value={row[k] || ""}
                      onChange={e => setCell(i, k, e.target.value)}
                      placeholder={ph}
                      style={{ ...styles.input, padding:"4px 8px", fontSize:12, minWidth:90, marginBottom:0 }}
                    />
                  </td>
                ))}
                <td style={styles.td}>
                  {rows.length > 1 && (
                    <button
                      onClick={() => setRows(rs => rs.filter((_,idx) => idx !== i))}
                      style={{ background:"none", border:"none", color:"#c0392b", cursor:"pointer", fontSize:16, padding:"2px 6px" }}
                    >×</button>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <button onClick={() => setRows(rs => [...rs, EMPTY()])} style={styles.addRowBtn}>
        + Add Award
      </button>
      <SaveBar saving={saving} saved={saved} onSave={save} />
    </div>
  );
}

// ─── PUBLISH BANNER ──────────────────────────────────────────────────────────
function PublishBanner({ animalID, animalName, published, onToggle }) {
  const [toggling, setToggling] = useState(false);

  const toggle = async () => {
    setToggling(true);
    try {
      await fetch(`${apiBase}/api/animals/${animalID}/publish`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${localStorage.getItem("access_token")}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ publish: !published }),
      });
      onToggle(!published);
    } catch {}
    setToggling(false);
  };

  return (
    <div style={{
      background: "#fff",
      border: "1px solid #e8e0d5",
      borderRadius: 10,
      padding: "16px 24px",
      marginBottom: 20,
      display: "flex",
      alignItems: "center",
      justifyContent: "space-between",
      flexWrap: "wrap",
      gap: 12,
    }}>
      <div style={{ fontWeight: 700, fontSize: 20, color: "#2c1a0e" }}>{animalName}</div>
      <div style={{ display:"flex", alignItems:"center", gap:14 }}>
        <span style={{ color:"#7a6a5a", fontSize:14 }}>Sales Listing:</span>
        <span style={{
          fontWeight: 700,
          color: published ? "#4a7c3f" : "#8b7355",
          background: published ? "#e8f4e6" : "#f2ebe3",
          padding: "3px 10px",
          borderRadius: 20,
          fontSize: 13,
        }}>
          {published ? "Published" : "Draft"}
        </span>
        <button
          onClick={toggle}
          disabled={toggling}
          style={{
            background: published ? "#8b7355" : "#4a7c3f",
            color: "#fff",
            border: "none",
            borderRadius: 6,
            padding: "8px 20px",
            fontWeight: 700,
            fontSize: 14,
            cursor: toggling ? "not-allowed" : "pointer",
          }}
        >
          {toggling ? "…" : published ? "Unpublish" : "Publish"}
        </button>
      </div>
    </div>
  );
}

// ─── MAIN COMPONENT ──────────────────────────────────────────────────────────
export default function AnimalEdit() {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const animalID = searchParams.get("AnimalID");
  const businessID = searchParams.get("BusinessID");

  const [activeTab, setActiveTab] = useState("basics");
  const [animalName, setAnimalName] = useState("Animal");
  const [published, setPublished] = useState(false);
  const { Business, LoadBusiness } = useAccount?.() ?? { Business: null, LoadBusiness: () => {} };

  useEffect(() => {
    if (businessID) LoadBusiness(businessID);
  }, [businessID]);

  useEffect(() => {
    if (!animalID) return;
    fetch(`${apiBase}/api/animals/${animalID}`, {
      headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` },
    })
      .then(r => r.json())
      .then(d => {
        setAnimalName(d.FullName || "Animal");
        setPublished(d.PublishForSale === 1 || d.PublishForSale === true);
      })
      .catch(() => {});
  }, [animalID]);

  if (!animalID) return (
    <div style={{ padding:40, textAlign:"center", color:"#7a6a5a" }}>
      No animal selected. <a href="/animals" style={{ color:"#5a3e2b" }}>Back to animals</a>
    </div>
  );

  const tabComponents = {
    basics: <BasicsTab animalID={animalID} businessID={businessID} />,
    pricing: <PricingTab animalID={animalID} />,
    description: <DescriptionTab animalID={animalID} />,
    ancestry: <AncestryTab animalID={animalID} />,
    fiber: <FiberTab animalID={animalID} />,
    awards: <AwardsTab animalID={animalID} />,
  };

  const content = (
    <div style={{ maxWidth: 900, margin: "0 auto", padding: "0 16px 60px" }}>
      {/* Breadcrumb */}
      <div style={{ fontSize:13, color:"#8b7355", marginBottom:14 }}>
        <span style={{ cursor:"pointer", textDecoration:"underline" }} onClick={() => navigate("/dashboard")}>Dashboard</span>
        {" › "}
        <span style={{ cursor:"pointer", textDecoration:"underline" }} onClick={() => navigate(`/account?BusinessID=${businessID}`)}>Account Dashboard</span>
        {" › "}
        <span style={{ color:"#2c1a0e" }}>{animalName} — Edit Animal Details</span>
      </div>

      <PublishBanner
        animalID={animalID}
        animalName={animalName}
        published={published}
        onToggle={setPublished}
      />

      {/* Tab nav */}
      <div style={{
        display:"flex", gap:0, borderBottom:"2px solid #e8e0d5",
        marginBottom:28, overflowX:"auto",
      }}>
        {TABS.map(tab => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            style={{
              background: "none",
              border: "none",
              borderBottom: activeTab === tab.id ? "2px solid #5a3e2b" : "2px solid transparent",
              marginBottom: -2,
              padding: "10px 20px",
              fontWeight: activeTab === tab.id ? 700 : 500,
              color: activeTab === tab.id ? "#5a3e2b" : "#8b7355",
              fontSize: 14,
              cursor: "pointer",
              whiteSpace: "nowrap",
              transition: "all 0.15s",
            }}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {/* Tab content */}
      <div style={{
        background:"#fff",
        border:"1px solid #e8e0d5",
        borderRadius:10,
        padding:"28px 32px",
        boxShadow:"0 2px 12px rgba(90,62,43,0.06)",
      }}>
        {tabComponents[activeTab]}
      </div>
    </div>
  );

  // Try to render inside AccountLayout if available, fall back to plain div
  try {
    return (
      <AccountLayout Business={Business} BusinessID={businessID} PeopleID={localStorage.getItem("people_id")}>
        {content}
      </AccountLayout>
    );
  } catch {
    return <div style={{ fontFamily:"Georgia, serif", minHeight:"100vh", background:"#faf7f4" }}>{content}</div>;
  }
}

// Try to import useAccount gracefully
function useAccount() {
  try {
    const mod = require("./AccountContext");
    return mod.useAccount();
  } catch {
    return { Business: null, LoadBusiness: () => {} };
  }
}

// ─── SHARED STYLES ───────────────────────────────────────────────────────────
const styles = {
  sectionHead: {
    fontFamily:"Georgia, serif",
    fontWeight:700,
    fontSize:17,
    color:"#2c1a0e",
    borderBottom:"1px solid #e8e0d5",
    paddingBottom:8,
    marginBottom:16,
    marginTop:24,
  },
  field: { marginBottom:14 },
  label: {
    display:"block",
    fontSize:13,
    fontWeight:600,
    color:"#5a3e2b",
    marginBottom:5,
    letterSpacing:"0.02em",
  },
  hint: { fontSize:12, color:"#a08060", marginTop:4 },
  input: {
    display:"block",
    width:"100%",
    padding:"8px 12px",
    border:"1px solid #d5c9bc",
    borderRadius:6,
    fontSize:14,
    color:"#2c1a0e",
    background:"#fff",
    outline:"none",
    boxSizing:"border-box",
    marginBottom:0,
    fontFamily:"inherit",
  },
  select: {
    display:"block",
    width:"100%",
    padding:"8px 12px",
    border:"1px solid #d5c9bc",
    borderRadius:6,
    fontSize:14,
    color:"#2c1a0e",
    background:"#fff",
    outline:"none",
    boxSizing:"border-box",
    fontFamily:"inherit",
  },
  staticVal: {
    fontSize:15,
    color:"#4a3828",
    fontWeight:500,
    padding:"6px 0",
  },
  loadingBox: {
    textAlign:"center",
    padding:"40px 0",
    color:"#8b7355",
    fontSize:15,
  },
  th: {
    padding:"8px 10px",
    textAlign:"left",
    fontWeight:700,
    fontSize:12,
    color:"#5a3e2b",
    border:"1px solid #e8e0d5",
    whiteSpace:"nowrap",
  },
  td: {
    padding:"6px 8px",
    border:"1px solid #e8e0d5",
    verticalAlign:"middle",
  },
  addRowBtn: {
    background:"none",
    border:"1px dashed #c0a882",
    borderRadius:6,
    padding:"7px 18px",
    color:"#8b6a40",
    fontWeight:600,
    fontSize:13,
    cursor:"pointer",
    marginBottom:16,
    fontFamily:"inherit",
  },
};