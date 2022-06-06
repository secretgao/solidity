// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


contract FunctionSelector{
    function getSelector(string calldata _func) external pure returns(bytes4){
        return bytes4(keccak256(bytes(_func)));
    }
}

contract Reciver{

    event Log(bytes data);
    function transfer(address _to,uint _amount) external{

        emit Log(msg.data);
    }
    //0xa9059cbb
    //0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc
    //_amount  输入11 下面是一个16进制
    //4000000000000000000000000000000000000000000000000000000000000000b
}
//部署第一个合约Reciver 执行transfer 得到 合约注释里的字符串
//部署第二哥合约FunctionSelector 执行getSelector 
/*
方法参数"transfer(address.uint256)"
得到 0:
bytes4: 0xa9059cbb 
*/
