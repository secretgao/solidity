// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ERC20.sol";
contract CrowdFund{

    event Lauch(uint id,address indexed creator,uint goal,uint32 startAt,uint32 endAt);
    event Cancel(uint id);
    event Pledge(uint indexed id,address indexed caller, uint amount);
    event UnPledge(uint indexed id,address indexed caller, uint amount); //撤销事件
    event Claim(uint id);
    event Refund(uint indexed id, address indexed caller,uint amount);
    struct Campaign{
        address creator;
        uint goal;
        uint pledged;
        uint32 startAt;   //因为是时间戳 uint32 完全够用
        uint32 endAt;
        bool claimed;
    }

    IERC20 public immutable token;
    uint public count;
    mapping(uint=>Campaign) public campaigns;
    mapping(uint=>mapping(address=>uint)) public pledgedAmount;

     constructor(address _token){
        token = IERC20(_token);
    }

    function lauch(
        uint _goal,
        uint32 _startAt,
        uint32 _endAt
    ) external{
        require(_startAt >= block.timestamp,"start at < now");
        require(_endAt >= _startAt,"end at < start at");
        require(_endAt <= block.timestamp + 90 days ,"end at > mamx duration");
        count +=1;
        campaigns[count] = Campaign({
            creator:msg.sender,
            goal:_goal,
            pledged:0,
            startAt:_startAt,
            endAt:_endAt,
            claimed: false
        });
        //定一个事件 向链外回报 上线了一个众筹
        emit Lauch(count, msg.sender,_goal,_startAt,_endAt);
    }
   
    

    //取消一个众筹活动 开始活动之前能取消
    function cancel(uint _id) external{
        Campaign memory campaign = campaigns[_id];
        require(msg.sender == campaign.creator,"not creator");
        require(block.timestamp < campaign.startAt,"started");
        delete campaigns[_id];
        emit Cancel(_id);
    }

//参与众筹
    function pledge(uint _id,uint _amount) external{
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt,"not started");
        require(block.timestamp <= campaign.endAt,"ended");
        campaign.pledged +=_amount;
        pledgedAmount[_id][msg.sender]+=_amount;
        token.transferFrom(msg.sender,address(this),_amount);

        emit Pledge(_id,msg.sender,_amount);    
    }

    function unpledge(uint _id,uint _amount) external{
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt,"ended");

        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -=_amount;
        token.transfer(msg.sender,_amount);
        emit UnPledge(_id, msg.sender,_amount);
    }

    function claim(uint _id) external{

        Campaign storage campaign = campaigns[_id];
        require(msg.sender == campaign.creator,"not creator");
        require(block.timestamp > campaign.endAt,"not ended");
        require(campaign.pledged >= campaign.goal,"pleadged < glod");
        require(!campaign.claimed,"claimed");

        campaign.claimed = true;
        token.transfer(msg.sender,campaign.pledged);
        emit Claim(_id);
    }

    //撤回 
    function refund(uint _id) external{
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt,"not ended");
        require(campaign.pledged < campaign.goal,"pledged < goal");

        uint bal = pledgedAmount[_id][msg.sender];
        pledgedAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender,bal);

        emit Refund(_id,msg.sender,bal);
    }

}
