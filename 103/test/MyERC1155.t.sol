// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MyERC1155} from "../src/ERC1155.sol";
import {DeployMyERC1155} from "../script/MyERC1155.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyERC1155 is Test {

    DeployMyERC1155 deployer;
    MyERC1155 erc1155;


    function setUp() public {
        deployer = new DeployMyERC1155();
        erc1155 = deployer.run();
    }



    function testMintAndCount() public {
        erc1155.url;


    }
    

}