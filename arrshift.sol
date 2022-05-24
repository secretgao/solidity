// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract ArrayShift{
    uint[] public arr;


    function example() public {
        arr = [1,2,3];
        delete arr[1]; //[1,0,3]
    }
    //因为 delete 会 删除索引对应下标的值，但是数组长度不会改变所以实现remove 方法
    //删除对应索引下标的值 并且长度减少1 
    // [1,2,3] -> remove(1) ->[1,0,3] -> [1,3,3] ->[1,3]
    //[1,2,3,4,5,6] ->remove(2)->[1,2,4,5,6,6]->[1,2,4,5,6]
    function remove(uint _index) public {
        //保证数组的顺序
        //耗费大量的gas费    
        require(_index < arr.length,"index out of bound");
        uint len = arr.length;
        for(uint i = _index; i<len-1;i++){
            arr[i] = arr[i+1];
        }
        arr.pop();
    }

    function test() external{
        arr = [1,2,3,4,5];
        remove(2);
        assert(arr[0]==1);
        assert(arr[1]==2);
        assert(arr[2]==4);
        assert(arr[3]==5);
       
    }

    //这样也能移出指定索引位置的值
    //但是不保证数组顺序 会节省gas费用
    function remove1(uint _index) public{
        arr[_index] = arr[arr.length-1];
        arr.pop();
    }
}
