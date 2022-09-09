import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { task } from "hardhat/config";

task("checkEther", "Check ether balance")
    .addParam("address", "wallet address")
    .setAction(async (taskArgs, hre) => {
        const balance = await hre.ethers.provider.getBalance(taskArgs.address);
        console.log("Balance:", hre.ethers.utils.formatEther(balance))
    });

export default {};