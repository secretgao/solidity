pragma solidity  ^0.4.0;

contract BooleanTest{

    bool _a;
    int num1 = 100;
    int num2 = 200;
    function getBoolean() public returns(bool){
        return _a;
    }
    function getBoolean1() public returns(bool){
        return !_a;
    }

    function panduan() public returns(bool){
        return num1 == num2
    }
}
