pragma solidity ^0.4.13;

import './EmailerAPI.sol';

/**
 * @title Emailer Service Example
 * @author Logan Saether <Lsaether@protonmail.com>
 * @info An example of how you can plug your smart contract into
 *       the emailer service to send emails from smart contracts.
 */
contract Example {

    /// Decalre the address variable in the header of your contract.
    /// It will be set to 0x0 at first.
    EmailerAPI emailer;

    /// You must set the address to a known emailer service.
    function setEmailer(address _emailer)
    {
        emailer = EmailerAPI(_emailer);
    }

    /// Most of the time you will want to check the price first,
    /// or have it publically available somewhere.
    function getEmailerCost()
        public 
    {
        return emailer.getWeiCost();
    }

    /// Then have a function which can send an email using the API.
    function sayHiToMe()
        payable public
    {
        uint cost = emailer.getWeiCost();

        /// The Emailer checks msg.value but it's always good practice
        /// to check it yourself.
        require(msg.value >= cost);

        /// The sendEmail() function returns whatever excess value.
        uint excess = emailer.sendEmail("Lsaether@protonmail.com", "Hi Logan!");

        /// Handle excess funds however you wish, I recommend just
        /// sending it back to users.
        msg.sender.transfer(excess);
    }
}