const hre = require("hardhat");

async function main() {
  const DarkPool = await hre.ethers.getContractFactory("DarkPool");
  const dp = await DarkPool.deploy();

  await dp.waitForDeployment();
  console.log("ZK Dark Pool deployed to:", await dp.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
