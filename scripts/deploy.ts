import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const defaultAdmin = deployer.address;
  const minter = "0xYourBridgeOperatorAddress"; // Replace with actual minter address

  const ContractFactory = await ethers.getContractFactory("MockERC20");

  // Deploy to Arbitrum Sepolia
  console.log("Deploying to Arbitrum Sepolia...");
  const instanceArbitrum = await ContractFactory.deploy(defaultAdmin, minter);
  await instanceArbitrum.deployed();
  console.log(`MockERC20 deployed to Arbitrum Sepolia at: ${instanceArbitrum.address}`);

  // Deploy to Optimism Sepolia
  console.log("Deploying to Optimism Sepolia...");
  const instanceOptimism = await ContractFactory.deploy(defaultAdmin, minter);
  await instanceOptimism.deployed();
  console.log(`MockERC20 deployed to Optimism Sepolia at: ${instanceOptimism.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
