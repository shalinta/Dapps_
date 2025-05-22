/*creating a simple banking contract in Solidity. The contract should allow
users to deposit and withdraw Ether However, only the owner of the contact should be able
to withdraw funds, Implement a modifier to enforce this restriction
Define a contract named SimpleBank.
implement a constructor that sets the contract deployer as the owner.
Create a deposit function that allows users to deposit Ether into the contract.
Create a withdraw function that allows only the owner to withdraw a specified amount of Ether.
Use a modifier to restrict the withdraw function to the owner only.*/

pragma solidity ^0.8.0;
contract simpleBank
{
    address public owner;
    event depositEvent (address indexed depositor, uint indexed amount);
    event withrawEvent (address indexed depositor, uint indexed amount);
    constructor()
    {
        owner=msg.sender;

    }
    modifier ownerOnly()
    {
        require(msg.sender==owner);
        _;
    }
    function deposit()external payable {

    } 
    function withdraw(uint amount) external ownerOnly{
        payable(owner).transfer(amount);
        emit withrawEvent (msg.sender,amount);
    }
}