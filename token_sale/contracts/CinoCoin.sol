pragma solidity ^0.4.23;

contract CinoCoin {
  // Constructor
  // Set the total number of tokens
  // Read the total number of tokens
  uint256 public totalSupply;

  function CinoCoin () public {
    totalSupply = 1000000;
  }
}
