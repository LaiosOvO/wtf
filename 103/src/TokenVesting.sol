// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract TokenVesting {

    // 事件
    event ERC20Released(address indexed token, uint256 amount); // 提币事件

    // 状态变量
    mapping(address => uint256) public erc20Released; // 代币地址->释放数量的映射，记录已经释放的代币
    address public immutable beneficiary; // 受益人地址
    uint256 public immutable start; // 起始时间戳
    uint256 public immutable duration; // 归属期


    // 
    receive() external payable {  }
    fallback() external payable {  }


    constructor(
        address beneficiaryAddress,
        uint256 durationSeconds
    ) {
        require(beneficiaryAddress != address(0), "VestingWallet: beneficiary is zero address");
        beneficiary = beneficiaryAddress;
        start = block.timestamp;
        duration = durationSeconds;
    }

    // 
    function vestedAmount(address token, uint256 timestamp) public view returns (uint256) {
        uint256 totalReceived = IERC20(token).balanceOf(address(this)) + erc20Released[token];
        if( timestamp < start ){
            return 0;
        } else if( timestamp > end() ) {
            return totalReceived;
        } else {
            return totalReceived * ( timestamp - start ) / duration;
        }
    }

    function releasable(address token) public returns(uint256) {
        return vestedAmount(token , uint256(block.timestamp)) - erc20Released[token];
    }


    function release(address token) public {

        uint256 curRelease = releasable(token);
        erc20Released[token] += curRelease;
        IERC20(token).transfer( beneficiary , curRelease );
    
        emit ERC20Released(token , curRelease);
    }


    function end() public view returns (uint256) {
        return start + duration;
    }



}