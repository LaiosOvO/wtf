// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MTK} from "../src/MTK.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployMTK  is Script {


    function run() public returns(MTK) {
        vm.startBroadcast();
        MTK token = new MTK(1000000_0000_0000_00000_00000);
        vm.stopBroadcast();
        return token;
    }
}