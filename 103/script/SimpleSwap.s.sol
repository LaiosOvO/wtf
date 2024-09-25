// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {SimpleSwap} from "../src/SimpleSwap.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {MTK2} from "../src/MTK.sol";


contract DeploySimpleSwap  is Script {

   IERC20 token0;
   IERC20 token1;

    function run() public returns(SimpleSwap) {

        vm.startBroadcast();
        // vm.startPrank(vm.envAddress("ADDR1"));
        token0 = new MTK2(1000_0000_0000,vm.envAddress("ADDR1"));
        token1 = new MTK2(1000_0000_0000,vm.envAddress("ADDR1"));

        SimpleSwap res = new SimpleSwap( token0, token1 );
        vm.stopBroadcast();
        
        return res;
    }   


}