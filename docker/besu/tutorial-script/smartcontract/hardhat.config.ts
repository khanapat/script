import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

import "./tasks/checkEther";
import "./tasks/setX";

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  paths: {
    artifacts: "./artifacts",
  },
  networks: {
    besu: {
      url: "http://127.0.0.1:8545",
      chainId: 1337,
      accounts: ["0x8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63"],
    }
  }
};

export default config;
