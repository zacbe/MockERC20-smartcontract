import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY || "your-alchemy-api-key";
const PRIVATE_KEY = process.env.PRIVATE_KEY || "your-wallet-private-key";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
      },
    },
  },
  networks: {
    arbitrumSepolia: {
      url: `https://arb-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [`0x${PRIVATE_KEY}`],
    },
    optimismSepolia: {
      url: `https://optimism-sepolia.infura.io/v3/${ALCHEMY_API_KEY}`,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
};

export default config;