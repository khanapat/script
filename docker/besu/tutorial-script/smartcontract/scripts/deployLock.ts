import { ethers, network } from "hardhat";
import { Lock, Lock__factory } from "../typechain-types";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

let owner: SignerWithAddress;

async function main() {
  const [owner] = await ethers.getSigners();

  console.log("Deployer:", owner.address);
  console.log("Balance:", (await ethers.provider.getBalance(owner.address)).toString());

  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  const lockedAmount = ethers.utils.parseEther("1");

  const Lock: Lock__factory = await ethers.getContractFactory("Lock");
  const lock: Lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  await lock.deployed();

  console.log(`Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
