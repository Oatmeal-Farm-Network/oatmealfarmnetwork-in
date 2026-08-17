/** India crop seasons for Field Twin (calendar month in the field timezone / local date). */

export const INDIA_SEASONS = [
  { id: 'kharif', label: 'Kharif', months: 'Jun–Oct', rainHintMm: 80 },
  { id: 'rabi', label: 'Rabi', months: 'Nov–Mar', rainHintMm: 25 },
  { id: 'zaid', label: 'Zaid', months: 'Mar–Jun', rainHintMm: 40 },
];

export function indiaSeasonFromDate(d = new Date()) {
  const month = d.getMonth() + 1;
  if (month >= 6 && month <= 10) return INDIA_SEASONS[0];
  if (month === 11 || month === 12 || month <= 3) return INDIA_SEASONS[1];
  return INDIA_SEASONS[2];
}

export function monsoonPreset(seasonId) {
  if (seasonId === 'kharif') {
    return {
      rainfall_mm: 80,
      irrigation_mm: 0,
      duration_hours: 6,
      infiltration_class: 'moderate',
      antecedent: 'wet',
      label: 'monsoon_burst',
    };
  }
  if (seasonId === 'rabi') {
    return {
      rainfall_mm: 25,
      irrigation_mm: 0,
      duration_hours: 6,
      infiltration_class: 'moderate',
      antecedent: 'normal',
      label: 'rabi_rain',
    };
  }
  return {
    rainfall_mm: 40,
    irrigation_mm: 0,
    duration_hours: 6,
    infiltration_class: 'moderate',
    antecedent: 'normal',
    label: 'zaid_rain',
  };
}

export function canalIrrigatePreset() {
  return {
    rainfall_mm: 10,
    irrigation_mm: 40,
    duration_hours: 8,
    infiltration_class: 'moderate',
    antecedent: 'normal',
    label: 'canal_set',
  };
}
