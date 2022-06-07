// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

/*
*. 优化gas 小技巧
*/
contract GasGolf{
/*
    start - 58545 gas
   [1,2,3,4,5,100] 
*/
    uint public total;
 //开始执行 [1,2,3,4,5,100]    
 //初始化的gas 58545
    function test(uint[] memory nums) external{
        for (uint i=0; i<nums.length;i+=1){
            bool isEven = nums[i] %2 == 0;
            bool isLessThan99 = nums[i] < 99;
            if (isEven && isLessThan99){
                total +=nums[i];
            }
        }
    }
 //第一步优化 把memory 改成calldata   
 //执行  [1,2,3,4,5,100]   gas 56563
    function test1(uint[] calldata nums) external{
        for (uint i=0; i<nums.length;i+=1){
            bool isEven = nums[i] %2 == 0;
            bool isLessThan99 = nums[i] < 99;
            if (isEven && isLessThan99){
                total +=nums[i];
            }
        }
    }
 //第二步优化 
//执行  [1,2,3,4,5,100]   gas 56346
  function test2(uint[] calldata nums) external{
      uint _total = total;
        for (uint i=0; i<nums.length;i+=1){
            bool isEven = nums[i] %2 == 0;
            bool isLessThan99 = nums[i] < 99;
            if (isEven && isLessThan99){
                _total +=nums[i];
            }
        }
        total = _total;
    }  
//第三步优化
//执行  [1,2,3,4,5,100]   gas 56005 
  function test3(uint[] calldata nums) external{
      uint _total = total;
        for (uint i=0; i<nums.length;i+=1){
            if (nums[i] %2 == 0 && nums[i] < 99){
                _total +=nums[i];
            }
        }
        total = _total;
    }   
//第四步优化
//执行  [1,2,3,4,5,100]   gas 55435
   function test4(uint[] calldata nums) external{
      uint _total = total;
        for (uint i=0; i<nums.length;++i){
            if (nums[i] %2 == 0 && nums[i] < 99){
                _total +=nums[i];
            }
        }
        total = _total;
    }  

//第五步优化
//执行 [1,2,3,4,5,100]   gas 55310
    function test5(uint[] calldata nums) external{
      uint _total = total;
      uint len = nums.length;
        for (uint i=0; i<len; ++i){
            if (nums[i] %2 == 0 && nums[i] < 99){
                _total +=nums[i];
            }
        }
        total = _total;
    }

//第六步 优化
//执行  
    function test6(uint[] calldata nums) external{
      uint _total = total;
      uint len = nums.length;
        for (uint i=0; i<len; ++i){
            uint num = nums[i];
            if (num %2 == 0 && num < 99){
                _total +=num;
            }
        }
        total = _total;
    }       
}
