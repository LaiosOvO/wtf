// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {WETH} from "../src/WETH.sol";
import {DeployWETH} from "../script/WETH.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WETHTest is Test {

    DeployWETH deployer;
    WETH weth;
    address user1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    function setUp() public {
        deployer = new DeployWETH();
        weth = deployer.run();
    }


    function testDeposite() public {
        
        vm.prank(user1);
        console.log(user1.balance);
        weth.deposit{value: 2 ether}();
        uint256 balance = weth.balanceOf(user1);
        console.log(balance);

        console.log(address(weth).balance);
    }


    function testDefaultReceive() public {
        // vm.prank(user1);
        // vm.gasLimit(8000000);
        vm.pauseGasMetering();
        payable(weth).transfer(2 ether);
        console.log("******************");
        uint256 balance = weth.balanceOf(user1);
        console.log(balance);
        console.log(address(weth).balance);
    }
    
    function testWithdraw() public {

        vm.prank(user1);
        weth.deposit{value: 2 ether}();        
        console.log(weth.balanceOf(user1));

        vm.prank(user1);
        weth.withdraw(1.5 ether);
        console.log(address(weth).balance);
        uint256 balance = weth.balanceOf(user1);
        console.log(balance);
    }

    // 13971
    // 72657


}