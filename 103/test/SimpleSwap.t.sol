// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MTK,MTK2} from "../src/MTK.sol";
import {SimpleSwap} from "../src/SimpleSwap.sol";
import {DeploySimpleSwap} from "../script/SimpleSwap.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleSwapTest is Test {

    DeploySimpleSwap deployer;
    SimpleSwap res;
    IERC20 token0;
    IERC20 token1;

    address user1 = vm.envAddress("ADDR1");
    address user2 = makeAddr("1");

    function setUp() public {
        
        deployer = new DeploySimpleSwap();
        res = deployer.run();
        token0 = res.token0();
        token1 = res.token1();

        vm.startPrank(user1);

        token0.approve(address(res) , 100_0000 );
        token1.approve(address(res) , 100_0000 );
    }   



    function testAddLiquity() public {

        console.log("amm");
        vm.startPrank(user1);
        res.addLiquidity(1000,100);

        console.log(token0.balanceOf(address(res)));
        console.log(token1.balanceOf(address(res)));
        console.log(res.balanceOf(user1));
    
    }

    function testSwap() public {
        
        testAddLiquity();

        vm.startPrank(user1);
        res.swap(10,token1,1);
        
        
        console.log(token0.balanceOf(address(res)));
        console.log(token1.balanceOf(address(res)));
        console.log(res.balanceOf(user1));

    }

    function testRemoveLiquidity() public {

        testAddLiquity();
        vm.startPrank(user1);

        res.removeLiquidity(res.balanceOf(user1));

        console.log(token0.balanceOf(address(res)));
        console.log(token1.balanceOf(address(res)));

    }


}