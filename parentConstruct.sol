// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract S {
    string public name;
    constructor(string memory _name){
        name = _name;
    }
}
contract T {
    string public text;
    constructor(string memory _text){
        text = _text;
    }
}

/*U合约继承了 S和T合约
 S 和T 合约有构造函数
 如果已知构造函数的值 就在继承合约中直接写入S("s"),T("t")  

*/
contract U is S("s"), T("t"){

}
//如果需要外部输入 
contract V is S,T{
    constructor(string memory _name,string memory _text) S (_name) T(_text){

    }
}

// 一部分已知 一部分 需要外部传入
contract VV is S("s"),T{
    constructor(string memory _text) T(_text){

    }
}
