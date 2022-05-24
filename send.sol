// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
//send eth
/*
1.transfer - 2300gas  revents
2.send     - 2300gas  returns bool;
3.call     - all gas  returns bool and data;

*/

contract SendEth{

    constructor() payable{}


    function sendTOTransfer(address payable _to) external payable{
        _to.transfer(123);
    }

    function sendToSend(address payable _to) external payable{
       bool evet =  _to.send(123);
       require(evet,"send fail");
    }

    function sendToCall(address payable _to) external payable{
        (bool success,bytes memory data)= _to.call{value:123}("");
        require(success,"send fail");

    }
}

contract EthReceiver{
    event Log(uint amout,uint gas);
    receive() external payable{
        emit Log(msg.value,gasleft());
    }
}
