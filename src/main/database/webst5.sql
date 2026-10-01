CREATE DATABASE IF NOT EXISTS webst5
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE webst5;

CREATE TABLE IF NOT EXISTS UserRoles (
    roleId INT NOT NULL AUTO_INCREMENT,
    roleName VARCHAR(50),
    PRIMARY KEY (roleId)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Seller (
    sellerId INT NOT NULL AUTO_INCREMENT,
    sellername VARCHAR(50),
    images VARCHAR(500),
    status INT,
    PRIMARY KEY (sellerId)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Category (
    categoryId INT NOT NULL AUTO_INCREMENT,
    categoryName VARCHAR(200),
    images VARCHAR(500),
    status INT,
    PRIMARY KEY (categoryId)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Users (
    userId INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50),
    email VARCHAR(100),
    fullname VARCHAR(50),
    password VARCHAR(50),
    images VARCHAR(500),
    phone VARCHAR(20),
    status INT,
    code VARCHAR(50),
    roleId INT,
    sellerId INT,
    PRIMARY KEY (userId),
    CONSTRAINT FK_Users_UserRoles FOREIGN KEY (roleId) REFERENCES UserRoles(roleId),
    CONSTRAINT FK_Users_Seller FOREIGN KEY (sellerId) REFERENCES Seller(sellerId)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Product (
    productId INT NOT NULL AUTO_INCREMENT,
    productName VARCHAR(200),
    productCode BIGINT,
    categoryId INT,
    description VARCHAR(500),
    price FLOAT,
    amount INT,
    stock INT,
    images VARCHAR(500),
    wishlist INT,
    status INT,
    createDate DATE,
    sellerId INT,
    PRIMARY KEY (productId),
    CONSTRAINT FK_Product_Category FOREIGN KEY (categoryId) REFERENCES Category(categoryId),
    CONSTRAINT FK_Product_Seller FOREIGN KEY (sellerId) REFERENCES Seller(sellerId)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Cart (
    cartId VARCHAR(50) NOT NULL,
    userId INT,
    buyDate DATETIME,
    status INT,
    PRIMARY KEY (cartId),
    CONSTRAINT FK_Cart_Users FOREIGN KEY (userId) REFERENCES Users(userId)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS CartItem (
    cartItemId VARCHAR(50) NOT NULL,
    quantity INT,
    unitPrice FLOAT,
    productId INT,
    cartId VARCHAR(50),
    PRIMARY KEY (cartItemId),
    CONSTRAINT FK_CartItem_Product FOREIGN KEY (productId) REFERENCES Product(productId),
    CONSTRAINT FK_CartItem_Cart FOREIGN KEY (cartId) REFERENCES Cart(cartId)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Orders (
    orderId VARCHAR(36) NOT NULL,
    userId INT NOT NULL,
    receiverName VARCHAR(100) NOT NULL,
    receiverPhone VARCHAR(20) NOT NULL,
    shippingAddress VARCHAR(500) NOT NULL,
    orderDate DATETIME NOT NULL,
    totalAmount DECIMAL(12, 2) NOT NULL,
    paymentMethod VARCHAR(20) NOT NULL,
    paymentStatus VARCHAR(20) NOT NULL,
    status VARCHAR(30) NOT NULL,
    PRIMARY KEY (orderId),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (userId) REFERENCES Users(userId)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS OrderItems (
    orderItemId VARCHAR(36) NOT NULL,
    orderId VARCHAR(36) NOT NULL,
    productId INT,
    productName VARCHAR(200) NOT NULL,
    unitPrice DECIMAL(12, 2) NOT NULL,
    quantity INT NOT NULL,
    lineTotal DECIMAL(12, 2) NOT NULL,
    PRIMARY KEY (orderItemId),
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (orderId) REFERENCES Orders(orderId),
    CONSTRAINT FK_OrderItems_Product FOREIGN KEY (productId) REFERENCES Product(productId)
) ENGINE=InnoDB;
