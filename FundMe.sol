// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.9.0;

// importing from chainlink data feed contract.
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    mapping(address => uint256) public addressToAmountFunded;
    
    function fund() public payable{
        // minimum of $50
        uint256 minimumUsd = 50 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUsd, "You need to donate more ETH!");
        
       addressToAmountFunded[msg.sender] += msg.value;
    }

    function getVersion() external view returns (uint256) {
        // 0x9326BFA02ADD2366b30bacB125260Af641031331 ==> address of the interface(contract) on the Kovan network
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331); 
        return priceFeed.version();
    }


    function getPrice() external view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        ( ,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer);
    }

     // 1 Gwei == 0.00002037USD: this may vary over time.
    function getConversionRate(uint256 etherAmount) public view returns(uint256) {
        uint256 etherPrice = getPrice();
        uint256 etherAmountInUsd = (etherAmount * etherPrice) / 1000000000000000000;
        return etherAmountInUsd;
    }

}


    // Tuples in solidity:
    // (x, y) = (1, 2)
    // return x; => 1