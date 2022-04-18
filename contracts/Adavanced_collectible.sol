// SPDX-Liscence-Identifier: MIT

pragma solidity ^0.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

contract Adavanced_collectible is ERC721, VRFConsumerBase {
    uint256 public tokencounter;
    bytes32 public keyhash;
    uint256 public fee;
    enum Breed {
        kutta,
        mahan_hutta,
        sundar_kutta
    }
    mapping(uint256 => Breed) public tokenIdToBreed;
    mapping(bytes32 => address) public requestIdToSender;
    event requestedCollectible(bytes32 indexed requestid, address requester);
    event breedAssigned(uint256 indexed tokenid, Breed breed);

    constructor(
        address _vrfCoordinator,
        address _linkToken,
        bytes32 _keyhash,
        uint256 _fee
    )
        public
        VRFConsumerBase(_vrfCoordinator, _linkToken)
        ERC721("Kingslayer", "K$")
    {
        tokencounter = 0;
        keyhash = _keyhash;
        fee = _fee;
    }

    function create_coll(string memory tokenURI) public returns (bytes32) {
        bytes32 requestid = requestRandomness(keyhash, fee);
        requestIdToSender[requestid] = msg.sender;
        emit requestedCollectible(requestid, msg.sender);
    }

    function fulfillRandomness(bytes32 requestid, uint256 randomNumber)
        internal
        override
    {
        Breed breed = Breed(randomNumber % 3);
        uint256 newTokenId = tokencounter; //grabing the token id
        tokenIdToBreed[newTokenId] = breed; //setting new token it to breed
        emit breedAssigned(newTokenId, breed);
        address owner = requestIdToSender[requestid];
        _safeMint(owner, newTokenId);
        tokencounter = tokencounter + 1;
    }

    function setTokenURI(uint256 tokenid, string memory _tokenURI) public {
        require(
            _isApprovedOrOwner(_msgSender(), tokenid),
            "Caller nahi malik hai yan approver nahi hai"
        ); //chesks the owner of the ERC721 specifie dwith the tokenid
        _setTokenURI(tokenid, _tokenURI);
    }
}
