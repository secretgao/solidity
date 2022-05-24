// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract CallTest{
    //两种方法在一个合约中调另外一个合约
    //1 合约地址当参数传入
    function setX(address _test,uint _x) external{
        TestContract(_test).setX(_x);
    }
    //2 合约当参数传入
    function setX1(TestContract _test,uint _x) external{
        _test.setX(_x);
    }

    function setXandReceiveEther(address _test,uint _x) external payable{
        TestContract(_test).setXandReceiveEther{value:msg.value}(_x);
    }


     function getXandValue(address _test) external view returns(uint,uint){
        (uint x,uint y) = TestContract(_test).getXandValue();   
        return (x,y);
     }
}

contract TestContract{

    uint public x;
    uint public value = 123;


    function setX(uint _x) external{
        x = _x;
    }
    function getX() external view returns(uint){
        return x;
    }

    function setXandReceiveEther(uint _x ) external payable{
        x = _x;
        value = msg.value;
    }
    function getXandValue() external view returns (uint,uint){
        return (x,value);
    }
}
