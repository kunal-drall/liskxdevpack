const { ethers } = require("hardhat");

async function main() {
  console.log("Deploying UserProfileManager contract...");

  const UserProfileManager = await ethers.getContractFactory("UserProfileManager");
  const userProfileManager = await UserProfileManager.deploy();

  await userProfileManager.waitForDeployment();

  const contractAddress = await userProfileManager.getAddress();
  console.log("UserProfileManager deployed to:", contractAddress);
  
  // Wait for a few confirmations
  console.log("Waiting for confirmations...");
  await userProfileManager.deploymentTransaction().wait(5);
  
  console.log("Contract deployed successfully!");
  console.log("Contract address:", contractAddress);
  console.log("View on Base Sepolia:");
  console.log(`https://sepolia.basescan.org/address/${contractAddress}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });