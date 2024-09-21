// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyERC1155} from "../src/MyERC1155.sol";
import {MTK} from "../src/MTK.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DeployMyERC1155 is Script {


    function run() public returns (MyERC1155) {
        vm.startBroadcast();
        MyERC1155 erc1155 = new MyERC1155(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        vm.stopBroadcast();

        return erc1155;
    }

}
