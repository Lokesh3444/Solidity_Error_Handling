// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimplePointsSystem {
    uint256 public rewardRate; 
    uint256 public totalStaked;

    struct Stake {
        uint256 amount;
        uint256 startTime;
        uint256 points;
    }

    mapping(address => Stake) public stakes;

    constructor(uint256 _rewardRate) {
        rewardRate = _rewardRate;
    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than 0");

        Stake storage userStake = stakes[msg.sender];
        updatePoints(msg.sender);

        userStake.amount += _amount;
        userStake.startTime = block.timestamp;

        uint256 previousTotalStaked = totalStaked;
        totalStaked += _amount;
        
        assert(totalStaked == previousTotalStaked + _amount);
    }

    function withdraw(uint256 _amount) external {
        Stake storage userStake = stakes[msg.sender];
        require(userStake.amount >= _amount, "Insufficient staked amount");

        updatePoints(msg.sender);

        userStake.amount -= _amount;
        
        uint256 previousTotalStaked = totalStaked;
        totalStaked -= _amount;

        assert(totalStaked == previousTotalStaked - _amount);
    }

    

    function updatePoints(address _user) internal {
        Stake storage userStake = stakes[_user];
        uint256 stakedDuration = block.timestamp - userStake.startTime;
        uint256 newPoints = userStake.amount * stakedDuration * rewardRate;
        newPoints/=10;

        userStake.points += newPoints;
        userStake.startTime = block.timestamp;
    }

    receive() external payable {
        revert("Direct payments not allowed");
    }

    fallback() external payable {
        revert("Direct payments not allowed");
    }
}
