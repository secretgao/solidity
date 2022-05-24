// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Ownable{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"not owner");
        _;
    }

    function setOnwer(address _newOwner) external onlyOwner{
        require(_newOwner != address(0),"invalid address");
        owner = _newOwner;

    }
    function onlyOwnerCanCallFunc() external onlyOwner{

    }


    function returnManyParam() public pure returns(uint x,bool b){
        x = 1;
        b = true;
       // or   return (1,true);
    }

    function assigment() public pure {
       // (uint x ,bool b) = returnManyParam();
        (,bool b) = returnManyParam();
    }
}
