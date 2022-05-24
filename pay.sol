// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Pay{

    address payable public owner; // 声明
    //payable 标记的方法可以支持以太坊主币的支付
    //没有被payable 标记的方法 不支持以太坊主币的支付，会报错
    function deposit() external payable{

    }

    function getBlance() external view returns(uint){
        return address(this).balance;
    }
}
