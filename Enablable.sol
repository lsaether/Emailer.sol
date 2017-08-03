pragma solidity ^0.4.13;

import './Owned.sol';

/**
 * @title Enablable
 * @author Logan Saether <Lsaether@protonmail.com>
 * @info Base contract to make a contract enablable.
 * @warning ANY CONTRACT THAT INHERITS FROM THIS ONE
 *          CAN SET IT'S OWN METHODS WHICH CALL toggle()
 *          AND CAN MITIGATE THE ONLYOWNER FEATURE. THIS
 *          IS BOTH A PERK AND A WARNING, HERE BE NUKES.
 */
contract Enablable is Owned {

    bool enabled;           // default is False

    function enable()
        onlyOwner
    {
        assert(toggle())
    }

    function disable()
        onlyOwner 
    {
        assert(!toggle())
    }

    modifier onlyIfEnabled()
    {
        assert(enabled);
        _;
    }

    /// @dev Low-level internal toggle feature.
    /// @notice Use enable() or disable() if interacting with
    ///         this contract. toggle() is for dev usage only.
    /// @warning Change `internal` to `private` if you want safety.
    function toggle()
        internal returns (bool _enabled)
    {
        enabled = !enabled;
        return enabled;
    }
}