// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

library ArrayLib{

    function find(uint[] storage arr,uint x) internal view returns (uint){

        for(uint i =0;i<arr.length;i++){
            if (arr[i] == x){
                return i;
            }
        }
        revert("nof found");
    }
}


contract TestArray{
    uint[] public  arr = [3,2,1];

    //第一种写法
    function testFind() external  view  returns (uint i) {
        return   ArrayLib.find(arr,3);
    }
    //第二种写法
    using ArrayLib for uint[]; //把这个库应用到uint[] 这个类型里，这个类型就有了这个库的方法

    function testFind1() external view returns (uint i){
        return arr.find(2);
    }
}
