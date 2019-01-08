var CinoCoin = artifacts.require("./CinoCoin.sol");
var CinoCoinSale = artifacts.require("./CinoCoinSale.sol");

module.exports = function(deployer) {
  deployer.deploy(CinoCoin, 1000000).then(function() {
    var tokenPrice = 1000000000000000;
    return deployer.deploy(CinoCoinSale, CinoCoin.address, tokenPrice);
  });
};
