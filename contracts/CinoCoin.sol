pragma solidity ^0.4.23;

contract CinoCoin {
  //Name of the token
  string public name = "CinoCoin";
  //Symbol of the token
  string public symbol = "CC";
  //Version of the token
  string public standard = "CinoCoin v1.0";
  uint256 public totalSupply;

  // Transfer Event
  event Transfer(
    address indexed _from,
    address indexed _to,
    uint256 _value
  );

  // Approve event
  event Approval(
    address indexed _owner,
    address indexed _spender,
    uint256 _value
    );

  mapping(address => uint256) public balanceOf;
  // allowence / how much the spender is allowed to draw from the owner
  mapping(address => mapping(address => uint256)) public allowance;

  function CinoCoin (uint256 _initalSupply) public {
    balanceOf[msg.sender] = _initalSupply;
    totalSupply = _initalSupply;
  }

  //Transfer function add the ability to pay with tokens move them from one place to another
  function transfer(address _to, uint256 _value) public returns (bool success) {
    //Exception if the account does not have enough tokens
    require(balanceOf[msg.sender] >= _value);
    //Transfer the balance
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    //Transfer Event
    Transfer(msg.sender, _to, _value);
    //Return a boolean
    return true;
  }

  // Delegated transfer / approve function / this is how we keep track of who is approving this
  function approve(address _spender, uint256 _value) public returns (bool success) {
    //allowance / how much the other account is allowed to spend
    allowance[msg.sender][_spender] = _value;
    //approve event
    Approval(msg.sender, _spender, _value);

    return true;
  }

  //transfer from
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    //Require from account has enough tokens
    require(_value <= balanceOf[_from]);
    //Require allowance is big enough
    require(_value <= allowance[_from][msg.sender]);
    //Change the balance
    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;
    //Update the allowance
    allowance[_from][msg.sender] -= _value;
    //call a transfer Event
    Transfer(_from, _to, _value);
    return true;
  }
}
