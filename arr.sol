// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract Array{
    uint[] public nums = [1,2,3];
    uint[3] public numFixed = [4,5,6];

    function example() external{
        nums.push(4); //[1,2,3,4];
        uint x = nums[1]; //2
        nums[2] =777; //[1,2,777,4];
        delete nums[1]; //[1,0,777,4] 不会修改数组的长度 因为数组是uint 所以delete 改成默认值0
        nums.pop(); //[1,0,777]  pop 出来4

        uint len = nums.length; // 3

        //在内存中创建一个数组 不能创建动态数组 必须指定大小
        uint[] memory a = new uint[](5);
       // a.pop();  不能使用 pop 和 push 会改变数组的大小
       // a.push();
       a[1] = 22;
    }

    function returnArray() external view returns (uint[] memory){
        return nums;
    }
}
