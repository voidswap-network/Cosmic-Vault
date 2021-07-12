// SPDX-License-Identifier: MIT License

pragma solidity ^0.8.6;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * It also provides the functionality to store the contract in VøidSwap's Cosmic Vault
 * using {storeInCosmicVault}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */

contract CVOwnable is Context {
    address private _owner;
    uint256 private _unlockTime;
    address private _previousOwner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "CVOwnable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }
    
    /**
     * @dev Returns the address of the previous owner.
     */
    function previousOwner() public view returns(address) {
        return _previousOwner;
    }
    
    /**
     * @dev Returns the unlock time of the contracted stored in the Cosmic Vault.
     */
    function getUnlockTime() public view returns(uint256){
        return _unlockTime;
    }


    /**
     * @dev Transfers ownership of the contract to the Cosmic Vault (`cosmicVault`) and
     * sets the time (`unlockTime`) at which the now stored contract can be transferred back to
     * the previous owner.

     * NOTE Can only be called by the current owner.
     */
    function storeInCosmicVault(address cosmicVault, uint256 unlockTime) public virtual onlyOwner {
        require(cosmicVault != address(0), "CVOwnable: new owner is the zero address");
        _previousOwner = _owner;
        _unlockTime = unlockTime;
        emit OwnershipTransferred(_previousOwner, cosmicVault);
        _owner = cosmicVault;
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).

     * NOTE Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "CVOwnable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        _previousOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(_previousOwner, newOwner);
    }

}
