pragma solidity ^0.8.7;

contract FunctionInrto{

    //external 外部函数 只能在外部读取
    //pure 纯函数  不能够写状态变量，只能够写局部变量 不对链上有任何读写操作
   
    function sub(uint x,uint y)external pure returns (uint){
        return x-y;
    }

    //变量的类型分为3种：状态变量，局部变量，全局变量

    uint public i;
    bool public b;
    address public myAddress;
    function foo() external{
    
        i = 123;
        b = true;
        myAddress = address(1);
    }

    //全局变量
    function globalVars() external view returns(address,uint,uint){

        address sender = msg.sender;
        uint timestamp = block.timestamp;
        uint blockNum = block.number;
        return (sender,timestamp,blockNum);
    }
    uint public num;
    function viewFunc() external view returns(uint){
        return num;
    }

    function pureFunc() external pure returns(uint){
        return 1;
    }

    function addToNum(uint x) external view returns(uint){
        return num + x;
    }

    function add(uint x,uint y) external pure returns(uint){
        return x+y;
    }
}
