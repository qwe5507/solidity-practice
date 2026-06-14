// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner!");
        _;
    }
}

contract Counter is Ownable {
    uint private value = 0;

    function getValue() public view returns (uint) {
        return value;
        // view, pure, constant, payable
    }

    function increment() public payable costs(1) {
        //require(msg.value == 1 ether, "1 Ether");
        value = value + 1;
    }

    event Reset(address owner, uint currentValue);

    modifier costs(uint amount) {
        require(msg.value >= amount * 1 ether);
        _;
    }

    function reset() public onlyOwner {
        emit Reset(msg.sender, value);
        value = 0;
    }

    function withdraw() public onlyOwner {

        payable(owner).transfer(address(this).balance);
    }
}