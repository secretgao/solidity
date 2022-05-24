// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

interface ICounter{
    function count() external view returns(uint);
    function inc() external;
}

contract CallInterface{
    uint public count;

    function examples(address _count) external {
        ICounter(_count).inc();
        count = ICounter(_count).count();
    }
}
// counts.sol 先部署这个合约
