// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.9.0;

// importing from chainlink data feed contract.
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    mapping(address => uint256) public donators;
    
    function fund() public payable{
        donators[msg.sender] += msg.value;
    }

    function getVersion() external view returns (uint256) {
        // 0x9326BFA02ADD2366b30bacB125260Af641031331 ==> address of the interface(contract) on the Kovan network
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331); 
        return priceFeed.version();
    }
}