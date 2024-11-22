// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ECommerce {
    struct Product {
        uint id;
        string name;
        uint price;
        address seller;
        bool isAvailable;
    }

    struct Order {
        uint id;
        uint productId;
        address buyer;
        uint quantity;
        bool isShipped;
    }

    uint public productCount;
    uint public orderCount;

    mapping(uint => Product) public products;
    mapping(uint => Order) public orders;
    mapping(address => bool) public admins;

    constructor() {
        // The contract deployer is the initial admin
        admins[msg.sender] = true;
    }

        function addProduct(string memory _name, uint _price) public {
        require(admins[msg.sender], "Only admins can add products");
        productCount++;
        products[productCount] = Product(productCount, _name, _price, msg.sender, true);
    }

    function removeProduct(uint _productId) public {
        require(admins[msg.sender], "Only admins can remove products");
        require(products[_productId].isAvailable, "Product is already removed");
        products[_productId].isAvailable = false;
    }

        function createOrder(uint _productId, uint _quantity) public payable {
        Product memory product = products[_productId];
        require(product.isAvailable, "Product not available");
        require(msg.value == product.price * _quantity, "Incorrect payment");

        orderCount++;
        orders[orderCount] = Order(orderCount, _productId, msg.sender, _quantity, false);

        // Transfer funds to the seller
        payable(product.seller).transfer(msg.value);
    }

    function shipOrder(uint _orderId) public {
        Order storage order = orders[_orderId];
        require(admins[msg.sender], "Only admins can ship orders");
        require(!order.isShipped, "Order already shipped");

        order.isShipped = true;
    }

}
