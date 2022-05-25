// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract AccessControl{
    // indexed 索引
    event GrantRole(bytes32  indexed role,address  indexed account); //升级事件 
    event RevokRole(bytes32  indexed role,address  indexed account); //撤销事件
    //role => account => bool
    mapping(bytes32 =>mapping(address=>bool)) public roles;
    //先把 admin 和user 变成public 获取hash 之后的值 在变成 private
    //0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private  constant USER = keccak256(abi.encodePacked("USER"));

    modifier onlyRole(bytes32 _role){
        require(roles[_role][msg.sender],"not authorized");
        _;
    }

    constructor(){
        _grateRole(ADMIN,msg.sender);
    }
    //内部升级 不用检查权限
    function _grateRole(bytes32 _role,address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role,_account);
    }
    //外部升级 需要检查权限 只有管理员才能操作
    function grantRole(bytes32 _role,address _account) external onlyRole(ADMIN){
        _grateRole(_role,_account);
    }
    //撤销权限
    function revokRole(bytes32 _role,address _account) external onlyRole(ADMIN){
        roles[_role][_account] = false;
        emit RevokRole(_role,_account);
    }
}
