// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DutchAuction} from "../src/DutchAuction.sol";
import {DeployDutchAuction} from "../script/DutchAuction.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DutchAuctionTest is Test {
    DeployDutchAuction deploy;
    DutchAuction dutchAuction;


    function setUp() public {
        
        deploy = new DeployDutchAuction();
        dutchAuction = deploy.run();

        // address user1 = makeAddress(1);
    }

    function testSetStartTime() public {

        vm.prank(msg.sender);
        dutchAuction.setAuctionStartTime(1);
        uint256 startTime = dutchAuction.auctionStartTime();
        console.log(startTime);
    }


    

}