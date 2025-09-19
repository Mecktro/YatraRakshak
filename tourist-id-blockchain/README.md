# Sample Hardhat 3 Beta Project (`mocha` and `ethers`)

This project showcases a Hardhat 3 Beta project using `mocha` for tests and the `ethers` library for Ethereum interactions.

To learn more about the Hardhat 3 Beta, please visit the [Getting Started guide](https://hardhat.org/docs/getting-started#getting-started-with-hardhat-3). To share your feedback, join our [Hardhat 3 Beta](https://hardhat.org/hardhat3-beta-telegram-group) Telegram group or [open an issue](https://github.com/NomicFoundation/hardhat/issues/new) in our GitHub issue tracker.

## Project Overview

This example project includes:

- A simple Hardhat configuration file.
- Foundry-compatible Solidity unit tests.
- TypeScript integration tests using `mocha` and ethers.js
- Examples demonstrating how to connect to different types of networks, including locally simulating OP mainnet.

## Usage

### Running Tests

To run all the tests in the project, execute the following command:

```shell
npx hardhat test
```

You can also selectively run the Solidity or `mocha` tests:

```shell
npx hardhat test solidity
npx hardhat test mocha
```

### Make a deployment to Sepolia

This project includes an example Ignition module to deploy the contract. You can deploy this module to a locally simulated chain or to Sepolia.

To run the deployment to a local chain:

```shell
npx hardhat ignition deploy ignition/modules/Counter.ts
```

To run the deployment to Sepolia, you need an account with funds to send the transaction. The provided Hardhat configuration includes a Configuration Variable called `SEPOLIA_PRIVATE_KEY`, which you can use to set the private key of the account you want to use.

You can set the `SEPOLIA_PRIVATE_KEY` variable using the `hardhat-keystore` plugin or by setting it as an environment variable.

To set the `SEPOLIA_PRIVATE_KEY` config variable using `hardhat-keystore`:

```shell
npx hardhat keystore set SEPOLIA_PRIVATE_KEY
```

After setting the variable, you can run the deployment with the Sepolia network:

```shell
npx hardhat ignition deploy --network sepolia ignition/modules/Counter.ts
```
To run your app smoothly whenever you want, here are the essential commands in order for your workflow, assuming your setup is ready:

***

## 1. Start the local blockchain node (Hardhat)

Run this in a terminal and keep it running:

```bash
npx hardhat node
```

***

## 2. Deploy/redeploy smart contracts (if needed)

In another terminal, run:

```bash
truffle migrate --config ./truffle-config.cjs --network development
```

*Use this only when you want to deploy or redeploy contracts.*

***

## 3. Generate Tourist ID from Aadhaar number

Run your Node.js script, passing Aadhaar number and validity days, for example:

```bash
node scripts/generateIDFromAadhaar.cjs 123412341234 365
```

*Replace Aadhaar number and days as needed.*

***

## 4. Retrieve Tourist ID details

Create a script `scripts/getTouristDetails.cjs` (or similar) containing your retrieval code. Run:

```bash
node scripts/getTouristDetails.cjs
```

*(Make sure to set tourist and police addresses inside the script or pass as arguments.)*

***

### Optional: Streamlined npm scripts (in `package.json`)

Add this section to your `package.json` for easy commands:

```json
"scripts": {
  "start-node": "npx hardhat node",
  "migrate": "truffle migrate --config ./truffle-config.cjs --network development",
  "generate-id": "node scripts/generateIDFromAadhaar.cjs",
  "get-id": "node scripts/getTouristDetails.cjs"
}
```

Then you can run:

```bash
npm run start-node
```

```bash
npm run migrate
```

```bash
npm run generate-id -- 123412341234 365
```

```bash
npm run get-id
```

***

Let me know if help is needed to create the retrieval script or set up the npm scripts!
