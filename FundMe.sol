// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.9.0;

contract FundMe {
    mapping(address => uint256) public donators;
    
    function fund() public payable{
        donators[msg.sender] = msg.value;
    }
}