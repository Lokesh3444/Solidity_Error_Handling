# SimplePointsSystem Contract

The `SimplePointsSystem` contract is a simplified staking and points calculation system. Users can stake a certain amount of tokens to earn points over time based on a reward rate. The contract also prevents direct Ether transfers to ensure the contract only handles staking and points.

## Contract Description

### Contract Variables

- `rewardRate`: The rate at which points are awarded per staked unit per second.
- `totalStaked`: The total amount of tokens currently staked in the contract.

### Structs

- `Stake`: Stores information about each user's stake, including the amount staked, the start time, and the accumulated points.

### Mappings

- `stakes`: Maps an address to its corresponding `Stake` struct.

### Constructor

- `constructor(uint256 _rewardRate)`: Initializes the contract with the specified reward rate.

### Functions

- `stake(uint256 _amount) external`: Allows users to stake a specified amount of tokens. The function requires the amount to be greater than zero and updates the user's stake information and total staked amount.
  - Uses `require` to check that the amount is greater than zero.
  - Uses `assert` to ensure the total staked amount is correctly updated.

- `withdraw(uint256 _amount) external`: Allows users to withdraw a specified amount of their staked tokens. The function requires the amount to be less than or equal to the user's staked amount and updates the user's stake information and total staked amount.
  - Uses `require` to check that the user has enough staked tokens to withdraw.
  - Uses `assert` to ensure the total staked amount is correctly updated.

- `updatePoints(address _user) internal`: Updates the points for a user based on the staked duration and reward rate. The function is called internally when staking or withdrawing.

- `receive() external payable`: Reverts any direct Ether transfers to the contract.
  - Uses `revert` to reject direct payments with the message "Direct payments not allowed".

- `fallback() external payable`: Reverts any direct Ether transfers to the contract with data.
  - Uses `revert` to reject direct payments with the message "Direct payments not allowed".

## Getting Started

### Prerequisites

- [Remix](https://remix.ethereum.org) or a local development environment with Truffle or Hardhat.

### Deploying the Contract

1. **Using Remix:**
   - Open [Remix](https://remix.ethereum.org).
   - Create a new file and paste the contract code.
   - Compile the contract.
   - Deploy the contract, specifying the `_rewardRate` in the deployment parameters.


### Interacting with the Contract

1. **Staking Tokens:**
   - Call the `stake` function with the amount to be staked.
   - Example using Remix: Enter the amount and click on the `stake` function button.

2. **Withdrawing Tokens:**
   - Call the `withdraw` function with the amount to be withdrawn.
   - Example using Remix: Enter the amount and click on the `withdraw` function button.


### Handling Ether Transfers

- Any direct Ether transfer to the contract will be rejected, ensuring the contract only deals with staking and points.

## Author 
- LokeshReddy
