## Overview

`DemoToken` is a simple ERC20-like token smart contract written in Solidity.  
It demonstrates the core mechanics of a fungible token, including balance tracking, token transfers, and basic metadata such as name, symbol, and decimals.

This contract is intentionally minimal and designed for learning, demos, and early-stage experimentation rather than production use.

---

## Features

- Fixed token supply minted at deployment  
- Token balance tracking per address  
- Basic token transfers between addresses  
- Public token metadata (name, symbol, decimals)  
- Transfer event emission for off-chain tracking  

---

## Contract Details

- **Token Name:** DemoToken  
- **Symbol:** DTK  
- **Decimals:** 18  
- **License:** MIT  
- **Solidity Version:** ^0.8.0  

---

## How It Works

### Deployment

When the contract is deployed:

- The constructor accepts an `initialSupply` parameter.
- The total supply is calculated as:  
  `initialSupply * 10^decimals`
- The full token supply is assigned to the deployer’s address.
