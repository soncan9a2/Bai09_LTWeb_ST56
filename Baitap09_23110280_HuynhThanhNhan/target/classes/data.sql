IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='categories' AND xtype='U')
CREATE TABLE categories (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    images NVARCHAR(500)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='users' AND xtype='U')
CREATE TABLE users (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    fullname NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    phone NVARCHAR(20)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='products' AND xtype='U')
CREATE TABLE products (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(500) NOT NULL,
    quantity INT NOT NULL,
    description NTEXT,
    price DECIMAL(10,2) NOT NULL,
    user_id BIGINT,
    category_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='category_user' AND xtype='U')
CREATE TABLE category_user (
    category_id BIGINT,
    user_id BIGINT,
    PRIMARY KEY (category_id, user_id),
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

IF NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Electronics')
INSERT INTO categories (name, images) VALUES ('Electronics', 'electronics.jpg');

IF NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Clothing')
INSERT INTO categories (name, images) VALUES ('Clothing', 'clothing.jpg');

IF NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Books')
INSERT INTO categories (name, images) VALUES ('Books', 'books.jpg');

IF NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Home & Garden')
INSERT INTO categories (name, images) VALUES ('Home & Garden', 'home_garden.jpg');

IF NOT EXISTS (SELECT 1 FROM categories WHERE name = 'Sports')
INSERT INTO categories (name, images) VALUES ('Sports', 'sports.jpg');

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'an.nguyen@email.com')
INSERT INTO users (fullname, email, password, phone) VALUES 
('Nguyễn Văn An', 'an.nguyen@email.com', 'password123', '0123456789');

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'binh.tran@email.com')
INSERT INTO users (fullname, email, password, phone) VALUES 
('Trần Thị Bình', 'binh.tran@email.com', 'password123', '0987654321');

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'cuong.le@email.com')
INSERT INTO users (fullname, email, password, phone) VALUES 
('Lê Văn Cường', 'cuong.le@email.com', 'password123', '0369852147');

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'dung.pham@email.com')
INSERT INTO users (fullname, email, password, phone) VALUES 
('Phạm Thị Dung', 'dung.pham@email.com', 'password123', '0741852963');

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'em.hoang@email.com')
INSERT INTO users (fullname, email, password, phone) VALUES 
('Hoàng Văn Em', 'em.hoang@email.com', 'password123', '0527419638');

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'iPhone 15 Pro')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('iPhone 15 Pro', 50, 'Latest iPhone with advanced features', 999.99, 1, 1);

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'Samsung Galaxy S24')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('Samsung Galaxy S24', 30, 'Premium Android smartphone', 899.99, 2, 1);

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'MacBook Pro M3')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('MacBook Pro M3', 20, 'High-performance laptop for professionals', 1999.99, 1, 1);

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'Nike Air Max')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('Nike Air Max', 100, 'Comfortable running shoes', 129.99, 3, 5);

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'Adidas T-Shirt')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('Adidas T-Shirt', 200, 'Comfortable cotton t-shirt', 29.99, 4, 2);

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'Java Programming Book')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('Java Programming Book', 75, 'Complete guide to Java programming', 49.99, 5, 3);

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'Spring Boot Guide')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('Spring Boot Guide', 60, 'Learn Spring Boot framework', 39.99, 1, 3);

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'Garden Tools Set')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('Garden Tools Set', 40, 'Complete set of gardening tools', 79.99, 2, 4);

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'Wireless Headphones')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('Wireless Headphones', 80, 'High-quality wireless audio', 199.99, 3, 1);

IF NOT EXISTS (SELECT 1 FROM products WHERE title = 'Yoga Mat')
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
('Yoga Mat', 120, 'Non-slip yoga mat for exercise', 34.99, 4, 5);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 1 AND user_id = 1)
INSERT INTO category_user (category_id, user_id) VALUES (1, 1);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 1 AND user_id = 2)
INSERT INTO category_user (category_id, user_id) VALUES (1, 2);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 1 AND user_id = 3)
INSERT INTO category_user (category_id, user_id) VALUES (1, 3);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 2 AND user_id = 2)
INSERT INTO category_user (category_id, user_id) VALUES (2, 2);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 2 AND user_id = 4)
INSERT INTO category_user (category_id, user_id) VALUES (2, 4);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 3 AND user_id = 1)
INSERT INTO category_user (category_id, user_id) VALUES (3, 1);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 3 AND user_id = 5)
INSERT INTO category_user (category_id, user_id) VALUES (3, 5);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 4 AND user_id = 2)
INSERT INTO category_user (category_id, user_id) VALUES (4, 2);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 4 AND user_id = 3)
INSERT INTO category_user (category_id, user_id) VALUES (4, 3);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 5 AND user_id = 3)
INSERT INTO category_user (category_id, user_id) VALUES (5, 3);

IF NOT EXISTS (SELECT 1 FROM category_user WHERE category_id = 5 AND user_id = 4)
INSERT INTO category_user (category_id, user_id) VALUES (5, 4);
