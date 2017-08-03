pragma solidity ^0.4.13;

/**
 * @title Emailer Interface Contract
 * @author Logan Saether <Lsaether@protonmail.com>
 * @info Use this contract to from other contracts to plug in 
 *       to established emailer services.
 */
contract EmailerAPI {
    function sendEmail(string _recipient, string _emailBody)
        payable public returns (uint _excessFunds);
    function getWeiCost() constant public returns (uint _cost);
}