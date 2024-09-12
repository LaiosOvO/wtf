// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Faucet} from "../src/Faucet.sol";
import {MTK} from "../src/MTK.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployFaucet is Script {


    function setUp() public {
    }

    function run() public returns ( IERC20 , Faucet){
        vm.startBroadcast();
        MTK token = new MTK(1_0000_0000e18);
        Faucet faucet = new Faucet(address(token));
        vm.stopBroadcast();

        return (token,faucet);
    }


}
