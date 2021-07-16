# Cosmic Vault

Our Vault is a smart contract that runs on all our supported blockchains. When a team wants to renounce ownership, they transfer ownership rights to the Cosmic Vault smart contract.

> The Cosmic Vault cannot interact or make any sort of calls to the renounced smart contract.

If a team requires the ownership to be transferred back to them for any reason, they simply need to wait for the time to elapse and then pay the Vault the necessary fee. Then the ownership will be automatically transferred back to the previous owner.

> The **ONLY** address that can reclaim ownership of a contract stored in the Cosmic Vault is the one that initiated to transfer in the first place. In other words, **ONLY** the previous owner can get ownership of a stored contract in the Cosmic Vault.

## Flow Mechanics
![enter image description here](https://uploads-ssl.webflow.com/60e68647ab86ed50d89dbad6/60f12de83965cf244a1f24d3_Screenshot%202021-07-16%20095735.png)

## Requirements

When teams want to initiate an ownership transfer to the Cosmic Vault, they need to make sure that their smart contract abides with the requirement.

We have modified the OpenZappelin's [**Ownable.sol**](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol). Teams need to make sure that their smart contracts inherit from our **CVOwnable.sol** instead. Simply replace the `contract Ownable is Context` block from your smart contract with the code below depending on your deployment environment:
