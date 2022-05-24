// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract X {
    function foo() public pure virtual returns (string memory){
        return "X_foo()";
    }
    function bar() public pure virtual returns (string memory){
        return "X_bar()";
    }
    function x() public pure returns (string memory){
        return "X_x();";
    }
}
contract Y is X { 

    function foo() public pure virtual override returns(string memory){
        return "Y_foo()";
    }

    function bar() public pure virtual override returns(string memory){
        return "Y_bar()";
    }

    function y() public pure returns(string memory){
        return "Y";
    }

}

//Z 合约继承了 X合约 和Y 合约
//这里 X Y 合约的顺序 一定是按照最基础的在前也就是X在前  如果写了 YX 就会报错
contract Z is X,Y{
    //这里的override(X,Y) 因为继承了 XY 两个合约 所以重写也要加上 xy 这里的顺序没要求         
    function foo() public pure override(X,Y) returns(string memory){
        return "Z_foo()";
    }

    function bar() public pure override(X,Y) returns (string memory){
        return "Z_bar()";
    }

}
