// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {WETH} from "../src/WETH.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployWETH  is Script {

    function run() public returns (WETH) {
        vm.startBroadcast();
        WETH weth = new WETH(msg.sender);
        vm.stopBroadcast();

        return weth;
    }

    

}