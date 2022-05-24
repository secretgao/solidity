// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract IfElse{

    function example(uint x) external pure returns (uint){

        if (x < 10){
           return 1;     
        } else if (x <20){
            return 2;
        } 
    }

    function t(uint x) external pure returns (uint){
        return x < 10 ? 1:2;
    }
}
