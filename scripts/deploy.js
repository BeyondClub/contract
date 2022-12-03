const {ethers} = require("hardhat")
async function main() {

  const contract = await ethers.getContractFactory("beyondClub");
  const deployedContract = await contract.deploy();
  await deployedContract.deployed();
  console.log(`the deployed contract address is: ${deployedContract.address}`);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })