async function main() {
  const [deployer] = await ethers.getSigners(); // get first available account

  console.log("Deploying contract with account:", deployer.address);

  const TouristID = await ethers.getContractFactory("TouristID");
  const touristID = await TouristID.deploy();

  await touristID.deployed();

  console.log("TouristID deployed to:", touristID.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
