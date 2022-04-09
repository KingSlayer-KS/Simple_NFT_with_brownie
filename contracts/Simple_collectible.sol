// SPDX-Liscence-Identifier: MIT

pragma solidity ^0.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Simple_collectible is
    ERC721 //inhereting the 721 to our contract  \
{
    uint256 public tokenCounter;

    constructor() public ERC721("King_slayer", "K$") {
        tokenCounter = 0; //Name        //Symbol
    } //initalizing t

    function createcollectible(string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newTokenId = tokenCounter; //this will be iterated every time we mint a new token and anew id will be created
        _safeMint(msg.sender, newTokenId); //its in the openzeplin
        //to check update owners of the token balance of collector and to also check if same token id id minted or not
        _setTokenURI(newTokenId, tokenURI);
        tokenCounter = tokenCounter + 1; //incrementin the counter every time a new one is minted
        _setTokenURI(newTokenId, tokenURI);
        return newTokenId;
    }
}
