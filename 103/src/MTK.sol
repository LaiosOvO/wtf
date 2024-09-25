// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MTK is ERC20 {

    address public owner;

    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        owner = msg.sender;
        _mint(msg.sender, initialSupply);
    }
}

contract MTK2 is ERC20 {

    address public owner;

    constructor(uint256 initialSupply,address _owner) ERC20("MyToken", "MTK") {
        owner = _owner;
        _mint(_owner, initialSupply);
    }
}