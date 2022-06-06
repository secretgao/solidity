// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC721{
    function transferFrom(
        address from,
        address to,
        uint  nftId
    ) external;
}
/*
* 英氏拍卖，价高者得
*/
contract EnglishAuction{

    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address bidder, uint amount);
    IERC721 public immutable nft;
    uint public immutable nftId;  //nft 地址id 只能拍卖一个 

    address public immutable seller; //销售者的地址
    uint32 public endAt;  //结束时间
    bool public started;  //拍卖是否开始
    bool public ended;    //拍卖是否结束

    //出价者信息
    address public highestBidder;   //最高出价者得地址
    uint public highestBid;  //最高价
    //每一个出价者的出价 ，当最高价拍到nft之后，其他出价者，出价要返还给出价者
    mapping(address=>uint) public bids; 

    constructor(
        address _nft,
        uint _nftId,
        uint _staringBid
    ){
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _staringBid;
    }

    function start() external{
        require(msg.sender == seller, "not seller");
        require(!started,"started");

        started = true;
        //开始拍卖之后的60秒就结束了
        endAt = uint32(block.timestamp + 60); //60s
        nft.transferFrom(seller,address(this),nftId);
        emit Start();
    }
    //拍卖
    function bid() external payable{
        require(started,"not started");
        require(block.timestamp < endAt, "ended");
        //每次出价都大于上次价格
        require(msg.value > highestBid,"value < highest bid");

        if (highestBidder != address(0)){
            bids[highestBidder] +=highestBid;
        }
        //更新当前最高价
        highestBid = msg.value;
        highestBidder = msg.sender;
        emit Bid(msg.sender,msg.value);
    }
    //取会出价，假如别人比你出价高，就可以把你的出价取会
    function withdraw() external{
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender,bal);
    }

    //结束方法
    function end() external{
        require(started,"not started");
        require(!ended,"ended");
        require(block.timestamp >= endAt,"not ended");
        ended = true;
        if (highestBidder != address(0)){
            nft.transferFrom(address(this),highestBidder,nftId);
             seller.transfer(highestBid);
            emit End(highestBidder,highestBid);
        } else {
            nft.transferFrom(address(this),seller,nftId);
        }
      //  emit End(highestBiddder,highestBid);
    }
}
