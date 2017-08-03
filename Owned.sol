pragma solidity ^0.4.13;

/**
 * @title Owned
 * @author Logan Saether <Lsaether@protonmail.com>
 * @info Base contract to make a contract ownable.
 */
contract Owned {

    address owner;

    function Owned()
    {
        owner = msg.sender;
    }

    /// @notice Allows you to set the address to 0x0 to disable
    ///         any function with onlyOwner modifier.
    function changeOwner(address _who)
        onlyOwner
    {
        owner = _who;
        NewOwner(_who, now);
    }

    modifier onlyOwner()
    {
        assert(msg.sender == owner);
        _;
    }

    event NewOwner(address indexed newOwner, uint timestamp);
}