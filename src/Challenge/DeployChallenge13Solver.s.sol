// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Challenge13Solver} from "./Challenge13Solver.sol";

contract DeployChallenge13Solver is Script {
    uint256 public deployerKey;

    function run() external returns (Challenge13Solver) {
        deployerKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerKey);
        Challenge13Solver exploitContract = new Challenge13Solver();
        vm.stopBroadcast();
        return (exploitContract);
    }
}
