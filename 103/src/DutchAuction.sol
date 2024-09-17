// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.21;

// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// contract DutchAuction is Ownable, ERC721 {

//     uint256 public constant AUCTION_START_PRICE = 1 ether;
//     uint256 public constant AUCTION_END_PRICE = 0.1 ether;
//     uint256 public constant AUCTION_TIME = 10 minutes;
//     uint256 public constant AUCTION_DROP_INTERVAL = 1 minutes;
//     uint256 public constant AUCTION_DROP_PER_STEP = ( AUCTION_START_PRICE - AUCTION_END_PRICE ) / ( AUCTION_TIME / AUCTION_DROP_INTERVAL );

//     uint256 public auctionStartTime;
//     string private _baseTokenURL;
//     uint256[] private _allTokens;

//     constructor() Ownable(msg.sender) ERC721("WTF Dutch Auction","WTF Dutch Auction"){
//         auctionStartTime = block.timestamp;
//     }


//         // 获取拍卖实时价格
//     function getAuctionPrice()
//         public
//         view
//         returns (uint256)
//     {


//     }
    
    
//     function setAuctionStartTime( uint32 timestamp ) external onlyOwner {
//         auctionStartTime = timestamp;
//     }

//     function _baseURI() internal view virtual override returns (string memory) {
//         return _baseTokenURL;
//     }

//     function setBaseUrl( string calldata baseURI ) external onlyOwner {
//         _baseTokenURL = baseURI;
//     }

// }