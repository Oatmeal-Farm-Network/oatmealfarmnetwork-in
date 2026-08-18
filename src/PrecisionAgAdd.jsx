import React from 'react';
import { useSearchParams, Navigate } from 'react-router-dom';

// "/precision-ag/add" is linked from AccountNav and AccountHome's "Add Field".
// Send users to the field form (address + map draw) — not Crop Detection.
export default function PrecisionAgAdd() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  return (
    <Navigate
      to={`/precision-ag/fields?BusinessID=${BusinessID || ''}&view=create-field`}
      replace
    />
  );
}