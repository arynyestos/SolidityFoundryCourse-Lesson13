// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is StdCheats, Test {
    DeployBox public boxDeployer;
    UpgradeBox public boxUpgrader;
    address public OWNER = makeAddr("owner");

    address public proxy;

    function setUp() public {
        boxDeployer = new DeployBox();
        boxUpgrader = new UpgradeBox();
        proxy = boxDeployer.run();
    }

    function testDeploymentIsBoxV1() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(7);
    }

    function testUpgradeWorks() public {
        BoxV2 box2 = new BoxV2();
        boxUpgrader.upgradeBox(proxy, address(box2));

        uint256 expectedValue = 2;
        assertEq(expectedValue, BoxV2(proxy).version());

        BoxV2(proxy).setNumber(expectedValue);
        assertEq(expectedValue, BoxV2(proxy).getNumber());
    }

    function testBoxWorks() public {
        address proxyAddress = boxDeployer.deployBox();
        uint256 expectedValue = 1;
        assertEq(expectedValue, BoxV1(proxyAddress).version());
    }
}
