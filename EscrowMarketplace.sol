/**
 * @title EscrowMarketplace
 * @dev Handles escrow logic for marketplace transactions
 * @custom:dev-run-script scripts/deploy_with_ethers.ts
 */
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;


contract EscrowMarketplace {
    // Represents a product listed by a seller
    struct Item {
        uint256 price;
        address payable seller;
        address buyer;
        bool isSold;
        bool isConfirmed;
    }

    // Store items mapped by unique name
    mapping(string => Item) private listings;

    // Event logs for transparency
    event ItemListed(string itemName, uint256 price, address seller);
    event ItemPurchased(string itemName, address buyer);
    event ItemConfirmed(string itemName);

    /// @notice Seller lists an item with a name and price
    function listItem(string calldata itemName, uint256 price) external {
        require(bytes(itemName).length > 0, "Item name required");
        require(price > 0, "Price must be greater than zero");
        require(listings[itemName].seller == address(0), "Item already listed");

        listings[itemName] = Item({
            price: price,
            seller: payable(msg.sender),
            buyer: address(0),
            isSold: false,
            isConfirmed: false
        });

        emit ItemListed(itemName, price, msg.sender);
    }

    /// @notice Buyer sends payment to purchase item
    function buyItem(string calldata itemName) external payable {
        Item storage item = listings[itemName];
        require(item.seller != address(0), "Item not found");
        require(!item.isSold, "Item already sold");
        require(msg.value == item.price, "Incorrect payment amount");

        item.buyer = msg.sender;
        item.isSold = true;

        emit ItemPurchased(itemName, msg.sender);
    }

    /// @notice Buyer confirms receipt and releases funds to seller
    function confirmItem(string calldata itemName) external {
        Item storage item = listings[itemName];
        require(msg.sender == item.buyer, "Only buyer can confirm");
        require(!item.isConfirmed, "Already confirmed");

        item.isConfirmed = true;
        item.seller.transfer(item.price);

        emit ItemConfirmed(itemName);
    }

    /// @notice View item details
    function getItem(string calldata itemName) external view returns (
        uint256 price,
        address seller,
        address buyer,
        bool isSold,
        bool isConfirmed
    ) {
        Item memory item = listings[itemName];
        return (
            item.price,
            item.seller,
            item.buyer,
            item.isSold,
            item.isConfirmed
        );
    }
}
