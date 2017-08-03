pragma solidity ^0.4.13;

import './Authorization.sol';
import './Enablable.sol';
import './SafeMath.sol';

/**
 * @title Emailer
 * @author Logan Saether <Lsaether@protonmail.com>
 * @info Smart contract to plug in to and send emails from other contracts.
 */
contract Emailer is Authorization, Enablable {
    using SafeMath for uint;

    uint weiCost;           // This is not a free service.

    function Emailer(uint _weiCost)
    {
        weiCost = _weiCost;
    }

    function sendEmail(string _recipient,
                       string _msg)
        // onlyAuthSend
        // onlyIfEnabled
        payable public returns (uint _excess)
    {
        // Send enough ether to cover costs.
        assert(msg.value >= weiCost);

        // Maybe you sent extra on mistake.
        uint excess = 0;
        if (msg.value.sub(weiCost) > 0) {
            excess = msg.value.sub(weiCost);
        }

        // Accept pay and send the email.
        uint pay = msg.value.sub(excess);
        owner.transfer(pay);
        Email(msg.sender, _recipient, _msg);

        // Give back excess funds.
        return excess;
    }

    function getWeiCost()
        constant public returns (uint)
    {
        return weiCost;
    }

    function setWeiCost(uint _newWeiCost)
        onlyOwner
    {
        weiCost = _newWeiCost;
        WeiCostSet(weiCost);
    }

    event Email(address indexed sender, string recipient, string msg);
    event WeiCostSet(uint newWeiCost);
}