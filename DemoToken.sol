// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Basic token contract with minimal features
contract DemoToken {
    // Public variables
    string public constant name = "DemoToken";
    string public constant symbol = "DTK";
    uint8 public constant decimals = 18;
    uint256 public totalSupply;

    // Mapping to store balances
    mapping(address => uint256) private balances;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Constructor to set the initial supply and assign it to the deployer
    constructor(uint256 initialSupply) {
        // initialSupply is expected in the smallest units (wei-style)
        totalSupply = initialSupply;
        balances[msg.sender] = initialSupply;
        emit Transfer(address(0), msg.sender, initialSupply);
    }

    // Getter function to check the balance of an address
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    // Transfer function to send tokens to another address
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(recipient != address(0), "Invalid recipient address");

        balances[msg.sender] -= amount;
        balances[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Getter function to check if an address is a token holder or not
    function isTokenHolder(address account) external view returns (bool) {
        return balances[account] > 0;
    }
}
