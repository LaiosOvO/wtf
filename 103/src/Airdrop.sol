// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Airdrop{

    function getSum(uint256[] calldata _arr) public pure returns(uint sum) {
        for( uint256 i=0; i<_arr.length ;i++ ){
            sum = sum + _arr[i];
        }
    }

    function multiTransferToken(address _token , address[] calldata  _addresses,uint[] calldata _amounts) public {

        require(_addresses.length == _amounts.length ," number of address not equal amount ");
        IERC20 token = IERC20(_token);
        uint sum = getSum(_amounts);
        require(sum < token.balanceOf(address(msg.sender)) , "contract have not enough token");

        // distrabute token
        for(  uint256 i=0; i < _addresses.length ;i++ ){
            token.transferFrom( msg.sender , _addresses[i] , _amounts[i]);
        }

    }

}