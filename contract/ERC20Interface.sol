pragma solidity ^0.4.15;

/**
 * ERC 20 token
 *
 * https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20Interface  {

    /// @notice Function used to return total token supply of the contract
    /// @return total amount of tokens
    function totalSupply() constant returns (uint256 supply);

    /// @notice Function used to return token balance of a specified address/wallet
    /// @param  _owner The address from which the balance will be retrieved
    /// @return The balance
    function balanceOf(address _owner) constant returns (uint256 balance);

    /// @notice Transfer the balance from owner's account to another account
    /// @param  _to The address of the recipient
    /// @param  _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) returns (bool success);

    /// @notice Transfer the balance from owner's account to another account
    /// @param  _from The address of the sender
    /// @param  _to The address of the recipient
    /// @param  _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);

    /// @notice `msg.sender` approves `_addr` to spend `_value` tokens
    /// @param  _spender The address of the account able to transfer the tokens
    /// @param  _value The amount of wei to be approved for transfer
    /// @return Whether the approval was successful or not
    function approve(address _spender, uint256 _value) returns (bool success);

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) constant returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

