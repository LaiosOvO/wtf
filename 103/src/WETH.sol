// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WETH is ERC20, ERC20Burnable, Ownable {

    event Deposit(address indexed depositer , uint256 amount);
    event Withdrawal( address indexed src , uint256 amount );

    constructor(address initialOwner)
        ERC20("WETH", "WETH")
        Ownable(initialOwner)
    {}

    function mint(address to, uint256 amount) public  {
        _mint(to, amount);
    }

    fallback() external payable {
        deposit();
    }

    receive() external payable {
        deposit();
    }


    function deposit() public payable {
        require(msg.value > 0, "need eth to deposit");
        _mint(msg.sender , msg.value);
        emit Deposit(msg.sender, msg.value);
    }


    function withdraw(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount , "balance not enough");
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount);

        emit Withdrawal(msg.sender, amount);
    }

}