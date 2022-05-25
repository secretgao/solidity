// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

/*
 类似于真实的存钱罐 
 存入钱。（谁都可以存）
 取出钱 （必须摔罐 不能再次使用了） 只能管理员取钱
 合约就会自动销毁
*/
contract pigBank{
    address public owner = msg.sender;

    //事件
    event Deposit(uint amout);
    event withdraw1(uint amout);
    receive() external payable{
        emit Deposit(msg.value);
    }

    function withdraw() external{
        require(owner == msg.sender,"not owner");

        //address(this).balance 获取当前合约主币的余额
        emit withdraw1(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}
/*
验证流程
1 部署合约后使用 ACCOUNT 第二个账户 存入1eth 点击 Low level interactions 的transact
2 点击withdraw 方法 会调用失败 （当前账号第二个 并非部署合约账户）
3 切换 部署合约账号 点击withdraw 取到 第二个账户存到的1eth 
4 点击owner 返回0x0000000000000000000000000000000000000000 证明该合约已经销毁
*/
