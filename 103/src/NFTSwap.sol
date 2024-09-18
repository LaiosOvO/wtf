// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract NFTSwap is IERC721Receiver {

    event List(
        address indexed seller,
        address indexed nftAddr,
        uint256 indexed tokenId,
        uint256 price
    );
    event Purchase(
        address indexed buyer,
        address indexed nftAddr,
        uint256 indexed tokenId,
        uint256 price
    );
    event Revoke(
        address indexed seller,
        address indexed nftAddr,
        uint256 indexed tokenId
    );
    event Update(
        address indexed seller,
        address indexed nftAddr,
        uint256 indexed tokenId,
        uint256 newPrice
    );

    struct Order {
        address owner;
        uint256 price;
    }

    mapping(address => mapping(uint256 => Order)) public nftList;

    fallback() external payable {}

    function list( address _nftAddress , uint256 _tokenId , uint256 _price ) public {
        IERC721 _nft = IERC721(_nftAddress);

        require(_nft.getApproved(_tokenId) == address(this),"need approval");
        require(_price > 0, "price need bigger than 0");

        Order storage _order = nftList[_nftAddress][_tokenId];
        _order.owner = msg.sender;
        _order.price = _price;

        // 
        _nft.safeTransferFrom(msg.sender, address(this), _tokenId);

        emit List(msg.sender , address(this), _tokenId , _price);
    }


    function purchase(address _nftAddr,uint256 _tokenId) public payable {
        
        Order storage _order = nftList[_nftAddr][_tokenId];
        require(_order.price > 0 , "invalid price");
        require( _order.price <= msg.value , "need send more eth" );

        IERC721 _nft = IERC721(_nftAddr);
        require( _nft.ownerOf(_tokenId) == address(this) , "invalid nft request" );

        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        // 
        payable(_order.owner).transfer(_order.price);
        payable(msg.sender).tranfer(msg.value - _order.price);

        delete nftList[_nftAddr][_tokenId];

        emit Purchase(msg.sender , _nftAddr , _tokenId, _order.price);
    }
    
    function revoke(address _nftAddr,uint256 _tokenId) public {
        Order storage _order = nftList[_nftAddr][_tokenId];
                require(_order.owner == msg.sender, "Not Owner"); // 必须由持有人发起
        // 声明IERC721接口合约变量
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中

        // 将NFT转给卖家
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        delete nftList[_nftAddr][_tokenId]; // 删除order

        // 释放Revoke事件
        emit Revoke(msg.sender, _nftAddr, _tokenId);

    }


    // 调整价格: 卖家调整挂单价格
    function update(
        address _nftAddr,
        uint256 _tokenId,
        uint256 _newPrice
    ) public {
        require(_newPrice > 0, "Invalid Price"); // NFT价格大于0
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得Order
        require(_order.owner == msg.sender, "Not Owner"); // 必须由持有人发起
        // 声明IERC721接口合约变量
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中

        // 调整NFT价格
        _order.price = _newPrice;

        // 释放Update事件
        emit Update(msg.sender, _nftAddr, _tokenId, _newPrice);
    }

    // 实现{IERC721Receiver}的onERC721Received，能够接收ERC721代币
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external override returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

}