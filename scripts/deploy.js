// We require the Hardhat runtime environment explicitly here.
// This is optional but useful for running the script in a standalone fashion
// When running the script  with `npx hardhat run <script>`, you'll find the Hardhat Runtime Environment's sources are automatically included as well.

const hre = require('hardhat');

async function main() {
  // Hardhat always runs the compile task when running scripts with its command line interface (`npx hardhat run <script>`).

  // we get the contract to deploy
  const [owner] = await hre.ethers.getSigners(); // get the contract owner from the ethers object
  const BankContractFactory = await hre.ethers.getContractFactory('Bank'); // get the contract and contract name then compiled resulting in files in the artifacts folder
  const BankContract = await BankContractFactory.deploy(); // deploy the contract on the local Hardhat network for debugging purposes
  await BankContract.deployed(); // deploy to the actual blockchain of our choice

  console.log(`Bank contract deployed to ${BankContract.address}`);
  console.log(`Owner address: ${owner.address}`);
}
// We export the main function, so that hardhat can find and run it. Able to use async/await everywhere and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
