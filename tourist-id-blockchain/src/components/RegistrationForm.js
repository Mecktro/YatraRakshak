import React, { useState } from "react";

export default function RegistrationForm({ generateID }) {
  const [name, setName] = useState("");
  const [nationality, setNationality] = useState("");
  const [kycHash, setKycHash] = useState("");
  const [docHash, setDocHash] = useState("");
  const [validUntil, setValidUntil] = useState("");
  // encryption & IPFS logic handled in backend

  const handleSubmit = async (e) => {
    e.preventDefault();
    await generateID({
      name,
      nationality,
      kycHash,
      docHash,
      validUntil
    });
  };

  return (
    <form onSubmit={handleSubmit}>
      {/* Inputs for encrypted data setup */}
      <input type="text" value={name} onChange={e => setName(e.target.value)} placeholder="Encrypted Name" required/>
      <input type="text" value={nationality} onChange={e => setNationality(e.target.value)} placeholder="Encrypted Nationality" required/>
      <input type="text" value={kycHash} onChange={e => setKycHash(e.target.value)} placeholder="KYC Hash" required/>
      <input type="text" value={docHash} onChange={e => setDocHash(e.target.value)} placeholder="IPFS Document Hash" required/>
      <input type="date" value={validUntil} onChange={e => setValidUntil(e.target.value)} required/>
      <button type="submit">Register</button>
    </form>
  );
}
