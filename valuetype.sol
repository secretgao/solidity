// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ValueTypes{
    bool public b = true; //true false
    uint public u = 123;
    // uint  = uint 256 0 to 2**256 -1
    //.        uint 8   0 to 2**8-1
    //         uint 16  0 to 2**16-1 
    int public i = -132;  //负数
    
    int public minInt = type(int).min; //int 最小
    int public maxInt = type(int).max; //int 最大

   // address public addr = 0xd7f98f89xdf4ffdf4jknk13bcFD;
   // bytes public b32 = 0xd7f98f89xdf4ffdf4jknk13bcFDcc;                           
}
