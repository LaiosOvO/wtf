// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MyAPE} from "../src/MyAPE.sol";
import {DeployMyAPE} from "../script/MyAPE.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyAPETest is Test {

    MyAPE ape;


    function setUp() public {
        
        DeployMyAPE deploy = new DeployMyAPE();
        ape = deploy.run();

        vm.startPrank(0xf2DC720aE2096aF65a203C1ecfDe61fEaceE1035);
        console.log(msg.sender);
        ape.safeMint(0xf2DC720aE2096aF65a203C1ecfDe61fEaceE1035);
        ape.safeMint(0xf2DC720aE2096aF65a203C1ecfDe61fEaceE1035);
        ape.safeMint(0xf2DC720aE2096aF65a203C1ecfDe61fEaceE1035);
        ape.safeMint(0xf2DC720aE2096aF65a203C1ecfDe61fEaceE1035);
        ape.safeMint(0x5f5e87Da0cE80C1caaf328047BEF97cac12b7A90);

        uint256 balance = ape.balanceOf(0x5f5e87Da0cE80C1caaf328047BEF97cac12b7A90);
        console.log(balance);
        // console.log(ape);
        console.log(address(ape));

        address nft1 = ape.ownerOf(0);
        console.log(nft1);
        vm.stopPrank();

    }

    function testApe() public {}


}