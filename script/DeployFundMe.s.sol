// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract DeployFundMe is Script {
    MockV3Aggregator mockPriceFeed;
    FundMe fundMe;

    function run() public returns (FundMe) {
        vm.startBroadcast();
        mockPriceFeed = new MockV3Aggregator(8, 2000e8);
        fundMe = new FundMe(address(mockPriceFeed));
        vm.stopBroadcast();
        return fundMe;
    }
}
