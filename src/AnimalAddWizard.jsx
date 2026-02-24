import { useState, useEffect, useCallback } from "react";
import { useSearchParams } from "react-router-dom";
import AccountLayout from "./AccountLayout";
import "./AnimalAddWizard.css";

const SPECIES_LIST = [
  { id: 2,  name: "Alpacas" },
  { id: 23, name: "Bees" },
  { id: 9,  name: "Bison" },
  { id: 34, name: "Buffalo" },
  { id: 18, name: "Camel" },
  { id: 8,  name: "Cattle" },
  { id: 13, name: "Chickens" },
  { id: 25, name: "Crocodiles / Alligators" },
  { id: 21, name: "Deer" },
  { id: 3,  name: "Dogs" },
  { id: 7,  name: "Donkeys (includes Mules & Hinnies)" },
  { id: 15, name: "Ducks" },
  { id: 19, name: "Emu" },
  { id: 22, name: "Geese" },
  { id: 6,  name: "Goats" },
  { id: 26, name: "Guinea Fowl" },
  { id: 5,  name: "Horses" },
  { id: 4,  name: "Llamas" },
  { id: 27, name: "Musk Ox" },
  { id: 28, name: "Ostriches" },
  { id: 29, name: "Pheasants" },
  { id: 30, name: "Pigeons" },
  { id: 12, name: "Pigs" },
  { id: 31, name: "Quails" },
  { id: 11, name: "Rabbits" },
  { id: 10, name: "Sheep" },
  { id: 33, name: "Snails" },
  { id: 14, name: "Turkeys" },
  { id: 17, name: "Yak" },
];

const FOWL_IDS             = [13, 14, 15, 19, 22, 26, 28, 29, 30, 31];
const NO_ANCESTRY_IDS      = [23, 33, ...FOWL_IDS];
const NO_DOB_IDS           = [23, 33];
const NO_COLOR_IDS         = [15, 22, 23, 25, 26, 27, 28, 29, 30, 31, 33, 18, 19, 21];
const HAS_HEIGHT_WEIGHT    = [5, 8, 9, 17, 34];
const HAS_GAITED_WARMBLOOD = [5];
const HAS_HORNS            = [8, 9, 17, 34];
const NO_TEMPERAMENT       = FOWL_IDS;
const HAS_FIBER            = [2];
const NO_AWARDS            = [...FOWL_IDS, 19, 23];
const HAS_ALPACA_PERCENTS  = [2];
const LLAMA_IDS            = [4];
const ALPACA_FRACTIONS     = ["Full","1/2","1/4","1/8","1/16","1/32","1/64","Unknown"];

const STEPS = [
  { id: 1, label: "Basics",        icon: "🐾" },
  { id: 2, label: "General Facts", icon: "📋" },
  { id: 3, label: "Ancestry",      icon: "🌳" },
  { id: 4, label: "Fiber Facts",   icon: "🧵" },
  { id: 5, label: "Description",   icon: "📝" },
  { id: 6, label: "Awards",        icon: "🏆" },
  { id: 7, label: "Pricing",       icon: "💰" },
  { id: 8, label: "Photos",        icon: "📷" },
];

const INITIAL_FORM_DATA = {
  name: "", numberOfAnimals: 1, speciesID: "", category: "", dob: "",
  breedID: "", breedID2: "", breedID3: "", breedID4: "",
  color1: "", color2: "", color3: "", color4: "",
  height: "", weight: "", gaited: "", warmblood: "", horns: "", temperament: "",
  registrations: [], ancestry: {}, ancestryDescription: "",
  percentPeruvian: "", percentChilean: "", percentBolivian: "",
  percentUnknownOther: "", percentAccoyo: "",
  fiberSamples: Array(10).fill({}),
  description: "",
  awards: Array(10).fill({}),
  forSale: "Yes", free: "No",
  price: "", price2: "", price3: "", price4: "",
  minOrder1: "", minOrder2: "", minOrder3: "", minOrder4: "",
  maxOrder1: "", maxOrder2: "", maxOrder3: "", maxOrder4: "",
  obo: "No", discount: "0", foundation: "No",
  studFee: "", payWhatYouCan: "No", donorMale: "No", semenPrice: "",
  donorFemale: "No", embryoPrice: "", priceComments: "",
  coOwnerBusiness1: "", coOwnerName1: "", coOwnerLink1: "",
  coOwnerBusiness2: "", coOwnerName2: "", coOwnerLink2: "",
  coOwnerBusiness3: "", coOwnerName3: "", coOwnerLink3: "",
  photos: [], ariDoc: null, histogramDoc: null, fiberDoc: null, videoEmbed: "",
};

function getVisibleSteps(formData) {
  const sid        = Number(formData.speciesID);
  const isSingle   = Number(formData.numberOfAnimals) <= 1;
  return STEPS.filter((s) => {
    if (s.id === 3) return isSingle && !NO_ANCESTRY_IDS.includes(sid);
    if (s.id === 4) return HAS_FIBER.includes(sid);
    if (s.id === 6) return isSingle && !NO_AWARDS.includes(sid);
    return true;
  });
}

function FormField({ label, required, error, hint, children }) {
  return (
    <div className="form-field">
      {label && (
        <label className="field-label">
          {required && <span className="required-star">*</span>}{label}
        </label>
      )}
      {children}
      {hint  && <p className="field-hint">{hint}</p>}
      {error && <p className="field-error">{error}</p>}
    </div>
  );
}

function StepHeader({ title, subtitle }) {
  return (
    <div className="step-header">
      <h2 className="step-title">{title}</h2>
      {subtitle && <p className="step-subtitle">{subtitle}</p>}
    </div>
  );
}

function CategoryOptions({ speciesID, isMultiple }) {
  const isFowl = FOWL_IDS.includes(Number(speciesID));
  if (isFowl) {
    const opts = isMultiple
      ? [{v:"adult_males",l:"Adult Males"},{v:"adult_females",l:"Adult Females"},{v:"male_chicks",l:"Male Chicks"},{v:"female_chicks",l:"Female Chicks"},{v:"eggs",l:"Eggs"},{v:"preborn_chicks",l:"Preborn Chicks"}]
      : [{v:"adult_male",l:"Adult Male"},{v:"adult_female",l:"Adult Female"},{v:"male_chick",l:"Male Chick"},{v:"female_chick",l:"Female Chick"},{v:"eggs",l:"Eggs"},{v:"preborn_chick",l:"Preborn Chick"}];
    return opts.map(({v,l}) => <option key={v} value={v}>{l}</option>);
  }
  const single   = [{v:"exp_male",l:"Experienced Male"},{v:"exp_female",l:"Experienced Female"},{v:"inexp_male",l:"Inexperienced Male"},{v:"inexp_female",l:"Inexperienced Female"},{v:"non_breeder",l:"Non-Breeder"},{v:"preborn_male",l:"Preborn Male"},{v:"preborn_female",l:"Preborn Female"},{v:"preborn_baby",l:"Preborn Baby"}];
  const multiple = [{v:"exp_males",l:"Experienced Males"},{v:"exp_females",l:"Experienced Females"},{v:"inexp_males",l:"Inexperienced Males"},{v:"inexp_females",l:"Inexperienced Females"},{v:"assortment",l:"Assortment"},{v:"non_breeders",l:"Non-Breeders"},{v:"preborn_males",l:"Preborn Males"},{v:"preborn_females",l:"Preborn Females"},{v:"preborn_babies",l:"Preborn Babies"}];
  return (isMultiple ? multiple : single).map(({v,l}) => <option key={v} value={v}>{l}</option>);
}

// ── Step 1 ────────────────────────────────────────────────────────────────────
function Step1Basics({ formData, onChange, errors, subscriptionLevel }) {
  return (
    <div className="step-content">
      <StepHeader title="Basics" subtitle="Tell us about your animal listing" />
      <FormField label="Name / Title" required error={errors.name}
        hint={subscriptionLevel === 1 ? "This is either the animal's name or a title describing your animal." : "This is either the animal's name or a title describing your animal or animals."}>
        <input className={`form-input ${errors.name ? "input-error" : ""}`} type="text" maxLength={90}
          value={formData.name} onChange={(e) => onChange("name", e.target.value)} placeholder="Enter animal name or listing title" />
      </FormField>
      {subscriptionLevel > 0 && (
        <FormField label="# Animals in Listing" required error={errors.numberOfAnimals} hint="If you list only 1 animal you will be able to add a lot more information!">
          <input className={`form-input number-input ${errors.numberOfAnimals ? "input-error" : ""}`} type="number" min="1" max="9000000"
            value={formData.numberOfAnimals} onChange={(e) => onChange("numberOfAnimals", e.target.value)} />
        </FormField>
      )}
      <FormField label="Species" required error={errors.speciesID}>
        <select className={`form-select ${errors.speciesID ? "input-error" : ""}`} value={formData.speciesID} onChange={(e) => onChange("speciesID", e.target.value)}>
          <option value="">-- Select Species --</option>
          {SPECIES_LIST.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
        </select>
      </FormField>
    </div>
  );
}

// ── Step 2 ────────────────────────────────────────────────────────────────────
function Step2GeneralFacts({ formData, onChange, errors, breeds, colors, registrationTypes }) {
  const sid        = Number(formData.speciesID);
  const isMultiple = Number(formData.numberOfAnimals) > 1;
  const today      = new Date().toISOString().split("T")[0];
  const breedLabel = LLAMA_IDS.includes(sid) ? "Type" : "Breed";
  const showBreed2 = ![18,4,33,23,34].includes(sid) && breeds.length > 0;
  const showBreed3 = ![2,18,33,9,23].includes(sid) && breeds.length > 0 && showBreed2;

  return (
    <div className="step-content">
      <StepHeader title="General Facts" subtitle="Physical characteristics and registration details" />

      {registrationTypes.length > 0 && (
        <div className="section-group">
          <h3 className="section-group-title">Registration Numbers</h3>
          {registrationTypes.map((reg, i) => (
            <FormField key={i} label={reg.type}>
              <input className="form-input" type="text" value={formData.registrations?.[i]?.number || ""}
                onChange={(e) => { const r = [...(formData.registrations||[])]; r[i]={type:reg.type,number:e.target.value}; onChange("registrations",r); }} />
            </FormField>
          ))}
        </div>
      )}

      {!NO_DOB_IDS.includes(sid) && !isMultiple && (
        <FormField label="Date of Birth">
          <input className="form-input date-input" type="date" max={today} value={formData.dob||""} onChange={(e)=>onChange("dob",e.target.value)} />
        </FormField>
      )}

      {![23,33].includes(sid) && (
        <FormField label="Category" required error={errors.category}>
          <select className={`form-select ${errors.category?"input-error":""}`} value={formData.category||""} onChange={(e)=>onChange("category",e.target.value)}>
            <option value="">-- Select Category --</option>
            <CategoryOptions speciesID={sid} isMultiple={isMultiple} />
          </select>
        </FormField>
      )}

      {breeds.length > 0 && (
        <div className="section-group">
          <FormField label={`${breedLabel} 1`} required={![4,23,25,33,34].includes(sid)} error={errors.breedID}>
            <select className={`form-select ${errors.breedID?"input-error":""}`} value={formData.breedID||""} onChange={(e)=>onChange("breedID",e.target.value)}>
              <option value="">--</option>
              {breeds.map((b)=><option key={b.id} value={b.id}>{b.name}</option>)}
            </select>
          </FormField>
          {showBreed2 && (
            <FormField label={`${breedLabel} 2`}>
              <select className="form-select" value={formData.breedID2||""} onChange={(e)=>onChange("breedID2",e.target.value)}>
                <option value="">--</option>{breeds.map((b)=><option key={b.id} value={b.id}>{b.name}</option>)}
              </select>
            </FormField>
          )}
          {showBreed3 && (
            <FormField label={`${breedLabel} 3`}>
              <select className="form-select" value={formData.breedID3||""} onChange={(e)=>onChange("breedID3",e.target.value)}>
                <option value="">--</option>{breeds.map((b)=><option key={b.id} value={b.id}>{b.name}</option>)}
              </select>
            </FormField>
          )}
          {showBreed3 && (
            <FormField label={`${breedLabel} 4`}>
              <select className="form-select" value={formData.breedID4||""} onChange={(e)=>onChange("breedID4",e.target.value)}>
                <option value="">--</option>{breeds.map((b)=><option key={b.id} value={b.id}>{b.name}</option>)}
              </select>
            </FormField>
          )}
        </div>
      )}

      {!NO_COLOR_IDS.includes(sid) && colors.length > 0 && (
        <div className="section-group">
          <div className="color-grid">
            {[1,2,3,4].map((num) => {
              if (num > 2 && [14,21,33,23,22,15].includes(sid)) return null;
              return (
                <FormField key={num} label={`Color ${num}`}>
                  <select className="form-select" value={formData[`color${num}`]||""} onChange={(e)=>onChange(`color${num}`,e.target.value)}>
                    <option value="">--</option>{colors.map((c,i)=><option key={i} value={c}>{c}</option>)}
                  </select>
                </FormField>
              );
            })}
          </div>
        </div>
      )}

      {HAS_HEIGHT_WEIGHT.includes(sid) && (
        <div className="section-group">
          <div className="two-col">
            <FormField label="Height"><input className="form-input" type="number" step="0.1" min="0" placeholder="inches" value={formData.height||""} onChange={(e)=>onChange("height",e.target.value)} /></FormField>
            <FormField label="Weight"><input className="form-input" type="number" step="0.1" min="0" placeholder="lbs"    value={formData.weight||""} onChange={(e)=>onChange("weight",e.target.value)} /></FormField>
          </div>
        </div>
      )}

      {HAS_GAITED_WARMBLOOD.includes(sid) && (
        <div className="section-group">
          <div className="two-col">
            <FormField label="Gaited">
              <div className="radio-group">{["Yes","No"].map((v)=><label key={v} className="radio-label"><input type="radio" name="gaited" value={v} checked={formData.gaited===v} onChange={(e)=>onChange("gaited",e.target.value)} />{v}</label>)}</div>
            </FormField>
            <FormField label="Warmblood">
              <div className="radio-group">{["Yes","No"].map((v)=><label key={v} className="radio-label"><input type="radio" name="warmblood" value={v} checked={formData.warmblood===v} onChange={(e)=>onChange("warmblood",e.target.value)} />{v}</label>)}</div>
            </FormField>
          </div>
        </div>
      )}

      {HAS_HORNS.includes(sid) && (
        <FormField label="Horns">
          <div className="radio-group">{["Yes","No","Not Set"].map((v)=><label key={v} className="radio-label"><input type="radio" name="horns" value={v} checked={formData.horns===v} onChange={(e)=>onChange("horns",e.target.value)} />{v}</label>)}</div>
        </FormField>
      )}

      {!NO_TEMPERAMENT.includes(sid) && (
        <FormField label="Temperament" hint="1 = Very Gentle, 10 = Very Aggressive">
          <div className="temperament-scale">
            {[1,2,3,4,5,6,7,8,9,10].map((n)=>(
              <label key={n} className="temp-label">
                <input type="radio" name="temperament" value={n} checked={Number(formData.temperament)===n} onChange={(e)=>onChange("temperament",e.target.value)} />
                <span className="temp-num">{n}</span>
              </label>
            ))}
          </div>
          <div className="temp-legend"><span>Gentle</span><span>Aggressive</span></div>
        </FormField>
      )}

      {HAS_ALPACA_PERCENTS.includes(sid) && (
        <div className="section-group">
          <h3 className="section-group-title">Bloodline Percentages</h3>
          <div className="alpaca-percents">
            {[{key:"percentPeruvian",label:"Peruvian"},{key:"percentChilean",label:"Chilean"},{key:"percentBolivian",label:"Bolivian"},{key:"percentUnknownOther",label:"Unknown / Other"},{key:"percentAccoyo",label:"Accoyo"}].map(({key,label})=>(
              <FormField key={key} label={label}>
                <select className="form-select" value={formData[key]||""} onChange={(e)=>onChange(key,e.target.value)}>
                  <option value="">--</option>{ALPACA_FRACTIONS.map((f)=><option key={f} value={f}>{f}</option>)}
                </select>
              </FormField>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

// ── Step 3 ────────────────────────────────────────────────────────────────────
function Step3Ancestry({ formData, onChange }) {
  const isAlpaca = Number(formData.speciesID) === 2;
  const ancestors = [
    {key:"sire",label:"Sire"},{key:"dam",label:"Dam"},
    {key:"sireSire",label:"Sire's Sire (Paternal Grandsire)"},{key:"sireDam",label:"Sire's Dam (Paternal Granddam)"},
    {key:"damSire",label:"Dam's Sire (Maternal Grandsire)"},{key:"damDam",label:"Dam's Dam (Maternal Granddam)"},
    {key:"sireSireSire",label:"Sire's Sire's Sire"},{key:"sireSireDam",label:"Sire's Sire's Dam"},
    {key:"sireDamSire",label:"Sire's Dam's Sire"},{key:"sireDamDam",label:"Sire's Dam's Dam"},
    {key:"damSireSire",label:"Dam's Sire's Sire"},{key:"damSireDam",label:"Dam's Sire's Dam"},
    {key:"damDamSire",label:"Dam's Dam's Sire"},{key:"damDamDam",label:"Dam's Dam's Dam"},
  ];
  const getDepth = (key) => key==="sire"||key==="dam" ? 1 : ["sireSire","sireDam","damSire","damDam"].includes(key) ? 2 : 3;
  const upd = (ak,field,val) => onChange("ancestry",{...(formData.ancestry||{}),[ak]:{...((formData.ancestry||{})[ak]||{}),[field]:val}});

  return (
    <div className="step-content">
      <StepHeader title="Ancestry / Pedigree" subtitle="Enter up to 3 generations of lineage" />
      <div className="pedigree-tree">
        {ancestors.map(({key,label}) => {
          const val=formData.ancestry?.[key]||{};
          return (
            <div key={key} className={`ancestor-card depth-${getDepth(key)}`}>
              <div className="ancestor-label">{label}</div>
              <div className="ancestor-fields">
                <input className="form-input" type="text" placeholder="Name"  value={val.name||""}  onChange={(e)=>upd(key,"name",e.target.value)} />
                <input className="form-input" type="text" placeholder="Color" value={val.color||""} onChange={(e)=>upd(key,"color",e.target.value)} />
                {isAlpaca && <>
                  <input className="form-input" type="text" placeholder="ARI #"  value={val.ari||""}  onChange={(e)=>upd(key,"ari",e.target.value)} />
                  <input className="form-input" type="text" placeholder="CLAA #" value={val.claa||""} onChange={(e)=>upd(key,"claa",e.target.value)} />
                </>}
              </div>
            </div>
          );
        })}
      </div>
      <FormField label="Ancestry Description / Percentages">
        <textarea className="form-textarea" rows={4} value={formData.ancestryDescription||""} onChange={(e)=>onChange("ancestryDescription",e.target.value)} placeholder="Describe bloodline percentages or additional details..." />
      </FormField>
    </div>
  );
}

// ── Step 4 ────────────────────────────────────────────────────────────────────
function Step4FiberFacts({ formData, onChange }) {
  const samples = formData.fiberSamples || Array(10).fill({});
  const upd = (i,field,val) => { const u=[...samples]; u[i]={...u[i],[field]:val}; onChange("fiberSamples",u); };
  const fields = [{key:"afd",label:"AFD (Avg Fiber Diameter)"},{key:"sd",label:"SD (Std Deviation)"},{key:"cov",label:"COV (%)"},{key:"cf",label:"CF (Comfort Factor %)"},{key:"gt30",label:"% > 30 Microns"},{key:"curve",label:"Curve"},{key:"crimpsPerInch",label:"Crimps / Inch"},{key:"stapleLength",label:"Staple Length (in)"},{key:"shearWeight",label:"Shear Weight (lbs)"},{key:"blanketWeight",label:"Blanket Weight (lbs)"}];

  return (
    <div className="step-content">
      <StepHeader title="Fiber Facts" subtitle="Enter up to 10 fiber sample records" />
      <div className="fiber-samples">
        {samples.map((sample,i) => (
          <details key={i} className="fiber-sample">
            <summary className="fiber-sample-title">Sample {i+1}{sample.sampleDate?` — ${sample.sampleDate}`:""}</summary>
            <div className="fiber-sample-fields">
              <FormField label="Sample Date"><input type="date" className="form-input" value={sample.sampleDate||""} onChange={(e)=>upd(i,"sampleDate",e.target.value)} /></FormField>
              <div className="fiber-grid">
                {fields.map(({key,label})=>(
                  <FormField key={key} label={label}><input type="number" step="0.01" className="form-input" value={sample[key]||""} onChange={(e)=>upd(i,key,e.target.value)} /></FormField>
                ))}
              </div>
            </div>
          </details>
        ))}
      </div>
    </div>
  );
}

// ── Step 5 ────────────────────────────────────────────────────────────────────
function Step5Description({ formData, onChange }) {
  return (
    <div className="step-content">
      <StepHeader title="Description" subtitle="Write a detailed description of your animal or listing" />
      <FormField label="Description">
        <textarea className="form-textarea description-textarea" rows={14} value={formData.description||""} onChange={(e)=>onChange("description",e.target.value)} placeholder="Describe your animal — temperament, history, health records, special qualities..." />
      </FormField>
      <p className="field-hint">HTML formatting is supported. Use &lt;b&gt;, &lt;i&gt;, &lt;br /&gt;, and &lt;p&gt; tags for styling.</p>
    </div>
  );
}

// ── Step 6 ────────────────────────────────────────────────────────────────────
function Step6Awards({ formData, onChange }) {
  const isAlpaca = Number(formData.speciesID)===2;
  const awards   = formData.awards||Array(10).fill({});
  const yr       = new Date().getFullYear();
  const years    = Array.from({length:yr-1982},(_,i)=>yr-i);
  const classes  = ["Halter","Fleece","Composite","Shorn","Spin-off","Get of Sire","Produce of Dam","Performance"];
  const placings = ["Color Champion","Res. Color Champion","1st Place","2nd Place","3rd Place","4th Place","5th Place","6th Place","7th Place","8th Place","9th Place","10th Place","11th Place","12th Place","Best Crimp","Judge's Choice"];
  const upd = (i,f,v) => { const u=awards.map((a,idx)=>idx===i?{...a,[f]:v}:a); onChange("awards",u); };

  return (
    <div className="step-content">
      <StepHeader title="Awards" subtitle="Record up to 10 show awards and achievements" />
      <div className="awards-list">
        {awards.map((award,i)=>(
          <details key={i} className="award-item">
            <summary className="award-title">Award {i+1}{award.year?` — ${award.year}`:""}{award.show?` · ${award.show}`:""}</summary>
            <div className="award-fields">
              <div className="two-col">
                <FormField label="Year">
                  <select className="form-select" value={award.year||""} onChange={(e)=>upd(i,"year",e.target.value)}>
                    <option value="">--</option>{years.map((y)=><option key={y} value={y}>{y}</option>)}
                  </select>
                </FormField>
                <FormField label="Show"><input type="text" className="form-input" value={award.show||""} onChange={(e)=>upd(i,"show",e.target.value)} /></FormField>
              </div>
              <div className="two-col">
                <FormField label="Class">
                  {isAlpaca ? <select className="form-select" value={award.class||""} onChange={(e)=>upd(i,"class",e.target.value)}><option value="">--</option>{classes.map((c)=><option key={c} value={c}>{c}</option>)}</select>
                            : <input type="text" className="form-input" value={award.class||""} onChange={(e)=>upd(i,"class",e.target.value)} />}
                </FormField>
                <FormField label="Placing">
                  {isAlpaca ? <select className="form-select" value={award.placing||""} onChange={(e)=>upd(i,"placing",e.target.value)}><option value="">--</option>{placings.map((p)=><option key={p} value={p}>{p}</option>)}</select>
                            : <input type="text" className="form-input" value={award.placing||""} onChange={(e)=>upd(i,"placing",e.target.value)} />}
                </FormField>
              </div>
              <FormField label="Description"><textarea className="form-textarea" rows={3} value={award.description||""} onChange={(e)=>upd(i,"description",e.target.value)} /></FormField>
            </div>
          </details>
        ))}
      </div>
    </div>
  );
}

// ── Step 7 ────────────────────────────────────────────────────────────────────
function Step7Pricing({ formData, onChange, errors }) {
  const sid      = Number(formData.speciesID);
  const isFowl   = FOWL_IDS.includes(sid);
  const cat      = formData.category||"";
  const isFemale = cat.includes("female")||cat.includes("Female");
  const isMale   = cat.includes("male")||cat.includes("Male");
  const isEggs   = cat==="eggs";
  const discounts = Array.from({length:21},(_,i)=>i*5);
  const Radio = ({name,value,checked,onChange:oc}) => <label className="radio-label"><input type="radio" name={name} value={value} checked={checked} onChange={oc} />{value}</label>;

  return (
    <div className="step-content">
      <StepHeader title="Pricing" subtitle="Set your sale price and listing options" />
      <div className="pricing-grid">
        <FormField label="For Sale?"><div className="radio-group">{["Yes","No"].map((v)=><Radio key={v} name="forSale" value={v} checked={(formData.forSale??"Yes")===v} onChange={(e)=>onChange("forSale",e.target.value)} />)}</div></FormField>

        {formData.forSale!=="No" && <>
          <FormField label="Free?"><div className="radio-group">{["Yes","No"].map((v)=><Radio key={v} name="free" value={v} checked={(formData.free??"No")===v} onChange={(e)=>onChange("free",e.target.value)} />)}</div></FormField>

          {formData.free!=="Yes" && <>
            {isEggs && isFowl ? (
              <div className="section-group">
                <h3 className="section-group-title">Egg Pricing</h3>
                {[{key:"price",label:"Unsexed",mk:"minOrder1",xk:"maxOrder1"},{key:"price2",label:"Female",mk:"minOrder2",xk:"maxOrder2"},{key:"price3",label:"Male",mk:"minOrder3",xk:"maxOrder3"},{key:"price4",label:"Fertilized",mk:"minOrder4",xk:"maxOrder4"}].map(({key,label,mk,xk})=>(
                  <div key={key} className="egg-pricing-row">
                    <FormField label={`${label} Price`}><div className="price-input-wrap"><span className="price-symbol">$</span><input type="number" className="form-input price-input" min="0" step="0.01" value={formData[key]||""} onChange={(e)=>onChange(key,e.target.value)} /></div></FormField>
                    <div className="two-col">
                      <FormField label="Min Order"><input type="number" className="form-input" min="1" value={formData[mk]||""} onChange={(e)=>onChange(mk,e.target.value)} /></FormField>
                      <FormField label="Max Order"><input type="number" className="form-input" min="1" value={formData[xk]||""} onChange={(e)=>onChange(xk,e.target.value)} /></FormField>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <FormField label="Price" error={errors?.price}><div className="price-input-wrap"><span className="price-symbol">$</span><input type="number" className={`form-input price-input ${errors?.price?"input-error":""}`} min="0" step="0.01" value={formData.price||""} onChange={(e)=>onChange("price",e.target.value)} /></div></FormField>
            )}
            <FormField label="Or Best Offer (OBO)?"><div className="radio-group">{["Yes","No"].map((v)=><Radio key={v} name="obo" value={v} checked={(formData.obo??"No")===v} onChange={(e)=>onChange("obo",e.target.value)} />)}</div></FormField>
            <FormField label="Discount"><select className="form-select" value={formData.discount||"0"} onChange={(e)=>onChange("discount",e.target.value)}>{discounts.map((d)=><option key={d} value={d}>{d}%</option>)}</select></FormField>
          </>}
        </>}

        <FormField label="Foundation Animal?">
          <div className="radio-group">{["Yes","No"].map((v)=><Radio key={v} name="foundation" value={v} checked={(formData.foundation??"No")===v} onChange={(e)=>onChange("foundation",e.target.value)} />)}</div>
          <p className="field-hint">Mark as Foundation if this is an important breeding animal not for sale.</p>
        </FormField>
      </div>

      {isMale && !isFowl && (
        <div className="section-group">
          <h3 className="section-group-title">Stud Services</h3>
          <FormField label="Stud Fee"><div className="price-input-wrap"><span className="price-symbol">$</span><input type="number" className="form-input price-input" min="0" step="0.01" value={formData.studFee||""} onChange={(e)=>onChange("studFee",e.target.value)} /></div></FormField>
          <FormField label="Pay What You Can?"><div className="radio-group">{["Yes","No"].map((v)=><Radio key={v} name="payWhatYouCan" value={v} checked={(formData.payWhatYouCan??"No")===v} onChange={(e)=>onChange("payWhatYouCan",e.target.value)} />)}</div></FormField>
          <FormField label="Semen Available?"><div className="radio-group">{["Yes","No"].map((v)=><Radio key={v} name="donorMale" value={v} checked={(formData.donorMale??"No")===v} onChange={(e)=>onChange("donorMale",e.target.value)} />)}</div></FormField>
          {formData.donorMale==="Yes" && <FormField label="Semen Price (per straw)"><div className="price-input-wrap"><span className="price-symbol">$</span><input type="number" className="form-input price-input" min="0" step="0.01" value={formData.semenPrice||""} onChange={(e)=>onChange("semenPrice",e.target.value)} /></div></FormField>}
        </div>
      )}

      {isFemale && !isFowl && (
        <div className="section-group">
          <h3 className="section-group-title">Embryo / Donor</h3>
          <FormField label="Embryo Donor?"><div className="radio-group">{["Yes","No"].map((v)=><Radio key={v} name="donorFemale" value={v} checked={(formData.donorFemale??"No")===v} onChange={(e)=>onChange("donorFemale",e.target.value)} />)}</div></FormField>
          {formData.donorFemale==="Yes" && <FormField label="Embryo Price (per embryo)"><div className="price-input-wrap"><span className="price-symbol">$</span><input type="number" className="form-input price-input" min="0" step="0.01" value={formData.embryoPrice||""} onChange={(e)=>onChange("embryoPrice",e.target.value)} /></div></FormField>}
        </div>
      )}

      <FormField label="Price Comments"><textarea className="form-textarea" rows={3} maxLength={500} value={formData.priceComments||""} onChange={(e)=>onChange("priceComments",e.target.value)} /></FormField>

      <div className="section-group">
        <h3 className="section-group-title">Co-Owners (Optional)</h3>
        {[1,2,3].map((n)=>(
          <div key={n} className="coowner-row">
            <FormField label={`Co-Owner ${n} Business`}><input type="text" className="form-input" value={formData[`coOwnerBusiness${n}`]||""} onChange={(e)=>onChange(`coOwnerBusiness${n}`,e.target.value)} /></FormField>
            <FormField label="Name"><input type="text" className="form-input" value={formData[`coOwnerName${n}`]||""} onChange={(e)=>onChange(`coOwnerName${n}`,e.target.value)} /></FormField>
            <FormField label="Link (http://)"><input type="url" className="form-input" value={formData[`coOwnerLink${n}`]||""} onChange={(e)=>onChange(`coOwnerLink${n}`,e.target.value)} placeholder="http://" /></FormField>
          </div>
        ))}
      </div>
    </div>
  );
}

// ── Step 8 ────────────────────────────────────────────────────────────────────
function Step8Photos({ formData, onChange, subscriptionLevel }) {
  const sid      = Number(formData.speciesID);
  const hasDocs  = [2,4,6,10,11].includes(sid);
  const hasVideo = subscriptionLevel >= 3;
  const maxPhotos = subscriptionLevel<=1 ? 1 : subscriptionLevel===2 ? 3 : 16;
  const photos   = formData.photos||[];

  const handlePhoto = (i,file) => {
    if (!file) return;
    if (file.size > 1024*1024) { alert("Photo must be under 1MB"); return; }
    const r = new FileReader();
    r.onload = (e) => { const u=[...photos]; u[i]={file,preview:e.target.result,caption:photos[i]?.caption||""}; onChange("photos",u); };
    r.readAsDataURL(file);
  };

  return (
    <div className="step-content">
      <StepHeader title="Photos & Documents" subtitle={`Upload up to ${maxPhotos} photo${maxPhotos>1?"s":""} (JPG/PNG, under 1MB each)`} />
      <div className="photo-grid">
        {Array.from({length:maxPhotos}).map((_,i)=>{
          const photo=photos[i];
          return (
            <div key={i} className="photo-slot">
              <div className={`photo-drop ${photo?"has-photo":""}`} onClick={()=>document.getElementById(`pi-${i}`).click()}>
                {photo?.preview ? <img src={photo.preview} alt={`Photo ${i+1}`} className="photo-preview" />
                  : <div className="photo-placeholder"><span className="photo-icon">📷</span><span className="photo-num">Photo {i+1}</span></div>}
                <input id={`pi-${i}`} type="file" accept=".jpg,.jpeg,.png" style={{display:"none"}} onChange={(e)=>handlePhoto(i,e.target.files[0])} />
              </div>
              {photo && <input type="text" className="form-input caption-input" placeholder="Caption (optional)" value={photo.caption||""} onChange={(e)=>{ const u=photos.map((p,idx)=>idx===i?{...p,caption:e.target.value}:p); onChange("photos",u); }} />}
            </div>
          );
        })}
      </div>
      <div className="section-group">
        <h3 className="section-group-title">Documents</h3>
        <div className="doc-uploads">
          <FormField label="Registration Certificate" hint="PDF or JPG, under 1MB"><input type="file" accept=".pdf,.jpg,.jpeg" className="form-file" onChange={(e)=>onChange("ariDoc",e.target.files[0])} /></FormField>
          {hasDocs && <FormField label="Histogram" hint="PDF or JPG, under 1MB"><input type="file" accept=".pdf,.jpg,.jpeg" className="form-file" onChange={(e)=>onChange("histogramDoc",e.target.files[0])} /></FormField>}
          {hasDocs && <FormField label="Fiber Analysis" hint="PDF or JPG, under 1MB"><input type="file" accept=".pdf,.jpg,.jpeg" className="form-file" onChange={(e)=>onChange("fiberDoc",e.target.files[0])} /></FormField>}
          {hasVideo && <FormField label="Video (YouTube Embed Code)"><textarea className="form-textarea" rows={3} value={formData.videoEmbed||""} onChange={(e)=>onChange("videoEmbed",e.target.value)} placeholder='<iframe src="https://www.youtube.com/embed/..." ...>' /></FormField>}
        </div>
      </div>
    </div>
  );
}

// ── Main Wizard ───────────────────────────────────────────────────────────────
export default function AnimalAddWizard() {
  const [searchParams]    = useSearchParams();
  const businessID        = searchParams.get("BusinessID");
  const token             = localStorage.getItem("AccessToken");
  const subscriptionLevel = Number(localStorage.getItem("SubscriptionLevel")||0);
  const apiBase           = import.meta.env.VITE_API_URL;

  const [formData,          setFormData]          = useState(INITIAL_FORM_DATA);
  const [currentStepId,     setCurrentStepId]     = useState(1);
  const [errors,            setErrors]            = useState({});
  const [breeds,            setBreeds]            = useState([]);
  const [colors,            setColors]            = useState([]);
  const [registrationTypes, setRegistrationTypes] = useState([]);
  const [isSubmitting,      setIsSubmitting]      = useState(false);
  const [submitSuccess,     setSubmitSuccess]     = useState(false);

  const visibleSteps     = getVisibleSteps(formData);
  const currentStepIndex = visibleSteps.findIndex((s)=>s.id===currentStepId);
  const isFirstStep      = currentStepIndex===0;
  const isLastStep       = currentStepIndex===visibleSteps.length-1;

  useEffect(()=>{
    if (!formData.speciesID) { setBreeds([]); setColors([]); setRegistrationTypes([]); return; }
    const sid=formData.speciesID, h={Authorization:`Bearer ${token}`};
    fetch(`${apiBase}/auth/species/${sid}/breeds`,             {headers:h}).then(r=>r.json()).then(setBreeds).catch(()=>setBreeds([]));
    fetch(`${apiBase}/auth/species/${sid}/colors`,             {headers:h}).then(r=>r.json()).then(setColors).catch(()=>setColors([]));
    fetch(`${apiBase}/auth/species/${sid}/registration-types`, {headers:h}).then(r=>r.json()).then(setRegistrationTypes).catch(()=>setRegistrationTypes([]));
  },[formData.speciesID]);

  const handleChange = useCallback((field,value)=>{
    setFormData(p=>({...p,[field]:value}));
    setErrors(p=>({...p,[field]:undefined}));
  },[]);

  const validateStep = (stepId) => {
    const e={};
    if (stepId===1) {
      if (!formData.name?.trim())     e.name="Name is required";
      if (formData.name?.length>90)   e.name="Name must be 90 characters or fewer";
      if (!formData.speciesID)        e.speciesID="Please select a species";
      if (!formData.numberOfAnimals||formData.numberOfAnimals<1) e.numberOfAnimals="Please enter number of animals";
    }
    if (stepId===2) {
      const sid=Number(formData.speciesID);
      if (![23,33].includes(sid)&&!formData.category) e.category="Please select a category";
      if (breeds.length>0&&![4,23,25,33,34].includes(sid)&&!formData.breedID) e.breedID="Please select a breed";
    }
    return e;
  };

  const handleNext = () => {
    const e=validateStep(currentStepId);
    if (Object.keys(e).length>0) { setErrors(e); return; }
    if (!isLastStep) { setCurrentStepId(visibleSteps[currentStepIndex+1].id); window.scrollTo({top:0,behavior:"smooth"}); }
  };

  const handleBack = () => {
    if (!isFirstStep) { setCurrentStepId(visibleSteps[currentStepIndex-1].id); window.scrollTo({top:0,behavior:"smooth"}); }
  };

  const handleSubmit = async () => {
    setIsSubmitting(true);
    try {
      const p=new FormData();
      const a=(k,v)=>p.append(k,v??'');
      a("BusinessID",businessID); a("Name",formData.name); a("SpeciesID",formData.speciesID);
      a("NumberOfAnimals",formData.numberOfAnimals); a("Category",formData.category); a("DOB",formData.dob);
      a("BreedID",formData.breedID); a("BreedID2",formData.breedID2); a("BreedID3",formData.breedID3); a("BreedID4",formData.breedID4);
      a("Color1",formData.color1); a("Color2",formData.color2); a("Color3",formData.color3); a("Color4",formData.color4);
      a("Height",formData.height); a("Weight",formData.weight); a("Gaited",formData.gaited);
      a("Warmblood",formData.warmblood); a("Horns",formData.horns); a("Temperament",formData.temperament);
      a("Description",formData.description); a("Registrations",JSON.stringify(formData.registrations));
      a("Ancestry",JSON.stringify(formData.ancestry)); a("AncestryDescription",formData.ancestryDescription);
      a("FiberSamples",JSON.stringify(formData.fiberSamples)); a("Awards",JSON.stringify(formData.awards));
      a("PercentPeruvian",formData.percentPeruvian); a("PercentChilean",formData.percentChilean);
      a("PercentBolivian",formData.percentBolivian); a("PercentUnknownOther",formData.percentUnknownOther); a("PercentAccoyo",formData.percentAccoyo);
      a("ForSale",formData.forSale); a("Free",formData.free); a("Price",formData.price);
      a("Price2",formData.price2); a("Price3",formData.price3); a("Price4",formData.price4);
      a("MinOrder1",formData.minOrder1); a("MinOrder2",formData.minOrder2); a("MinOrder3",formData.minOrder3); a("MinOrder4",formData.minOrder4);
      a("MaxOrder1",formData.maxOrder1); a("MaxOrder2",formData.maxOrder2); a("MaxOrder3",formData.maxOrder3); a("MaxOrder4",formData.maxOrder4);
      a("OBO",formData.obo); a("Discount",formData.discount); a("Foundation",formData.foundation);
      a("StudFee",formData.studFee); a("PayWhatYouCan",formData.payWhatYouCan); a("DonorMale",formData.donorMale);
      a("SemenPrice",formData.semenPrice); a("DonorFemale",formData.donorFemale); a("EmbryoPrice",formData.embryoPrice);
      a("PriceComments",formData.priceComments);
      a("CoOwnerBusiness1",formData.coOwnerBusiness1); a("CoOwnerName1",formData.coOwnerName1); a("CoOwnerLink1",formData.coOwnerLink1);
      a("CoOwnerBusiness2",formData.coOwnerBusiness2); a("CoOwnerName2",formData.coOwnerName2); a("CoOwnerLink2",formData.coOwnerLink2);
      a("CoOwnerBusiness3",formData.coOwnerBusiness3); a("CoOwnerName3",formData.coOwnerName3); a("CoOwnerLink3",formData.coOwnerLink3);
      a("VideoEmbed",formData.videoEmbed);
      formData.photos.forEach((ph,i)=>{ if(ph?.file) p.append(`Photo${i+1}`,ph.file); if(ph?.caption) p.append(`Caption${i+1}`,ph.caption); });
      if(formData.ariDoc)       p.append("AriDoc",formData.ariDoc);
      if(formData.histogramDoc) p.append("HistogramDoc",formData.histogramDoc);
      if(formData.fiberDoc)     p.append("FiberDoc",formData.fiberDoc);

      const res=await fetch(`${apiBase}/auth/animals/add`,{method:"POST",headers:{Authorization:`Bearer ${token}`},body:p});
      if(!res.ok){ const err=await res.json().catch(()=>({})); throw new Error(err.detail||"Failed to save animal"); }
      setSubmitSuccess(true);
      setTimeout(()=>{ window.location.href=`/animals?BusinessID=${businessID}`; },1500);
    } catch(err) {
      setErrors({submit:err.message});
    } finally {
      setIsSubmitting(false);
    }
  };

  if (submitSuccess) {
    return (
      <AccountLayout>
        <div className="wizard-success">
          <div className="success-icon">🎉</div>
          <h2>Animal Added Successfully!</h2>
          <p>Redirecting to your animals...</p>
        </div>
      </AccountLayout>
    );
  }

  const step = visibleSteps[currentStepIndex];

  return (
    <AccountLayout>
      <div className="animal-wizard">
        <div className="wizard-progress">
          <div className="progress-steps">
            {visibleSteps.map((s,i)=>{
              const status=i<currentStepIndex?"completed":i===currentStepIndex?"active":"upcoming";
              return (
                <div key={s.id} className={`progress-step ${status}`}>
                  <div className="step-dot">{status==="completed"?<span>✓</span>:<span>{s.icon}</span>}</div>
                  <span className="step-dot-label">{s.label}</span>
                  {i<visibleSteps.length-1 && <div className={`step-connector ${status==="completed"?"filled":""}`} />}
                </div>
              );
            })}
          </div>
          <div className="progress-bar-track">
            <div className="progress-bar-fill" style={{width:`${((currentStepIndex+1)/visibleSteps.length)*100}%`}} />
          </div>
        </div>

        <div className="wizard-body">
          {step?.id===1 && <Step1Basics        formData={formData} onChange={handleChange} errors={errors} subscriptionLevel={subscriptionLevel} />}
          {step?.id===2 && <Step2GeneralFacts  formData={formData} onChange={handleChange} errors={errors} breeds={breeds} colors={colors} registrationTypes={registrationTypes} />}
          {step?.id===3 && <Step3Ancestry      formData={formData} onChange={handleChange} />}
          {step?.id===4 && <Step4FiberFacts    formData={formData} onChange={handleChange} />}
          {step?.id===5 && <Step5Description   formData={formData} onChange={handleChange} />}
          {step?.id===6 && <Step6Awards        formData={formData} onChange={handleChange} />}
          {step?.id===7 && <Step7Pricing       formData={formData} onChange={handleChange} errors={errors} />}
          {step?.id===8 && <Step8Photos        formData={formData} onChange={handleChange} subscriptionLevel={subscriptionLevel} />}
          {errors.submit && <div className="submit-error">⚠️ {errors.submit}</div>}
        </div>

        <div className="wizard-nav">
          <button className="nav-btn back-btn" onClick={handleBack} disabled={isFirstStep}>← Back</button>
          <span className="step-counter">Step {currentStepIndex+1} of {visibleSteps.length}</span>
          {isLastStep
            ? <button className="nav-btn submit-btn" onClick={handleSubmit} disabled={isSubmitting}>{isSubmitting?"Saving...":"Save Animal ✓"}</button>
            : <button className="nav-btn next-btn" onClick={handleNext}>Next →</button>}
        </div>
      </div>
    </AccountLayout>
  );
}
