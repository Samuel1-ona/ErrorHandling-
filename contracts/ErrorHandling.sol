// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ErrorHandlingExample {
    address public owner;
    uint public balance;

    constructor() {
        owner = msg.sender; // Set the contract creator as the owner.
        balance = 0;
    }

    // Modifier to restrict function execution to the contract's owner.
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner.");
        _;
    }

    // Function to deposit funds into the contract.
    function deposit(uint _amount) public {
        // Validate the deposit amount is greater than zero.
        require(_amount > 0, "Deposit amount must be greater than zero.");
        balance += _amount;
    }

    // Function to withdraw funds from the contract.
    // Demonstrates use of assert to validate contract's state.
    function withdraw(uint _amount) public onlyOwner {
        require(_amount <= balance, "Insufficient balance.");
        balance -= _amount;
        
        // This assert is used as a sanity check to ensure balance does not underflow.
        assert(balance >= 0);
    }

    // Function to reset contract state by the owner.
    // Demonstrates use of revert for custom logic.
    function resetContract() public view onlyOwner {
        if (balance != 0) {
            revert("Cannot reset contract with non-zero balance.");
        }

        // Reset contract state logic here.
        // This is just an example, in practice you might want to reset other state variables.
    }
}
