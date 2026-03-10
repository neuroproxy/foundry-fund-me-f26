// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {FundMe} from "../../src/FundMe.sol";
import {MockV3Aggregator} from "../mocks/MockV3Aggregator.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract IntegrationsTest is Test {
    FundMe fundMe;
    FundFundMe funFundMe;
    DeployFundMe deployFundMe;
    MockV3Aggregator mockPriceFeed;
    address USER = makeAddr("user");

    uint256 constant SEND_VALUE = 0.3 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFund() public {
        funFundMe = new FundFundMe();
        funFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
