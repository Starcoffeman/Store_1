DROP TABLE IF EXISTS article_reactions;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS shopping_cart;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS user_favorites;
DROP TABLE IF EXISTS product_images;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS brands;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

CREATE TABLE roles (
                     id BIGINT AUTO_INCREMENT PRIMARY KEY,
                     name VARCHAR(100) NOT NULL
);

CREATE TABLE users (
                     id BIGINT AUTO_INCREMENT PRIMARY KEY,
                     username VARCHAR(50) NOT NULL UNIQUE,
                     name VARCHAR(100) NOT NULL,
                     surname VARCHAR(100) NOT NULL,
                     password VARCHAR(100) NOT NULL,
                     email VARCHAR(100) NOT NULL UNIQUE,
                     phone VARCHAR(20) NOT NULL,
                     registration_date DATE,
                     role_id BIGINT,
                     address VARCHAR(255),
                     FOREIGN KEY (role_id) REFERENCES roles (id)
);

CREATE TABLE categories (
                          id BIGINT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE brands (
                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                      name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(100) NOT NULL,
                        description TEXT,
                        category_id BIGINT NOT NULL,
                        brand_id BIGINT NOT NULL,
                        price DECIMAL(10, 2) NOT NULL,
                        old_price DECIMAL(10, 2),
                        file_url VARCHAR(500),
                        processor VARCHAR(200),
                        ram VARCHAR(50),
                        storage VARCHAR(100),
                        display VARCHAR(200),
                        battery VARCHAR(100),
                        color VARCHAR(50),
                        weight VARCHAR(50),
                        warranty VARCHAR(50),
                        country VARCHAR(100),
                        additional_info TEXT,
                        in_stock BOOLEAN DEFAULT TRUE,
                        stock_quantity INT DEFAULT 0,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE,
                        FOREIGN KEY (brand_id) REFERENCES brands (id) ON DELETE CASCADE
);

CREATE TABLE product_images (
                              id BIGINT AUTO_INCREMENT PRIMARY KEY,
                              product_id BIGINT NOT NULL,
                              image_url VARCHAR(500) NOT NULL,
                              is_primary BOOLEAN DEFAULT FALSE,
                              display_order INT DEFAULT 0,
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TABLE user_favorites (
                              id BIGINT AUTO_INCREMENT PRIMARY KEY,
                              user_id BIGINT NOT NULL,
                              product_id BIGINT NOT NULL,
                              added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              UNIQUE (user_id, product_id),
                              FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
                              FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TABLE orders (
                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                      user_id BIGINT NOT NULL,
                      order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      status VARCHAR(20) NOT NULL,
                      total_price DECIMAL(10, 2) NOT NULL,
                      address VARCHAR(500) NOT NULL,
                      delivery_method VARCHAR(30) NOT NULL,
                      payment_method VARCHAR(40) NOT NULL,
                      FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE order_items (
                           id BIGINT AUTO_INCREMENT PRIMARY KEY,
                           order_id BIGINT NOT NULL,
                           product_id BIGINT NOT NULL,
                           quantity INT NOT NULL,
                           price DECIMAL(10, 2) NOT NULL,
                           FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
                           FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TABLE payments (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        order_id BIGINT NOT NULL,
                        user_id BIGINT NOT NULL,
                        amount DECIMAL(10, 2) NOT NULL,
                        payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        status VARCHAR(20) NOT NULL,
                        FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
                        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE reviews (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       user_id BIGINT NOT NULL,
                       product_id BIGINT NOT NULL,
                       rating INT CHECK (rating >= 1 AND rating <= 5),
                       comment TEXT,
                       review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
                       FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TABLE shopping_cart (
                             id BIGINT AUTO_INCREMENT PRIMARY KEY,
                             user_id BIGINT NOT NULL,
                             product_id BIGINT NOT NULL,
                             quantity INT NOT NULL,
                             FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
                             FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TABLE articles (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        title VARCHAR(200) NOT NULL,
                        slug VARCHAR(200) NOT NULL UNIQUE,
                        content TEXT NOT NULL,
                        excerpt VARCHAR(500),
                        image_url VARCHAR(500),
                        article_type VARCHAR(20) DEFAULT 'NEWS',
                        status VARCHAR(20) DEFAULT 'PUBLISHED',
                        views INT DEFAULT 0,
                        likes INT DEFAULT 0,
                        dislikes INT DEFAULT 0,
                        author_id BIGINT,
                        published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (author_id) REFERENCES users (id) ON DELETE SET NULL
);

CREATE TABLE article_reactions (
                                 id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                 article_id BIGINT NOT NULL,
                                 user_id BIGINT NOT NULL,
                                 reaction_type VARCHAR(10) NOT NULL CHECK (reaction_type IN ('LIKE', 'DISLIKE')),
                                 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 UNIQUE (article_id, user_id),
                                 FOREIGN KEY (article_id) REFERENCES articles (id) ON DELETE CASCADE,
                                 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);