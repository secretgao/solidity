// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract EthWallet{

    address payable public owner;
    //构造函数 将部署者的身份 传到owner 中 实现管理员
    constructor(){
        owner = payable(msg.sender);
    }   
    receive() external payable{

    } 

    function withdarw(uint _amout) external{
        require(msg.sender == owner,"call is not owner");
        //owner 是从状态变量中获取的 会消耗一些gas
        //使用msg.sender  会节约一些gas
    //   owner.transfer(_amout);
        payable (msg.sender).transfer(_amout);
        // 用call 发送 eth 不用声明payable 属性
        /*
        (bool sent,)= msg.sender.call{value:_amout}("");
        require(sent,"fail to send eth");
        */
    }

    function getBlance() external view returns(uint ){
        return address(this).balance;
    }
}
