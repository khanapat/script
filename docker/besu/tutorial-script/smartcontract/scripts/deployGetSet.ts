import { ethers, network } from "hardhat";
import { GetSet, GetSet__factory, Lock, Lock__factory } from "../typechain-types";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

async function main() {
    const [owner] = await ethers.getSigners();

    console.log("Deployer:", owner.address);
    console.log("Balance:", (await ethers.provider.getBalance(owner.address)).toString());

    const GetSet: GetSet__factory = await ethers.getContractFactory("GetSet");
    const getSet: GetSet = await GetSet.deploy();

    await getSet.deployed();

    console.log(`deployed to ${getSet.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
