-- security for password using SHA2 (SECURED HASH ALGORITHM) 2 function method

INSERT INTO user (user_name, email, password, role,mobile_number) VALUES
('Akilesh', 'akileshga@gmail.com', SHA2('akilesh-2', 256), 'admin',6382503516);

INSERT INTO user (user_name, email, password, role,mobile_number) VALUES
('Nivetha', 'nivethav@gmail.com',SHA2('nivetha-38',256), 'farmer' ,9876903514),
('Kabhilan', 'kabhilanvs@gmail.com', SHA2('kabhilan-21', 256), 'farmer',9867453780),
('Rithanya', 'rithanya@gmail.com', SHA2('rithanya-47', 256), 'farmer',7845890825);

INSERT INTO user (user_name, email, password, role,mobile_number) VALUES
('Naveen', 'naveen@gmail.com', SHA2('naveen-36', 256), 'consumer',9453890834),
('Mohan', 'mohan@gmail.com', SHA2('mohan-61', 256), 'consumer',8079056782),
('Kishore', 'kishore@gmail.com', SHA2('kishore-26', 256), 'consumer',7345890834),
('VarshaSri', 'varshasri@gmail.com', SHA2('varshasri-60', 256), 'consumer',8090976543);

set sql_safe_updates = 1;

-- Display Full user table
select * from user;

-- Display hashed Password
select password AS SHA2_password from user; 

-- Display user_id - user_name - email - role - mobile_number 
select user_id,user_name,email,role,mobile_number from users;

-- Display user_id - user_name - email - role - mobile_number - created_by - created_at - updated_at 
select user_id,user_name,email,role,mobile_number,created_by,created_at,updated_at from user;

-- truncate user table
truncate user;

-- dop user table 
drop table user;

-- Grouping according to role
SELECT role, GROUP_CONCAT(user_name) AS user_names FROM user GROUP BY role;

-- Query to display count of roles (descending order)
SELECT role, COUNT(user_id) AS users_count FROM user GROUP BY role ORDER BY user_count DESC;

-- retrive specific record by email and mobile number
SELECT * FROM user WHERE email LIKE "a%" AND mobile_number LIKE "63%"; 

-- retrive particular records by date 
SELECT user_name, email FROM user 
WHERE created_at BETWEEN '2023-01-01' AND '2023-12-31';

-- user table 
CREATE TABLE user (
    user_id INT NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password CHAR(64) NOT NULL,
    role VARCHAR(10) NOT NULL,
    mobile_number VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(50) NOT NULL DEFAULT 'admin',
    updated_by VARCHAR(50) NOT NULL DEFAULT 'admin',
    PRIMARY KEY (user_id),
    CHECK (mobile_number REGEXP '^[0-9]{10}$')
);

-- MOdify Date and District
ALTER TABLE user
ADD COLUMN date DATE NOT NULL,
ADD COLUMN district VARCHAR(50) NOT NULL;



CREATE TABLE user (
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

-- Joining tables
SELECT u.user_id,u.user_name, u.email, p.product_name, p.unit FROM user u
JOIN products p ON u.user_id = p.user_id;

create table products
(
    product_id VARCHAR(255) NOT NULL,
    user_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    unit INT NOT NULL CHECK (UNIT>0),
    created_by varchar(255) DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(255),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id,product_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
	UNIQUE (product_id)
);

CREATE TABLE products (
    product_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    unit INT NOT NULL CHECK (unit > 0),
    created_by VARCHAR(255) DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(255) DEFAULT 'farmer',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    UNIQUE (product_id)
);

-- Inserting sample products
INSERT INTO products (user_id, product_name, unit) VALUES
(2, 'Tomato', 10),
(2, 'potato', 5),
(3, 'Brinjal', 20),
(3, 'Onion', 15),
(2, 'Carrot', 25);

INSERT INTO products(user_id,product_name,unit) VALUES
(9, 'Grapes', 2),
(9, 'Cabbage', 5),
(2, 'Orange', 15);

use nexus_df;

-- Retrive all from products
SELECT * FROM user;
SELECT * FROM products;

SELECT u.user_name , u.email , u.mobile_number , p.product_name , p.unit
FROM user AS u
JOIN products AS p 
ON u.user_id = p.user_id;

SELECT u.user_name, p.unit 
FROM user AS u
INNER JOIN products AS p 
ON u.user_id = p.user_id
GROUP BY u.user_name
HAVING count(p.unit) > 10 
ORDER BY p.unit;

SELECT u.user_name, COUNT(p.unit) AS unit_count 
FROM user AS u
INNER JOIN products AS p ON u.user_id = p.user_id
GROUP BY u.user_name
HAVING COUNT(p.unit) > 2 
ORDER BY unit_count;

CREATE TABLE orders (
	user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price INT NOT NULL CHECK (price > 0),
    status VARCHAR(255) NOT NULL,
    created_by VARCHAR(255) DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(255) DEFAULT 'admin',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

use nexus;

select * from orders;

INSERT INTO orders (user_id,product_id,quantity,price,status) VALUES (3,3,5,75,'pending');