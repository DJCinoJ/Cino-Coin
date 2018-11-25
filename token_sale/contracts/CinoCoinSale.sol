pragma solidity ^0.4.23;

import "./CinoCoin.sol";

contract CinoCoinSale {
  address admin;
  CinoCoin public tokenContract;
  uint256 public tokenPrice;
  uint256 public tokensSold;

  event Sell(address _buyer, uint256 _amount);

  function CinoCoinSale(CinoCoin _tokenContract, uint256 _tokenPrice) public {
    //Assign an admin / an external account connected to the blockchain that has certain priviliges
    admin = msg.sender;
    //Assign token contract
    tokenContract = _tokenContract;
    //Token Price how much the token will cost
    tokenPrice = _tokenPrice;
  }

  //multiply function for
  function multiply(uint x, uint y) internal pure returns (uint z) {
    require(y == 0 || (z = x * y) / y == x);
  }

  //Buy tokens
  function buyTokens(uint256 _numberOfTokens) public payable {
    //Require that the value is equal to tokens
    require(msg.value == multiply(_numberOfTokens, tokenPrice));
    //Require that there are enough tokens in the contrat
    require(tokenContract.balanceOf(this) >= _numberOfTokens);
    //Require the transfer is successful
    require(tokenContract.transfer(msg.sender, _numberOfTokens));
    //Keep track of number of tokens sold
    tokensSold += _numberOfTokens;
    //Trigger a sell event
    Sell(msg.sender, _numberOfTokens);
  }

  //ending token CinoCoinSale
  function endSale()public {
    //Only an admin can end the end the sale
    require(msg.sender == admin);
    //Transfer the amount of token in the sale back to the admin
    require(tokenContract.transfer(admin, tokenContract.balanceOf(this)));
    //Destroy contract
    admin.transfer(address(this).balance);
  }
}
