// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DutchAuction is Ownable, ERC721 {

    uint256 public constant COLLECTION_SIZE = 10000; // NFT总数

    uint256 public constant AUCTION_START_PRICE = 1 ether;
    uint256 public constant AUCTION_END_PRICE = 0.1 ether;
    uint256 public constant AUCTION_TIME = 10 minutes;
    uint256 public constant AUCTION_DROP_INTERVAL = 1 minutes;
    uint256 public constant AUCTION_DROP_PER_STEP = ( AUCTION_START_PRICE - AUCTION_END_PRICE ) / ( AUCTION_TIME / AUCTION_DROP_INTERVAL );

    uint256 public auctionStartTime;
    string private _baseTokenURL;
    uint256[] private _allTokens;

    constructor() Ownable(msg.sender) ERC721("WTF Dutch Auction","WTF Dutch Auction"){
        auctionStartTime = block.timestamp;
    }


    function totalSupply() public view returns(uint256) {
        return _allTokens.length;
    }

    function _addTokenToAllTokensEnumeration(uint256 _idx) private {
        _allTokens.push(_idx);
    }

    // 根据拍卖时间决定nft价格并收取eth铸造
    function auctionMint(uint256 quantity) external payable {
        uint256 _saleStartTime = uint256(auctionStartTime); // 建立local变量，减少gas花费

        // 检查时间
        require( _saleStartTime != 0 && _saleStartTime < block.timestamp , "auction not started" );
        // 检查总数
        require( totalSupply() + quantity < COLLECTION_SIZE , "out of number allowed" );

        uint256 totalPrice = getAuctionPrice() * quantity;
        require( totalPrice <= msg.value , "need more eth to send" );

        for( uint256 i ; i < quantity  ; i++ ){
            uint256 mintIndex = totalSupply();
            _mint(msg.sender,mintIndex);
            _addTokenToAllTokensEnumeration(mintIndex);
        }

        if( msg.value > totalPrice  ){
            payable(msg.sender).transfer( msg.value - totalPrice );
        }

    } 

    // 获取拍卖实时价格
    function getAuctionPrice()
        public
        view
        returns (uint256)
    {
        // 减价逻辑
        if( block.timestamp < auctionStartTime ){
            return AUCTION_START_PRICE;
        }
        else if( block.timestamp - auctionStartTime > AUCTION_TIME ){
            return AUCTION_END_PRICE;
        } else {
            uint256 step = (block.timestamp - auctionStartTime) / AUCTION_DROP_INTERVAL;
            return AUCTION_START_PRICE - step * AUCTION_DROP_PER_STEP;
        }
    }
    
    
    function setAuctionStartTime( uint32 timestamp ) external onlyOwner {
        auctionStartTime = timestamp;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURL;
    }

    function setBaseUrl( string calldata baseURI ) external onlyOwner {
        _baseTokenURL = baseURI;
    }

}