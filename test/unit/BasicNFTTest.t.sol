// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;
import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNFT.s.sol";
import {BasicNft} from "../../src/BasicNFT.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // remember string is an array of bytes
        // so we can do a loop (For) through the array and compare them.
        // or we can do abi.encode and pack the entire array and take the hash of that(hash is a function that returns a fixed sized unique string that identifies an object)
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        ); // this is a bit advanced here
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);
        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
