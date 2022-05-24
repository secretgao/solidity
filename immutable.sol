// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract immut {
    
    //定义未知常量
    address public immutable owner = msg.sender;
    //定义已知常量
    string public constant text = "abc";
    constructor(string memory _name){
      //  name = _name;
    }

    uint public  x;
    function foo() external{
        require(msg.sender == owner,"error");
        x = x+1;
    }
}
