// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    // virtual 关键字 可以声明 该方法可以被继承者重写
    function foo() public pure virtual returns (string memory){
        return "A_foo()";
    }
// virtual 关键字 可以声明 该方法可以被继承者重写
    function bar() public pure virtual returns (string memory){
        return "A_bar()";
    }
    //该方法会完全被B合约继承
    function baz() public pure returns(string memory){
        return "A_baz";
    }

}

//B 继承 A
contract B is A{
    // override 声明 覆盖函数 可以覆盖 A 合约中的 foo 方法
    function foo() public pure override returns (string memory){
        return "B_foo()";
    }

    function bar() public pure override returns (string memory){
        return "B_bar()"; 
    }
}
