// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
//多签 钱包
//必须在合约中有多个人同意的情况下，才能将合约主币向外转出
contract MultiSigWallet{
    //事件
    event Deposit(address indexed sender,uint amount);  //存款事件
    event Submit(uint indexed txId);                   //提交一个交易申请事件
    event Approve(address indexed onwner, uint indexed txId); //审核事件
    event Revoke(address indexed onwner, uint indexed txId);//撤销事件
    event Execute(uint indexed txId); //执行事件


    address[] public owners;  //多个签名人 
    mapping(address=>bool)  public isOwner;
    uint public required; //确认数， 不管签名集合中有多少人，只要达到了确认数中的人数，就可以触发转账

    struct Transaction{
        address to;
        uint value;
        bytes data;
        bool executed;
    }
    Transaction[] public transactions;
    mapping(uint =>mapping(address =>bool)) public approved;

    constructor(address[] memory _owners, uint _required){
        require(_owners.length > 0, "owners required");
        require(_required > 0 && _required <= _owners.length,"invalid required number of owners");
        for (uint i; i< _owners.length; i++){
            address onwner = _owners[i];
            require(onwner != address(0),"invalid owner");
            require(!isOwner[onwner],"owner is not unquire");

            isOwner[onwner] = true;
            owners.push(onwner);
        }
        required = _required;
    } 




    receive() external payable{
        emit Deposit(msg.sender,msg.value);
    }

    //函数修改器 判断是不是签名人 才能执行函数
    modifier onlyOwner(){
        require(isOwner[msg.sender],"not owner");
        _;
    }
    //函数修改器 判断交易id 是不是存在的
    modifier txExists(uint _txId){
        //因为交易id 记录的是数组的索引，所以只要判断id 小于数组的长度，交易id 就一定是存在的
        require(_txId < transactions.length, "txid does not exist");
        _;
    }
    //判断当前交易id 还没有被签名人批准过
    modifier notApproved(uint _txId){
        require(!approved[_txId][msg.sender],"tx already approved");
        _;
    }
    modifier notExecuted(uint _txId){
        require(!transactions[_txId].executed,"tx already executed");
        _;
    }

    function submit(address _to,uint _value, bytes calldata _data) external onlyOwner{

        transactions.push(Transaction({
            to:_to,
            value:_value,
            data:_data,
            executed:false
        }));
        //数组的长度 -1 就是交易id txId
        emit Submit(transactions.length - 1); 
    }

    function approve(uint _txId) external 
    onlyOwner              //函数修改器 必须是签名人才能执行
    txExists(_txId)        //判断是不是已经存在的交易id ，如果不存在的id 不执行
    notApproved(_txId)     //判断是否已经审核过了，审核过了不执行
    notExecuted(_txId)     //判断是否已经执行过了，执行过了不执行
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender,_txId);
    }

    function _getApprovalCount(uint _txId) private view returns(uint){
        for (uint i; i< owners.length; i++){
            if (approved[_txId][owners[i]]){
                count +=1;
            }
        }
        
    }

    function execute(uint _txId) external txExists(_txId) notExecuted(_txId){
        require(_getApprovalCount(_txId) >= required,"approvals < required");
        Transaction storage transaction  = transactions[_txId];
        transaction.executed = true; //改成true 就不能再次执行了
        (bool success,) = transaction.to.call{value:transaction.value}(transaction.data);
        require(success,"execute tx failed");
        emit Execute(_txId);
    }

    //撤销
    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId){
        require(approved[_txId][msg.sender],"tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender,_txId);
    }

}
