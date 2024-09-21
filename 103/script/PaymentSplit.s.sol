// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PaymentSplit} from "../src/PaymentSplit.sol";
// import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployPaymentSplit  is Script {

    function run() public returns (PaymentSplit) {

        address[] memory tmpAddr = new address[](2);
        tmpAddr[0]=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        tmpAddr[1]=0x70997970C51812dc3A010C7d01b50e0d17dc79C8;


        uint256[] memory share = new uint256[](2);
        share[0]=1;
        share[1]=2;

        vm.startBroadcast();
        PaymentSplit contractDeploy = new PaymentSplit(tmpAddr,share);
        vm.stopBroadcast();

        return contractDeploy;
    }

    

}