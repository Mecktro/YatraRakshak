const Web3 = require("web3");
const TouristID = require("./build/contracts/TouristID.json");  // Adjust path if needed

const web3 = new Web3("http://127.0.0.1:8545");

const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
const contract = new web3.eth.Contract(TouristID.abi, contractAddress);
