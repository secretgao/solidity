// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Hash{
    function hash(string memory text,uint num,address addr) external pure returns (bytes32){
       return  keccak256(abi.encodePacked(text,num,addr));
    }

    // test0 = "a", test1 = "b";
    function encode(string memory text0,string memory text1) external pure returns(bytes memory){
        return abi.encode(text0,text1);
        //bytes: 0x000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000001610000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016200000000000000000000000000000000000000000000000000000000000000
    }
   // test0 = "a", test1 = "b";
    function encodePacked(string memory text0,string memory text1) external pure returns(bytes memory){
        return abi.encodePacked(text0,text1);
     //   0:bytes: 0x6162
    //使用encodePacked 会出现hash 运算碰撞的问题
    // test0 = "aa", test1 = "b";0:bytes: 0x616162
    // // test0 = "a", test1 = "ab"; 0:bytes: 0x616162

    }

}
