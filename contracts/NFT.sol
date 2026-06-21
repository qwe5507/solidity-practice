// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721 {
    constructor() ERC721("My NFT", "MY NFT") {
        _mint(msg.sender, 1);
    }
}