// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployNft} from "script/Deploy.s.sol";

contract TestNft is Test {
    DeployNft deployer;
    BasicNft basicNft;
    address public USER = makeAddr("USER");
    string public pug =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        basicNft = new BasicNft();
        deployer = new DeployNft();
    }

    function testSameName() public view {
        string memory expected = "Dogie";
        string memory actual = basicNft.name();
        assertEq(actual, expected);
    }

    function testMintNftAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(pug);

        assertEq(basicNft.tokenURI(0), pug);
        assertEq(basicNft.balanceOf(USER), 1);
    }
}
