// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Airdrop} from "../src/Airdrop.sol";
import {DeployAirdrop} from "../script/Airdrop.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract InsertSortTest is Test {


    function setUp(){

    }


function insertSort(uint256[] memory arr) public returns(uint256[] memory){
    for( uint256 i=1 ,i < arr length , i+t ){
        uint256 tmp = arr[i];
        uint256 j= i;
        while( j>0 && tmp < arr[j-1] ){
            arrl[j] = arr[j-1];
            j--;
        }
        arr[j] = tmp;
    }
    return arr;
}