const Web3Import = require("web3");
const Web3 = Web3Import.default || Web3Import;

const TouristID = require("../build/contracts/TouristID.json");

const web3 = new Web3("http://127.0.0.1:8545");
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"; // update as needed
const contract = new web3.eth.Contract(TouristID.abi, contractAddress);


async function generateTouristID(aadhaarNumber, validDays) {
  // Example: Map Aadhaar to tourist address (in practice, lookup or create wallet)
  const accounts = await web3.eth.getAccounts();
  const touristAddress = accounts[1]; // Pick an account for tourist
  const adminAddress = accounts[0];   // Admin account to send tx

  // Mock encryption: In reality encrypt before
  const encryptedName = "encryptedNameExample";
  const encryptedNationality = "encryptedNationalityExample";
  const ipfsDocHash = "QmExampleIPFSHash";

  // Use Aadhaar as KYC hash (ideally hash or encrypt it)
  const kycHash = aadhaarNumber;

  // Calculate UNIX timestamp for validity
  const validUntil = Math.floor(Date.now() / 1000) + validDays * 24 * 60 * 60;

  console.log(`Generating ID for tourist ${touristAddress} with Aadhaar ${aadhaarNumber} valid till ${new Date(validUntil * 1000)}`);

  await contract.methods.generateID(
    touristAddress,
    encryptedName,
    encryptedNationality,
    kycHash,
    ipfsDocHash,
    validUntil
  ).send({ from: adminAddress, gas: 3000000 });

  console.log("ID generated successfully.");
}

// Read arguments from command line
const [,, aadhaar, days] = process.argv;
if (!aadhaar || !days) {
  console.log("Usage: node generateIDFromAadhaar.js <aadhaarNumber> <validityDays>");
  process.exit(1);
}

generateTouristID(aadhaar, parseInt(days)).catch(console.error);
