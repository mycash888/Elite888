pragma solidity ^0.4.15;

import "./ERC20Interface.sol";

/**
 * Elite 888 is a fixed supply token contract based on the ERC20 Standard.
 * 
 */
contract Elite888Token is ERC20Interface {

    /* Owner of this contract */
    address public owner;

    /* Public variables of the token */
    string public constant symbol = "8S";
    string public constant name = "Elite 888";
    uint256 public constant decimals = 18;  
    uint256 public constant supply = 888 * 10**decimals;

	  /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowed;

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function Elite888Token() {
        owner = msg.sender;
        balanceOf[owner] = supply;              // Give the creator all initial tokens
    }
    
    function totalSupply() constant returns (uint256 requestedSupply) {
        return supply;
    }
 
    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balanceOf[_owner];
    }
 
    function transfer(address _to, uint256 _value) returns (bool success) {
        if (balanceOf[msg.sender] < _value) return false;           // Check if the sender has enough	
        if (balanceOf[_to] + _value < balanceOf[_to]) return false; // Check for overflows		
        balanceOf[msg.sender] -= _value;                            // Subtract from the sender
        balanceOf[_to] += _value;                                   // Add the same to the recipient
        Transfer(msg.sender, _to, _value);                          // Notify anyone listening that this transfer took place
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (balanceOf[_from] < _value) return false;                // Check if the sender has enough    
        if (balanceOf[_to] + _value < balanceOf[_to]) return false; // Check for overflows               
        if (_value > allowed[_from][msg.sender]) return false;      // Check allowance                   
        balanceOf[_from] -= _value;                                 // Subtract from the sender
        balanceOf[_to] += _value;                                   // Add the same to the recipient
        allowed[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }
 
    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}

 
