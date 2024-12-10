// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ECommerce {
    struct Product {
        uint256 id;
        string name;
        uint256 price;
        address seller;
        bool isAvailable;
    }

    struct Order {
        uint256 id;
        uint256 productId;
        address buyer;
        uint256 quantity;
        bool isShipped;
    }

    uint256 public productCount;
    uint256 public orderCount;

    mapping(uint256 => Product) public products;
    mapping(uint256 => Order) public orders;
    mapping(address => bool) public seller;

    event productChanged (uint256 newProductCount);
    event orderChanged (uint256 newOrderCount);

    constructor() {
        // The contract deployer is the initial seller
        seller[msg.sender] = true;
    }

    function addProduct(string memory _name, uint256 _price) public {
        require(seller[msg.sender], "Only seller can add products");
        productCount++;
        products[productCount] = Product(productCount, _name, _price, msg.sender, true);

        emit productChanged(productCount);
    }

    function removeProduct(uint _productId) public {
        require(seller[msg.sender], "Only seller can remove products");
        require(products[_productId].isAvailable, "Product is already removed");
        products[_productId].isAvailable = false;

        emit productChanged(productCount);
    }

    function createOrder(uint _productId, uint _quantity) public payable {
        Product memory product = products[_productId];
        require(product.isAvailable, "Product not available");
        require(msg.value == product.price * _quantity, "Incorrect payment");

        orderCount++;
        orders[orderCount] = Order(orderCount, _productId, msg.sender, _quantity, false);

        // Transfer funds to the seller
        payable(product.seller).transfer(msg.value);

        emit orderChanged(orderCount);
    }

    function shipOrder(uint _orderId) public {
        Order storage order = orders[_orderId];
        require(seller[msg.sender], "Only seller can ship orders");
        require(!order.isShipped, "Order already shipped");

        order.isShipped = true;
    }

}
