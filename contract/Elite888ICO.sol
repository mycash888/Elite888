
pragma solidity ^0.4.15;

import "./ERC20Interface.sol";
import "./owned.sol";

/**
 * ICO for The Elite 888 Token. For the first 3 days, the minimum purchase is 1 Elite 888 token 
 * and there is no maximum. Fractional tokens will not be available for sale until
 * after the first 72 hours.  The minimum purchase during days 4-6 is .5 Elite 888 token. 
 * The minimum purchase during days 7-9 is .25 Elite 888 token, and all remaining tokens are 
 * then available at any fraction.
 * 
 * Two discount periods exist as well.  On day 1, there is a 20% discount on the price in Ether.
 * On day 2 there is a 10% discount on the price in Ether.
 * 
 */

contract Elite888ICO is owned {

    /* Reward */
    ERC20Interface public tokenReward;

    /* ICO details */
    uint256 private _price; 
    bool private _paused;

    /* Timing parameters */
    uint256 private _startTime; 
    uint256 private _deadline; 
    uint256 private _phase1deadline;
    uint256 private _phase2deadline;
    uint256 private _phase3deadline;
    uint256 private _discount1deadline;
    uint256 private _discount2deadline;

    /*  at initialization */
    function Elite888ICO(
        ERC20Interface addressOfTokenUsedAsReward,
        uint startTime 
    ) {
        _startTime = startTime;                              
        _deadline = _startTime + 43200 * 1 minutes;            // 30 Days
        _phase1deadline = _startTime + 4320 * 1 minutes;       // 3 days
        _phase2deadline = _phase1deadline + 4320 * 1 minutes;  // 3 Days
        _phase3deadline = _phase2deadline + 4320 * 1 minutes;  // 3 Days 
        _discount1deadline = _startTime + 1440 * 1 minutes;    // 1 Day
        _discount2deadline = _discount1deadline + 1440 * 1 minutes;    // 1 Day
        _price = 8 ether;
        tokenReward = ERC20Interface(addressOfTokenUsedAsReward);
        _paused = false;
    }

    /* Allow owner to resume ICO */
    function resumeIco() onlyOwner {
      _paused = false;
    }

    /* Allow owner to pause ICO */
    function pauseIco() onlyOwner {
      _paused = true;
    }

    /* This contract inherits the "onlyOwner"-modifier from
     *   "owned" and applies it to the "close"-function, which
     *  causes that calls to "close" only have an effect if
     *  they are made by the stored owner.
     */
    function close() onlyOwner {
        uint256 balance = tokenReward.balanceOf(this);
        tokenReward.transfer(owner, balance);
        selfdestruct(owner);
    }

    /* The function without name is the default function that is called whenever anyone sends funds to a contract */
    function () payable {
        require(_paused == false);
        require(msg.value > 0);
        require(block.timestamp > _startTime);
        require(block.timestamp < _deadline);

        uint256 price = 8 ether;
        if(block.timestamp < _discount1deadline) {
          price = 6.4 ether; 
        } else if(block.timestamp < _discount2deadline) {
          price = 7.2 ether; 
        }

        // Verify ICO timestamp
        if(block.timestamp < _phase1deadline) {
          require(msg.value >= price);
        } else if(block.timestamp < _phase2deadline) {
          require(msg.value >= (price/2));
        } else if(block.timestamp < _phase3deadline) {
          require(msg.value >= (price/4));
        } 

        uint256 awardTokens = (msg.value * 10**18) / (price);
        tokenReward.transfer(msg.sender, awardTokens);    // Number of tokens
    }

}


