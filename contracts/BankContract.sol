// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Bank {
    // declare state variables at contract level
    address public bankOwner;
    string public bankName;
    mapping(address => uint256) public customerBalance;

    // will only run once, when the contract is deployed
    constructor() {
        // we're setting the bank owner to the Ethereum address that deploys the contract
        // msg.sender is a global variable that stores the address of the account that initiates a transaction
        bankOwner = msg.sender; // create mapping
    }

    // functions
    // public allows the function to be called internally or externally
    // private can be accessed only from within this contract
    // internal only this contract and contracts deriving from it can access
    // external cannot be accessed internally, only externally (saves gas)
    // payable is a modifier to receive money in our contract

    function depositMoney() public payable {
        require(msg.value != 0, "You need to deposit some amount of money!"); // require is like a `try / catch` in javascript
        customerBalance[msg.sender] += msg.value; // sender is the address that initiated the transaction & value is the amount of Ether in wei being sent
    }

    function setBankName(string memory _name) external {
        require(
            msg.sender == bankOwner,
            "You must be the owner to set the bank name."
        );
        // parameters start with underscore & temporarily stored in memory
        bankName = _name; // a getter for the variable is already created when we initialize the varaible and made it public
    }

    function withdrawMoney(address payable _to, uint256 _total) public payable {
        require(
            _total <= customerBalance[msg.sender],
            "You have insufficient funds to withdraw."
        );
        customerBalance[msg.sender] -= _total;
        _to.transfer(_total);
    }

    // create another getter to get the balance of the wallet calling our contract
    function getCustomerBalance() public view returns (uint256) {
        return customerBalance[msg.sender];
    }

    // create another getter to get the balance of the entire bank
    function getBankBalance() public view returns (uint256) {
        // we want only the bank owner to see all balances
        require(
            msg.sender == bankOwner,
            "You must be the owner to see all balances."
        );
        return address(this).balance;
    }
}
