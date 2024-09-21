// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PaymentSplit} from "../src/PaymentSplit.sol";
import {DeployPaymentSplit} from "../script/PaymentSplit.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PaymentSplitTest is Test {

    DeployPaymentSplit deployer;
    PaymentSplit ps;



    address user1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address user2 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
    address user3 = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;


    function setUp() public {
        deployer = new DeployPaymentSplit();
        ps = deployer.run();
    }


    function testAddPSPayee() public {
        ps._addPayee(user3,1);
        uint256 share3 = ps.shares(user3);
        console.log(share3);
    }

    function testRelease() public {
        
        vm.startPrank(user1);
        payable(ps).transfer(10 ether);
        console.log(address(ps).balance);
        ps.release(payable(user1));
        console.log(address(ps).balance);
        
    }

}