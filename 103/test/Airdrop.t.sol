// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Airdrop} from "../src/Airdrop.sol";
import {DeployAirdrop} from "../script/Airdrop.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AirdropTest is Test {
    DeployAirdrop deploy;
    IERC20 token;
    Airdrop airdrop;

    address User = makeAddr("user");
    address add1 = address(1);
    address add2 = address(2);

    function setUp() public {
        deploy = new DeployAirdrop();
        (token , airdrop) = deploy.run();

        // console.log(address(token));
        // console.log(address(airdrop));
    }

    function testAirdrop() public {

        vm.prank(msg.sender);
        token.approve(address(airdrop),1000);

        uint256 t = token.balanceOf(address(msg.sender));
        console.log(t);
        
        address[] memory addresses = new address[](2);
        addresses[0] = add1;
        addresses[1] = add2;
        uint[] memory amounts = new uint[](2);
        amounts[0] = 100;
        amounts[1] = 200;

        vm.prank(msg.sender);
        airdrop.multiTransferToken(address(token),addresses,amounts);
        
        console.log(token.balanceOf(add1));
        console.log(token.balanceOf(add2));
    }

}