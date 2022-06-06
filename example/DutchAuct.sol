// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC721{
    function transferFrom(address _from,address _to, uint _nftId) external;
}

/*
荷兰拍
源自拍卖郁金香，因为要求郁金香保鲜，所以随着时间的流失 价格会越来越低
*/
contract DutchAuction{
    uint private constant DURATION = 7 days;

    IERC721 public immutable nft;

    uint public immutable nftId;

    address payable public immutable seller;  //nft 当前持有者

    uint public immutable staringPrice;  //起拍价格
    uint public immutable startAt;       //拍卖开始时间
    uint public immutable expiresAt;     //过期时间 超过过期时间 会发生流拍
    uint public immutable discountRate; //折扣率

    constructor(uint _startingPrice,uint _discountRate,address _nft,uint _nftId){
        seller = payable(msg.sender);
        staringPrice = _startingPrice; 
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;
        //起拍价格必须大于折扣率*时间
        
        require(_startingPrice >= _discountRate * DURATION,"starting price < discount");

        nft = IERC721(_nft);
        nftId = _nftId; 
    }

    function getPrice() public view returns(uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return staringPrice - discount;
    }

    function buy() external payable{
        require(block.timestamp < expiresAt,"auction expired"); //判断是否过期
        uint price = getPrice();//获取价格
        require(msg.value >= price,"ETH < price");

        nft.transferFrom(seller,msg.sender,nftId);
        //因为价格是实时变动，购买者转入的eth 可能会大于nft的价格
        uint refund = msg.value - price;
        //计算差价 退还给购买者
        if (refund > 0){
            payable(msg.sender).transfer(refund);
        }
        //使用自毁函数 把合约中剩余的主币发送给部署者，还可以把部署合约消耗空间的gas 一起返还
        selfdestruct(seller);
    }


}
