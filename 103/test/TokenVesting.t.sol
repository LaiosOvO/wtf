// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TokenVesting} from "../src/TokenVesting.sol";
import {DeployTokenVesting} from "../script/TokenVesting.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WETHTest is Test {

    DeployTokenVesting deployer;
    TokenVesting con;

    function setUp() public {

        deployer = new DeployTokenVesting();
        con = deployer.run();
    }


    

}