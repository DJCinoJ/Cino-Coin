var CinoCoin = artifacts.require("./CinoCoin.sol");

module.exports = function(deployer) {
  deployer.deploy(CinoCoin);
};
