// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {MyERC1155} from "../src/MyERC1155.sol";
import {DeployMyERC1155} from "../script/MyERC1155.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyERC1155Test is Test {

    address user1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address user2 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

    DeployMyERC1155 deployer;
    MyERC1155 erc1155;


    function setUp() public {
        deployer = new DeployMyERC1155();
        erc1155 = deployer.run();
    }



    function testMintAndCount() public {
        
        vm.startPrank(user1);
        erc1155.setURI("ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/");

        console.log(erc1155.uri(0));
        console.log(msg.sender);
        
        erc1155.mint(user1,0,1,"");
        erc1155.mint(user1,1,10,"");
        
        console.log(erc1155.balanceOf(user1,0));
        console.log(erc1155.balanceOf(user1,1));

        vm.stopPrank();
    }


    function test1155BatchMint() public {

        vm.startPrank(user1);
        address[] memory accounts = new address[](4);
        accounts[0] = user1;
        accounts[1] = user1;
        accounts[2] = user1;
        accounts[3] = user1;

        uint256[] memory ids = new uint256[](4);
        ids[0] = 1;
        ids[1] = 2;
        ids[2] = 3;
        ids[3] = 4;
        erc1155.mintBatch(user1 , ids,ids,"");
        console.log("log sth");
        uint256[] memory tmp = erc1155.balanceOfBatch(accounts,ids);
        // console.log(tmp);
        vm.stopPrank();
    }
    

    function test1155BatchTransfer() public {
        test1155BatchMint();
        
        address[] memory accounts = new address[](4);
        accounts[0] = user2;
        accounts[1] = user2;
        accounts[2] = user2;
        accounts[3] = user2;
        uint256[] memory ids = new uint256[](4);
        ids[0] = 1;
        ids[1] = 2;
        ids[2] = 3;
        ids[3] = 4;
        vm.prank(user1);
        erc1155.safeBatchTransferFrom(user1, user2, ids, ids, "");
        erc1155.balanceOfBatch(accounts, ids);

    }


}