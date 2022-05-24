// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FunctionModifier{

   bool public paused;
   uint public count;

   function setPause(bool _paused) external{
       paused = _paused;
   }
    //不带参数的函数修改器
   modifier whenNotPaused(){
       require(!paused,"paused");
       _; //这里就相当于 inc和 dec里的代码
   }

   function inc() external whenNotPaused{
       count +=1;
   }

   function dec() external whenNotPaused{
       count -=1;
   }
   //带参数的函数修改器 
   modifier cap(uint _x){
       require(_x < 100,"x>=100");
       _; //
   }

   function incBy(uint _x) external cap(_x){
       count +=_x;
   }

   //函数修改器 三明治写法 
   modifier sandwich(){
       count +=10;
       _;
       count *=2;
   }

   function foo() external sandwich{
       count +=1;
   }
}
