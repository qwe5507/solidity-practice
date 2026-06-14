// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract MyFirstToken {
    // name, symbol, decimals
    string public name = "Jinhyeon Wrapped Ether";
    string public symbol = "jhWETH";
    uint public decimals = 18;
    uint public totalSupply = 0; // mint 할 때마다 증가

    mapping(address owner => uint amount) public balances;
    // mapping(uint year => mapping(address owner => uint amount)) public balances;
    
    // 누가, 누구에게, 얼마만큼 권한을 주었는가? 
    mapping(address owner=> mapping(address spender => uint)) public allowances;

    event Transfer(address indexed from, address indexed to, uint amount);

    // transfer, balanceOf
    function balanceOf(address owner) public view returns(uint amount) {
        return balances[owner];
    }

    // 실행 주체: owner(from)
    function transfer(
        address to, 
        uint amount
    ) public returns (bool success) {
        // 1. 예외: 내가 가진 잔고보다, 많은 금액을 출금하려고 하면 에러!
        address owner = msg.sender;
        require(balances[owner] >= amount);

        // 2. 잔고/데이터를 업데이트
        balances[owner] -= amount;
        balances[to] += amount;     

        emit Transfer(owner, to, amount);

        return true;
    }

    // 실행 주체: spender(Uniswap Pair/Exchange)
    function transferFrom(
        address owner,
        address to,
        uint amount
    ) public returns (bool success) {
        address spender = msg.sender;
        // 1. Error
        //  (1) 잔액이 충분한가? owner's balance >= amount
        require(balances[owner] >= amount);
        //  (2) 권한이 있는가? spender's allowance >= amount
        require(allowances[owner][spender] >= amount);

        // 2. Data Update
        balances[owner] -= amount;
        balances[to] += amount;
        allowances[owner][spender] -= amount;

        // 3. Event
        emit Transfer(owner, to, amount);
        // 4. return true;
        return true;
    }

    event Approval(address indexed owner, address indexed spender, uint amount);

    // approve
    // 실행 주체: owner
    function approve(address spender, uint amount) public returns (bool success) {
        address owner = msg.sender;
        allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
        return true;
    }
    // allowance
    function allowance(
        address owner,
        address spender
    ) public view returns(uint amount) {
        return allowances[owner][spender];
    }
    // totalSupply(*)

    // ethToToken()
    function deposit() {
        
    }
}