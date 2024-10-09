// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Airdrop} from "../src/Airdrop.sol";
import {MTK} from "../src/MTK.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployAirdrop is Script {  


    function setUp() public {
    }

    function run() public returns ( IERC20 , Airdrop){
        vm.startBroadcast();
        MTK token = new MTK(1_0000_0000e18);
        Airdrop airdrop = new Airdrop();
        vm.stopBroadcast();


        return (token,airdrop);
    }


}
