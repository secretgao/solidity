// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Structs{

    struct Car{
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public car_arr;
    mapping(address =>Car[]) public carsByOwner;


    function example() external{
        //三种声明方法
        Car memory toyota = Car("toyota",1990,msg.sender);
        Car memory lambo = Car({year:1999,owner:msg.sender,model:"lambo"});
        Car memory tesla;
        tesla.model= "tesla";
        tesla.year=2010;
        tesla.owner=msg.sender;

        //push 到数组中
        car_arr.push(toyota);
        car_arr.push(lambo);
        car_arr.push(tesla);
    }
}
