pragma solidity ^0.4.15;

/**
 * The Elite 888 token contract is based of the ERC20 Standard. It is a basic limited/fixed
 * supply contract designed for exclusive buyers.  
 * 
 * Created By: Ricky Wilson
 */



/**
 * ERC 20 token
 *
 * https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20Interface  {

	/// @notice Function used to return total token supply of the contract
    /// @return total amount of tokens
    function totalSupply() constant returns (uint256 supply) {}

	/// @notice Function used to return token balance of a specified address/wallet
    /// @param  _owner The address from which the balance will be retrieved
    /// @return The balance
    function balanceOf(address _owner) constant returns (uint256 balance) {}

    /// @notice Transfer the balance from owner's account to another account
    /// @param  _to The address of the recipient
    /// @param  _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) returns (bool success) {}

    /// @notice Transfer the balance from owner's account to another account
    /// @param  _from The address of the sender
    /// @param  _to The address of the recipient
    /// @param  _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}

    /// @notice `msg.sender` approves `_addr` to spend `_value` tokens
    /// @param  _spender The address of the account able to transfer the tokens
    /// @param  _value The amount of wei to be approved for transfer
    /// @return Whether the approval was successful or not
    function approve(address _spender, uint256 _value) returns (bool success) {}

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}


/**
 * Implementation of a basic token following the ERC20 Standard
 */
contract Elite888Token is ERC20Interface {

    /* Public variables of the token */
    string public constant symbol = "8S";
    string public constant name = "Elite 888";
    uint8  public constant decimals = 18;  
    uint256 supply = 888000000000000000000;

	/* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowed;


    /* Initializes contract with initial supply tokens to the creator of the contract */
    function Elite888Token() {
        balanceOf[msg.sender] = supply;              // Give the creator all initial tokens
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
        return true;
    }
    
 
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}



 
