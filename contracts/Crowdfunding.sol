// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrowdFund {
    address public owner;
    uint256 public goal;
    uint256 public totalFunds;

    mapping(address => uint256) public contributions;

    constructor(uint256 _goal) {
        owner = msg.sender;
        goal = _goal;
    }

    // Function 1: Contribute funds to the project
    function contribute() external payable {
        require(msg.value > 0, "Contribution must be greater than zero");
        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;
    }

    // Function 2: Check if funding goal is reached
    function isGoalReached() public view returns (bool) {
        return totalFunds >= goal;
    }

    // Function 3: Withdraw funds (only owner can do this after goal is reached)
    function withdrawFunds() external {
        require(msg.sender == owner, "Only owner can withdraw funds");
        require(isGoalReached(), "Funding goal not yet reached");

        payable(owner).transfer(address(this).balance);
    }
}

