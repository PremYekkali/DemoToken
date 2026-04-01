// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Basic token contract with minimal features
contract DemoToken {
    // Public variables
    string public constant name = "DemoToken";
    string public constant symbol = "DTK";
    uint8 public constant decimals = 18;
    uint256 public totalSupply;
    // Count of users who are currently holding the token.
    uint256 public holderCount;

    // Mapping to store balances
    mapping(address => uint256) private balances;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed burner, uint256 value);

    // Constructor to set the initial supply and assign it to the deployer
    constructor(uint256 initialSupply) {
        // initialSupply is expected in the smallest units (wei-style)
        totalSupply = initialSupply;
        balances[msg.sender] = initialSupply;
        holderCount++;
        emit Transfer(address(0), msg.sender, initialSupply);
    }

    // Getter function to check the balance of a user's address
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    // Transfer function to send tokens to another address
    function transfer(address recipient, uint256 amount) external returns (bool) {
        require(recipient != address(0), "Zero address");
        require(amount > 0, "Zero amount");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // If the recipient had 0 tokens before the transfer, they are gonna have some tokens and will become a token holder, hence incrementing the counter
        if(!isTokenHolder(recipient)) {
            holderCount++;
        }

        unchecked {
            balances[msg.sender] -= amount;
            balances[recipient] += amount;
        }

        // If msg.sender runs out of tokens, they are no longer a token holder, hence decrementing the counter
        if(!isTokenHolder(msg.sender)) {
            holderCount--;
        }

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Burn: function to permanently destroy tokens
    function burn(uint256 amount) external returns (bool) {
        require(amount > 0, "Zero amount");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        unchecked {
            balances[msg.sender] -= amount;
            totalSupply -= amount;
        }

        // If the burner runs out of tokens, they are no longer a token holder, hence decrementing the counter
        if(!isTokenHolder(msg.sender)) {
            holderCount--;
        }

        emit Burn(msg.sender, amount);
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }

    // Getter function to check if a user's address provided is a token holder or not
    function isTokenHolder(address account) external view returns (bool) {
        return balances[account] != 0;
    }
}
