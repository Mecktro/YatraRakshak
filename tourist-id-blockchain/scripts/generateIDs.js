const Web3Import = require("web3");
const Web3 = Web3Import.default || Web3Import;
const TouristID = require("../build/contracts/TouristID.json");

const web3 = new Web3("http://127.0.0.1:8545");
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
const contract = new web3.eth.Contract(TouristID.abi, contractAddress);

async function generateID(tourist) {
  const accounts = await web3.eth.getAccounts();
  const tx = contract.methods.generateID(
    tourist.tourist_id,
    tourist.encrypted_name,
    tourist.encrypted_nationality,
    tourist.kyc_hash,
    tourist.ipfs_doc_hash,
    Math.floor(new Date(tourist.valid_until).getTime() / 1000)
  );

  const gas = await tx.estimateGas({ from: accounts[0] });
  const gasPrice = await web3.eth.getGasPrice();

  const receipt = await tx.send({ from: accounts[0], gas, gasPrice });
  console.log(`ID generated with transaction hash: ${receipt.transactionHash}`);
}

// Example usage
generateID({
  tourist_id: "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",
  encrypted_name: "encryptedNameSample",
  encrypted_nationality: "encryptedNationalitySample",
  kyc_hash: "aadhaar_hash_91723",
  ipfs_doc_hash: "Qmc3AGsWXJ2ZWy...",
  valid_until: "2025-12-31T23:59:59Z"
}).catch(console.error);

