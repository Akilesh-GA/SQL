CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password CHAR(64) NOT NULL,
    role VARCHAR(10) NOT NULL,
    dob DATE NOT NULL,
    mobile_number VARCHAR(10) NOT NULL,
    district VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(50) NOT NULL DEFAULT 'admin',
    updated_by VARCHAR(50) NOT NULL DEFAULT 'admin',
    PRIMARY KEY (user_id),
    CHECK (mobile_number REGEXP '^[0-9]{10}$')
);

INSERT INTO users (user_name, email, password, role, dob, mobile_number, district, created_by, updated_by) VALUES 
('Akilesh', 'akileshga@gmail.com', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', 'admin', '2006-06-14', '6382503510', 'Tiruppur', 'admin', 'admin'),
('Kabhilan', 'kabhilanvs@gmail.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'farmer', '2005-11-27', '9078563467', 'Ganapathipalayam', 'admin', 'admin'),
('Mohan', 'mohan@gmail.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'consumer', '2006-07-09', '9870654321', 'Bhavani', 'admin', 'admin');

-- Display Full user table
select * from users;

use nexus;

-- Display hashed Password
select password AS SHA2_password from users; 

-- Display user_id - user_name - email - role - mobile_number 
select user_id,user_name,email,role,mobile_number from users;

-- Display user_id - user_name - email - role - mobile_number - created_by - created_at - updated_at 
select user_id,user_name,email,role,mobile_number,dob,district from users;

drop table products;

truncate products;

-- Products table
CREATE TABLE products (
    product_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    unit INT NOT NULL CHECK (unit > 0),
    cost DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    status ENUM('available', 'out of stock', 'available soon') DEFAULT 'available',
    mobile_number VARCHAR(10) NOT NULL,
    created_by VARCHAR(255) DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(255) DEFAULT 'farmer',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    UNIQUE (product_id),
    INDEX (product_name),
    CHECK (mobile_number REGEXP "^[0-9]{10}")
);

INSERT INTO products (user_id, product_name, unit, cost, stock_quantity, status,mobile_number, created_by, updated_by) 
VALUES 
(1, 'Tomatoes', 50, 2.99, 50, 'available','9078563490', 'admin', 'farmer'),
(2, 'Carrots', 30, 1.50, 0, 'out of stock','7856387490', 'admin', 'farmer'),
(3, 'Apple', 20, 1.75, 5, 'available soon','6390563490', 'admin', 'farmer');


delete from products where product_id = 3;

SELECT * FROM products;

-- Table to store images of products
CREATE TABLE images (
    image_id INT NOT NULL AUTO_INCREMENT,
    image_name VARCHAR(255) NOT NULL,
    image_data LONGBLOB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (image_id)
);

select * from images;
