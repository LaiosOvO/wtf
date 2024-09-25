// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {TokenVesting} from "../src/TokenVesting.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployTokenVesting  is Script {


    function run() public returns (TokenVesting) {

        vm.startBroadcast();
        TokenVesting deployContract = new TokenVesting(vm.envAddress("ADDR1"),100);
        vm.stopBroadcast();

        return deployContract;
    }


}