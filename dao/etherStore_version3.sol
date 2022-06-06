// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
//存钱罐
// 规定每周至多取一个eth
// 更换call 为transfer 因为 transfer的gas费有限制2300，  call的gas费无限制
contract EtherStore{
    
    //创建取款金额的阙值
    uint256 public withdarwLimit = 1 ether;
    //创建两个映射 一个是上次获得的时间，一个是地址余额
    mapping(address => uint256) public lastWithdrawTime;
    mapping(address => uint256) public  balances;
 
    //存钱
    function depositFinds() public payable{
        balances[msg.sender] += msg.value; 
    }

    //提钱
    function withdarwFunds(uint256 _weiToWithdraw) public {
        
        //判断你当前的余额是否大于 取款金额
        require(balances[msg.sender] >= _weiToWithdraw);
        balances[msg.sender] -= _weiToWithdraw;
        //不能超过取款限额
        require(_weiToWithdraw <= withdarwLimit,"no  withdarwLimit");

        require(now >= lastWithdrawTime[msg.sender] + 1 weeks);
        lastWithdrawTime[msg.sender] = now;

        msg.sender.transfer(_weiToWithdraw);
    
    }
}
