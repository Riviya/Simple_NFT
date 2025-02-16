// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    mapping(uint256 => string) public samuraiToTokenURI;

    function run() external {
        //samurai types
        samuraiToTokenURI[
            1
        ] = "https://ipfs.io/ipfs/bafkreibylhqriz6ysso37jpignahqf2bamjpz5iwbhmgspqxv4e6bbbeoy";
        samuraiToTokenURI[
            2
        ] = "https://ipfs.io/ipfs/bafkreifl675pchmo6bkhwr6lp4i6ey4mm3j7gbodmazsw4vbc4bk6odzpu";
        samuraiToTokenURI[
            3
        ] = "https://ipfs.io/ipfs/bafkreigpnuxuy7wg6g2xc5y3ymmxvqshmaadhpswgskl454rogzpwaruii";

        uint256 num = vm.envUint("SAMURAI_ID");

        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );

        mintUsingContract(mostRecentlyDeployed, num);
    }

    function mintUsingContract(address contractAddress, uint256 num) internal {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(samuraiToTokenURI[num]);
        vm.stopBroadcast();
    }
}
