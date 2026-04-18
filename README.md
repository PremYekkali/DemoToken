# Demo Token

![Solidity](https://img.shields.io/badge/solidity-^0.8.0-363636?style=flat&logo=solidity)
![License](https://img.shields.io/badge/license-MIT-blue)
---

## Overview

`DemoToken` is a minimal fungible token smart contract written in Solidity.
It mimics some basic token behavior but does not fully implement the ERC20 standard.
It demonstrates the core mechanics of a fungible token, including balance tracking, token transfers, and basic metadata such as name, symbol, and decimals.

This contract is intentionally minimal and designed for demos and early-stage experimentation, not production use.

---

## Features

- Fixed token supply minted at deployment  
- Token balance tracking per user address  
- Basic token transfers between addresses  
- Public token metadata (name, symbol, decimals)  
- Transfer event emission for off-chain tracking
- Automatic tracking of active token holders (addresses with non-zero balance)
- Token burning to destroy tokens and reduce supply permanently

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
- `initialSupply` must be provided in the smallest unit (wei-style).
- `totalSupply` is set directly to `initialSupply`.
- The full token supply is assigned to the deployer’s address.

```solidity
constructor(uint256 initialSupply)
```
## Balance Tracking

Balances are stored internally using a mapping against each user address:

```solidity
mapping(address => uint256) private balances;
```

You can query the balance of any user address using:
```solidity
function balanceOf(address account) external view returns (uint256)
```
## Token Transfers

Tokens can be transferred from the caller to another address using:

```solidity
function transfer(address recipient, uint256 amount) external returns (bool)
````

### Transfer Rules

* The sender must have a sufficient token balance
* The recipient address must not be the zero address
* Balances are updated atomically
* A `Transfer` event is emitted upon success

---

## Token Holder Check

You can check whether a user's address currently holds any tokens by using:

```solidity
function isTokenHolder(address account) external view returns (bool)
```

This function returns `true` if the address has a balance greater than zero.

---

## Token Burning

Users can permanently destroy their tokens using the burn function in the contract. Burning reduces both the user's balance and the total token supply.

```solidity
function burn(uint256 amount) external returns (bool)
```

### Burn Rules

* The caller must have sufficient balance to burn
* The amount must be greater than zero
* Burned tokens are permanently removed from circulation
* Total supply decreases by the burned amount
* If a user burns all their tokens, the holder count decreases

---

## Token Holder Count

The contract maintains a public `holderCount` variable that tracks the number of addresses currently holding a non-zero token balance.

```solidity
uint256 public holderCount;
```

---

## Transfer With Memo

Users can transfer tokens along with an optional message:

```solidity
function transferWithMemo(address recipient, uint256 amount, string calldata memo) external returns (bool)
````

This function performs a standard token transfer and emits an additional event containing the provided memo.

### Use Cases

- Attaching notes to transactions (e.g., payment references)
- Off-chain indexing and analytics
- Improved transaction context for wallets and explorers

---

## Events

### Transfer

Emitted whenever tokens are successfully transferred:

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

This event allows wallets, block explorers, and indexers to track token movements.

### Burn

Emitted whenever tokens are burned:

```solidity
event Burn(address indexed burner, uint256 value);
```

This event logs the permanent destruction of tokens used to track deflationary mechanics.

### TransferWithMemo

Emitted when a transfer includes an additional memo message:

```solidity
event TransferWithMemo(address indexed from, address indexed to, uint256 value, string memo);
````

This event allows attaching contextual information to token transfers for off-chain use cases.

---

## Limitations

This contract is **not fully ERC20-compliant** and intentionally omits:

* Does not implement the ERC20 interface
* No `approve` / `allowance` features
* No functions like `transferFrom` feature
* No Minting after deployment
* No Ownership or role-based access control (could be added later)
* No Pausing or upgrade mechanisms

Do **not** use this smart contract in a production environment without a proper review & security audit.

---

## License

This project is licensed under the MIT License.
