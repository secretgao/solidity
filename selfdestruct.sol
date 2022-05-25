// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

/*
selfdestruct 
1.delete contract
2.force send eth to any address;
*/

contract Kill{

    constructor() payable{

    }
    function kill() external{
        selfdestruct(payable(msg.sender));
    }

    function test() external pure returns(uint){
        return 123;
    }
}
//助手合约
contract Helper{
    function getBlance() external view returns(uint){
        return address(this).balance;
    }
    function helper_kill(Kill _kill) external {
        _kill.kill();
    }
}
/*
selfdestruct 有两种功能
一 合约自毁
二 把合约余额 强制发送给调用者

一 合约自毁
1 首先部署合约 调用test 方法 返回123；说明合约部署成功
2 调用kill之后在调用test 返回0 说明合约已经自毁

二 强制发送余额
1 部署 kill 合约时给1个ether
2 部署 hepler 合约
3 看下 hepler 合约的余额 是0 
4 hepler 合约 helper_kill方法中输入拷贝的kill合约地址
5 看下 hepler 合约的余额 就不是0了
*/
