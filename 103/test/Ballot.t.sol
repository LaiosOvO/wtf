// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Ballot} from "../src/Ballot.sol";
// import {DeployBallot} from "../script/Ballot.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BallotTest is Test {
    Ballot public ballot;
    address chairperson;
    address voter1;
    address voter2;
    bytes32[] proposalNames;


    function setUp() public {
        chairperson = address(this);
        voter1 = address(0x1);
        voter2 = address(0x2);
        proposalNames = new bytes32[](2);
        proposalNames[0] = "Proposal 1";
        proposalNames[1] = "Proposal 2";

        // 设置当前时间为 1000，并构造一个 60 秒的投票窗口
        vm.warp(1000);
        ballot = new Ballot(proposalNames , block.timestamp + 10, block.timestamp + 60);
   
   
        vm.prank(chairperson);
        ballot.giveRightToVote(voter1);
        ballot.giveRightToVote(voter2);
        vm.warp(1011); // 投票开始

    }


    function testVote() public {
        vm.prank(voter1);
        ballot.vote(0);
        (bytes32 name, uint256 voteCount) = ballot.proposals(0);


        assertEq(proposalNames[0], name);
        console.log(voteCount);
    }

    function testWinVote() public {
        testVote();
        
        uint256 idx = ballot.winningProposal();
        ( bytes32 name , uint256 count ) = ballot.proposals(idx);
        assertEq(ballot.winnerName() , name );
    }


    function testOutOfTime() public {

        vm.warp(1061); // 投票开始
        vm.expectRevert("Voting is not in progress");
        ballot.vote(0);

    }

    function testDelete() public {

        vm.prank(voter2);
        ballot.delegate(voter1);
        
        vm.prank(voter1);
        ballot.vote(0);

        ( , uint256 count) = ballot.proposals(0);

        assertEq( count , 2);
    }

    function testGiveRight() public {
        
        vm.prank(chairperson);
        ballot.setVoterWeight(voter1,10);
        vm.prank(voter1);
        ballot.vote(0);

        ( , uint256 count) = ballot.proposals(0);

        assertEq(count, 10);
    }



}