 //Features
	//•	Users can deposit Ether
	//•	Users can withdraw Ether
	//•	Users can check balances
	//•	Admin (bank owner) can check total bank balance
	//•	Uses events for tracking transactions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankingSystem {
    address public admin;

    mapping(address => uint) private balances;

    event Deposited(address indexed user, uint amount, uint totalBalance);
    event Withdrawn(address indexed user, uint amount, uint totalBalance);

    constructor() {
        admin = msg.sender;
    }

    // Deposit Ether into user's bank balance
    function deposit() external payable {
        require(msg.value > 0, "Amount must be greater than 0");

        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value, balances[msg.sender]);
    }

    // Withdraw Ether from user's bank balance
    function withdraw(uint amount) external {
        require(amount <= balances[msg.sender], "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount, balances[msg.sender]);
    }

    // View user's current balance
    function checkBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    // Admin-only: Check total bank balance
    function getBankTotalBalance() public view returns (uint) {
        require(msg.sender == admin, "Only admin can check total bank balance");
        return address(this).balance;
    }
}