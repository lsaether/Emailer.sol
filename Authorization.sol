pragma solidity ^0.4.13;

import './Owned.sol';

/**
 * @title Authorization Tools
 * @author Logan Saether <Lsaether@protonmail.com>
 * @info Base contract to authorize addresses.
 */
contract Authorization is Owned {

    enum Authorized {
        Error,
        Pending,
        No,
        Yes
    }

    mapping(address => Authorized) auth;

    function addAuth(address _who)
        onlyOwner 
    {
        assert(_who != 0x0);
        auth[_who] = Authorized.Yes;
        AddAuth(_who, now);
    }

    function addAuthMany(address[] _whos)
        onlyOwner 
    {
        for (uint i = 0; i < _whos.length; ++i) {
            addAuth(_whos[i]);
        }
    }

    function removeAuth(address _who)
        onlyOwner
    {
        assert(_who != 0x0);
        auth[_who] = Authorized.No;
        RemovedAuth(_who, now);
    }

    function removeAuthMany(address[] _whos)
        onlyOwner
    {
        for (uint i = 0; i < _whos.length; ++i) {
            removeAuth(_whos[i]);
        }
    }

    function requireAuth(address _who) 
        internal constant returns (bool)
    {
        assert(auth[_who] == Authorized.Yes);
        return true;
    }

    modifier onlyAuthSend() 
    {
        assert(requireAuth(msg.sender));
        _;
    }

    event AddAuth(address indexed authorizedAddress, uint indexed timestamp);
    event RemoveAuth(address indexed authorizedAddress, uint indexed timestamp);
}