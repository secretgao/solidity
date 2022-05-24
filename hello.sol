pragma solidity  ^0.4.0;

contract Helloworld{
    string Myname = "secret";


    function getName() public view returns(string){
        return Myname;
    }
    function changeName(string _newName) public {
        Myname = _newName;
    }
    function pureTest(string _name) pure public returns(string){
        return _name;
    }
}
