// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DutchAuction} from "../src/DutchAuction.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployDutchAuction  is Script {

    function setUp() public {
        
    }

    function run() public returns(DutchAuction) {
        vm.startBroadcast();
        DutchAuction dutchAuction = new DutchAuction();
        vm.stopBroadcast();
        return dutchAuction;
    }
}