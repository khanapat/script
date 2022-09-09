import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { task } from "hardhat/config";

let owner: SignerWithAddress;

task("setX", "Set X value")
    .addParam("x", "x value")
    .setAction(async (taskArgs, hre) => {
        const getSet = await hre.ethers.getContractAt("GetSet", "0x42699A7612A82f1d9C36148af9C77354759b210b");

        [owner] = await hre.ethers.getSigners();
        console.log("Signer:", owner.address);

        console.log("X:", await getSet.x());

        const tx = await getSet.connect(owner).set(taskArgs.x);
        const receipt = await tx.wait(1);

        console.log("X:", await getSet.x(), "hash:", receipt.transactionHash);
    });

export default {};