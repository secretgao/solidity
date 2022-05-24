// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


/*
fallback()  和 receive() 两个函数的区别


        eth send to contract
                ｜
        is msg.data empty ? 
            /       \        
          yes        no
         /            \
    receive() exist?   fallback()
       /    \
     yes    no
     /       \
  receive()  fallback()   

*/



//fallback  如果调用
contract FallBack{

    event Log(string func, address sender,uint value,bytes data);

    fallback() external payable{
        emit Log("fallback",msg.sender,msg.value,msg.data);
    }

    receive() external payable{
        emit Log("receive",msg.sender,msg.value,"");
    }
}
