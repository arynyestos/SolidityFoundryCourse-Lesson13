// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Challenge13Solver {
    address private immutable i_owner;
    int256 private constant TARGET_NUMBER = 1337;
    // int256 private constant STORAGE_SLOT_0 = int256(uint256(uint160(0x643315C9Be056cDEA171F4e7b2222a4ddaB9F88D)));
    int256 private constant STORAGE_SLOT_0 = 572038313094850821099624258919152072749626292365;
    int256 private constant NUMBER = TARGET_NUMBER - STORAGE_SLOT_0 - 10;

    constructor() {
        i_owner = msg.sender;
    }

    function owner() external view returns (address) {
        return i_owner;
    }

    function getNumber() external pure returns (int256) {
        return NUMBER;
    }
}
