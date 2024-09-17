// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyAPE} from "../src/MyAPE.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployMyAPE  is Script {



    function run() public returns(MyAPE) {

        vm.startBroadcast();
        MyAPE ape = new MyAPE(msg.sender);
        ape.safeMint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        ape.safeMint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        ape.safeMint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        ape.safeMint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        ape.safeMint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        ape.safeMint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        ape.safeMint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        ape.safeMint(0xf2DC720aE2096aF65a203C1ecfDe61fEaceE1035);

        vm.stopBroadcast();
        // vm.prank(0x5f5e87Da0cE80C1caaf328047BEF97cac12b7A90);        
        // ape.safeMint(0x5f5e87Da0cE80C1caaf328047BEF97cac12b7A90);
        // ape.safeMint(0x5f5e87Da0cE80C1caaf328047BEF97cac12b7A90);
        return ape;
    }
}