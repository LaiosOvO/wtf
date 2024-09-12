// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Faucet{


    uint256 public amountAllowed = 100;
    address public tokenContract;
    mapping(address => bool) public requestedAddress;
    
    constructor( address _tokenContract ){
        tokenContract = _tokenContract;
    }


    event SendToken( address indexed Receiver , uint256 indexed Amount );


    function requestTokens() external {
        require(!requestedAddress[msg.sender] , "can not claim multiple times");
        IERC20 token = IERC20(tokenContract);
        require(token.balanceOf(address(this)) > amountAllowed , "the faucet account is empty");

        // transfer
        token.transfer(msg.sender, amountAllowed);
        requestedAddress[msg.sender] = true;

        emit SendToken(msg.sender, amountAllowed);    
    }

}
