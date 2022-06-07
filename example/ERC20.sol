// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

//只要实现了erc20 接口定义的方法 就叫erc20 合约
interface IERC20{
    //代表当前合约的token总量
    function totalSupply() external view returns(uint);
    //代表某一个账号的当前余额
    function balanceOf(address account) external view returns(uint);
    //把账户余额由当前调用者 转账发送到另一个账号中，是写入方法，会向链外汇报一个transfer事件
    //通过事件能查到token流转
    function transfer(address recipient,uint amount) external returns (bool);

    function allowance(address onwner,address spender) 
    external view returns(uint);
    //把我账户里的余额批准给另一个账户，通过 allowance 查询 批准余额   
    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(address sender,address recipient, uint amount)
    external returns(bool);

    event Transfer(address indexed from, address indexed to,uint amount);
    event Approval(address indexed onwner,address indexed spender,uint amount);

}
contract ERC20 is IERC20{
    uint public totalSupply;

    mapping(address=>uint) public balanceOf;

    mapping(address=>mapping(address=>uint)) public allowance;
    string public name = "Test";
    string public symbol = "TEST";
    uint8 public decimals = 18;

    function transfer(address recipient ,uint amount) external returns (bool){
        balanceOf[msg.sender] -=amount;
        balanceOf[recipient] +=amount;
        emit Transfer(msg.sender,recipient,amount);
        return true;
    }



    function approve(address spender, uint amount) external returns(bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }
    function transferFrom(address sender,address recipient, uint amount)
    external returns(bool){
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] +=amount;
        emit Transfer(sender,recipient,amount);
        return true;
    }

    //简单写 不加权限控制
    function mint(uint amount) external{
        balanceOf[msg.sender] +=amount;
        totalSupply +=amount;
        emit Transfer(address(0),msg.sender,amount);
    }

    function burn(uint amount) external{
        balanceOf[msg.sender] -= amount;
        totalSupply=amount;
        emit Transfer(msg.sender,address(0),amount);
    }
}
