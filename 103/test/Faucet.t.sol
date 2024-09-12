// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Faucet} from "../src/Faucet.sol";
import {DeployFaucet} from "../script/Faucet.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FaucetTest is Test {
    DeployFaucet deploy;
    IERC20 token;
    Faucet faucet;

    address User = makeAddr("user");

    function setUp() public {
        deploy = new DeployFaucet();
        (token , faucet) = deploy.run();

        // console.log(address(token));
        // console.log(address(faucet));
    }

    function testToken() public {
        // vm.prank(User);
        uint256 balance = token.balanceOf(address(msg.sender));
        uint256 contractBalance = token.balanceOf(address(faucet));
        console.log(balance);
        console.log(contractBalance);

        vm.prank(address(msg.sender));
        token.transfer(address(faucet) , 10000);
        contractBalance = token.balanceOf(address(faucet));
        console.log(contractBalance);
    }

    function testReq() public {

        // construct the faucet contract     
        uint256 balance = token.balanceOf(address(msg.sender));
        uint256 contractBalance = token.balanceOf(address(faucet));
        console.log(balance);
        console.log(contractBalance);

        vm.prank(address(msg.sender));
        token.transfer(address(faucet) , 10000);
        contractBalance = token.balanceOf(address(faucet));
        console.log(contractBalance);

        vm.startPrank(User);
        uint256 bb = token.balanceOf(User);
        uint256 bfb = token.balanceOf(address(faucet));
        faucet.requestTokens();
        uint256 ab = token.balanceOf(User);
        uint256 afb = token.balanceOf(address(faucet));

        console.log(bb);
        console.log(ab);
        console.log(bfb);
        console.log(afb);

        vm.expectRevert();
        faucet.requestTokens();
    }


    

}
