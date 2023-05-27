pragma solidity ^0.8.4;

import "./ERC721A.sol";
import "./OpenZeppelin/Ownable.sol";
import "./OpenZeppelin/ERC20.sol";

contract underscore_ {

    mapping(address => ERC721A[]) public listings;
    mapping(address => uint256) public rating;
    mapping(address => uint256) public numOfReviews;

    event NewListing(address creator, string name, string symbol, string url, ERC20 assetRequested, uint256 pricePerItem, uint256 quantity);
    
    function createListing(
        string memory name, 
        string memory symbol,
        string memory url,
        ERC20 assetRequested,
        uint256 pricePerItem,
        uint256 quantity 
    ) public {
        ERC721A newListing = new ERC721A(name, symbol, url, msg.sender);
        listings[msg.sender].push(newListing); 
        emit NewListing(msg.sender, name, symbol, url, assetRequested, pricePerItem, quantity);
    }

    function creatorMint(uint256 quantity, ERC721A listing) external payable {
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        require(listing._creator() == msg.sender);
        listing._mint(msg.sender, quantity);
    }
}
