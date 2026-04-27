-- =====================================================
-- 1. ТАБЛИЦА РОЛЕЙ
-- =====================================================
CREATE TABLE IF NOT EXISTS roles
(
  id   SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);


INSERT INTO roles (name)
VALUES ('USER'),
       ('ADMIN');

-- =====================================================
-- 2. ТАБЛИЦА ПОЛЬЗОВАТЕЛЕЙ
-- =====================================================
CREATE TABLE IF NOT EXISTS users
(
  id                SERIAL PRIMARY KEY,
  username          VARCHAR(50)  NOT NULL UNIQUE,
  name              VARCHAR(100) NOT NULL,
  surname           VARCHAR(100) NOT NULL,
  password          VARCHAR(100) NOT NULL,
  email             VARCHAR(100) NOT NULL UNIQUE,
  phone             VARCHAR(20)  NOT NULL,
  registration_date DATE,
  role_id           INT REFERENCES roles (id),
  address           VARCHAR(255)
);

-- =====================================================
-- 3. ТАБЛИЦА КАТЕГОРИЙ
-- =====================================================
CREATE TABLE IF NOT EXISTS categories
(
  id   SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE
);

-- =====================================================
-- 4. ТАБЛИЦА БРЕНДОВ
-- =====================================================
CREATE TABLE IF NOT EXISTS brands
(
  id   SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

-- =====================================================
-- 5. ТАБЛИЦА ТОВАРОВ (С РАСШИРЕННЫМИ ПОЛЯМИ)
-- =====================================================
CREATE TABLE IF NOT EXISTS products
(
  id              SERIAL PRIMARY KEY,
  name            VARCHAR(100)                                     NOT NULL,
  description     TEXT,
  category_id     INT REFERENCES categories (id) ON DELETE CASCADE NOT NULL,
  brand_id        INT REFERENCES brands (id) ON DELETE CASCADE     NOT NULL,
  price           DECIMAL(10, 2)                                   NOT NULL,
  old_price       DECIMAL(10, 2),
  file_url        VARCHAR(500),

  -- Расширенные поля для подробного описания
  processor       VARCHAR(200),
  ram             VARCHAR(50),
  storage         VARCHAR(100),
  display         VARCHAR(200),
  battery         VARCHAR(100),
  color           VARCHAR(50),
  weight          VARCHAR(50),
  warranty        VARCHAR(50),
  country         VARCHAR(100),
  additional_info TEXT,
  in_stock        BOOLEAN   DEFAULT TRUE,
  stock_quantity  INT       DEFAULT 0,

  created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 6. ТАБЛИЦА МНОЖЕСТВЕННЫХ ИЗОБРАЖЕНИЙ ТОВАРА
-- =====================================================
CREATE TABLE IF NOT EXISTS product_images
(
  id            SERIAL PRIMARY KEY,
  product_id    INT          NOT NULL REFERENCES products (id) ON DELETE CASCADE,
  image_url     VARCHAR(500) NOT NULL,
  is_primary    BOOLEAN   DEFAULT FALSE,
  display_order INT       DEFAULT 0,
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_product_images_product_id ON product_images (product_id);

-- =====================================================
-- 7. ТАБЛИЦА ИЗБРАННОГО
-- =====================================================
CREATE TABLE IF NOT EXISTS user_favorites
(
  id         SERIAL PRIMARY KEY,
  user_id    INT       NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  product_id INT       NOT NULL REFERENCES products (id) ON DELETE CASCADE,
  added_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (user_id, product_id)
);

CREATE INDEX IF NOT EXISTS idx_user_favorites_user_id ON user_favorites (user_id);
CREATE INDEX IF NOT EXISTS idx_user_favorites_product_id ON user_favorites (product_id);

-- =====================================================
-- 8. ТАБЛИЦА ЗАКАЗОВ
-- =====================================================
CREATE TABLE IF NOT EXISTS orders
(
  id              SERIAL PRIMARY KEY,
  user_id         INT            NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  order_date      TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status          VARCHAR(20)    NOT NULL,
  total_price     DECIMAL(10, 2) NOT NULL,
  address         VARCHAR(500)   NOT NULL,
  delivery_method VARCHAR(30)    NOT NULL,
  payment_method  VARCHAR(40)    NOT NULL
);

-- =====================================================
-- 9. ТАБЛИЦА ТОВАРОВ В ЗАКАЗЕ
-- =====================================================
CREATE TABLE IF NOT EXISTS order_items
(
  id         SERIAL PRIMARY KEY,
  order_id   INT            NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
  product_id INT            NOT NULL REFERENCES products (id) ON DELETE CASCADE,
  quantity   INT            NOT NULL,
  price      DECIMAL(10, 2) NOT NULL
);

-- =====================================================
-- 10. ТАБЛИЦА ПЛАТЕЖЕЙ
-- =====================================================
CREATE TABLE IF NOT EXISTS payments
(
  id           SERIAL PRIMARY KEY,
  order_id     INT            NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
  user_id      INT            NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  amount       DECIMAL(10, 2) NOT NULL,
  payment_date TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status       VARCHAR(20)    NOT NULL
);

-- =====================================================
-- 11. ТАБЛИЦА ОТЗЫВОВ
-- =====================================================
CREATE TABLE IF NOT EXISTS reviews
(
  id          SERIAL PRIMARY KEY,
  user_id     INT       NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  product_id  INT       NOT NULL REFERENCES products (id) ON DELETE CASCADE,
  rating      INT CHECK ( rating >= 1 AND rating <= 5 ),
  comment     TEXT,
  review_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 12. ТАБЛИЦА КОРЗИНЫ
-- =====================================================
CREATE TABLE IF NOT EXISTS shopping_cart
(
  id         SERIAL PRIMARY KEY,
  user_id    INT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  product_id INT NOT NULL REFERENCES products (id) ON DELETE CASCADE,
  quantity   INT NOT NULL
);

-- =====================================================
-- 13. ТАБЛИЦА СТАТЕЙ/НОВОСТЕЙ
-- =====================================================
CREATE TABLE IF NOT EXISTS articles
(
  id           SERIAL PRIMARY KEY,
  title        VARCHAR(200) NOT NULL,
  slug         VARCHAR(200) NOT NULL UNIQUE,
  content      TEXT         NOT NULL,
  excerpt      VARCHAR(500),
  image_url    VARCHAR(500),
  article_type VARCHAR(20) DEFAULT 'NEWS',
  status       VARCHAR(20) DEFAULT 'PUBLISHED',
  views        INT         DEFAULT 0,
  likes        INT         DEFAULT 0,
  dislikes     INT         DEFAULT 0,
  author_id    INT          REFERENCES users (id) ON DELETE SET NULL,
  published_at TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  created_at   TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  updated_at   TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 14. ТАБЛИЦА ЛАЙКОВ/ДИЗЛАЙКОВ СТАТЕЙ
-- =====================================================
CREATE TABLE IF NOT EXISTS article_reactions
(
  id            SERIAL PRIMARY KEY,
  article_id    INT         NOT NULL REFERENCES articles (id) ON DELETE CASCADE,
  user_id       INT         NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  reaction_type VARCHAR(10) NOT NULL CHECK (reaction_type IN ('LIKE', 'DISLIKE')),
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (article_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_article_reactions_article ON article_reactions (article_id);
CREATE INDEX IF NOT EXISTS idx_article_reactions_user ON article_reactions (user_id);


-- =====================================================
-- ПОЛНОЕ НАПОЛНЕНИЕ БАЗЫ ДАННЫХ (ОДИН СКРИПТ)
-- Добавляет категории, бренды, товары (с 3-4 фото), статьи, отзывы, заказы, избранное, реакции
-- Источник фото: images.pexels.com (доступен из РФ) и placehold.co (запасной вариант)
-- =====================================================

INSERT INTO categories (name) VALUES ('Ноутбуки'), ('Смартфоны'), ('Телевизоры'), ('Аудиотехника'),
                                     ('Игровые товары'), ('Аксессуары'), ('Планшеты'), ('Умный дом'), ('Смарт-часы'), ('Наушники'),
                                     ('Мониторы'), ('Клавиатуры'), ('Мыши'), ('Принтеры'), ('Роутеры'), ('Power Bank')
ON CONFLICT (name) DO NOTHING;

-- Бренды
INSERT INTO brands (name) VALUES ('Apple'), ('Samsung'), ('Xiaomi'), ('Lenovo'), ('Sony'), ('LG'),
                                 ('Huawei'), ('JBL'), ('Asus'), ('Acer'), ('Microsoft'), ('Dell'), ('HP'), ('Realme'), ('OnePlus'),
                                 ('Logitech'), ('Razer'), ('SteelSeries'), ('Google'), ('MSI'), ('Gigabyte')
ON CONFLICT (name) DO NOTHING;

-- =====================================================
-- 2. ТОВАРЫ (ПРЯМЫЕ ВСТАВКИ БЕЗ DO $$)
-- =====================================================

-- 1. Apple MacBook Air 15 M2
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Ноутбук Apple MacBook Air 15 M2', '15.3-дюймовый ноутбук с чипом M2, 8‑ядерный CPU, 10‑ядерный GPU, до 18 часов работы.',
       (SELECT id FROM categories WHERE name = 'Ноутбуки'), (SELECT id FROM brands WHERE name = 'Apple'), 129990, 149990,
       'https://ir.ozone.ru/s3/multimedia-1-s/wc2500/7500916648.jpg', 'Apple M2 (8 ядер CPU, 10 ядер GPU)', '16GB', '512GB SSD', '15.3" Liquid Retina', 'До 18 часов', 'Midnight', '1.51 кг', '12 мес.', 'Китай', TRUE, 25
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Ноутбук Apple MacBook Air 15 M2');

-- 2. ASUS ROG Zephyrus G14
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Ноутбук ASUS ROG Zephyrus G14 (2024)', 'Игровой ноутбук 14″ Ryzen 9 8945HS, RTX 4060, 32 ГБ DDR5, 1 ТБ SSD, экран 120 Гц.',
       (SELECT id FROM categories WHERE name = 'Ноутбуки'), (SELECT id FROM brands WHERE name = 'Asus'), 139990, 159990,
       'https://c.dns-shop.ru/thumb/st1/fit/500/500/9b2021ce6e58ace344fdfd857ba96cc7/4764036c27387c3b9e226e167435912c32bdef19893822f9dc4592bcef8e3c89.jpg', 'AMD Ryzen 9 8945HS', '32GB', '1TB SSD', '14" WQXGA 120Hz', 'До 10 часов', 'Eclipse Gray', '1.65 кг', '24 мес.', 'Китай', TRUE, 12
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Ноутбук ASUS ROG Zephyrus G14 (2024)');

-- 3. Lenovo ThinkPad X1 Carbon
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Ноутбук Lenovo ThinkPad X1 Carbon Gen 11', 'Бизнес-ультрабук 14″ Intel Core i7-1365U, 16 ГБ LPDDR5, 1 ТБ SSD, вес 1.12 кг.',
       (SELECT id FROM categories WHERE name = 'Ноутбуки'), (SELECT id FROM brands WHERE name = 'Lenovo'), 159990, 179990,
       'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/543ca385aae73e0cb3ca86263d74f8ac/98e2bc84251de2e223ab370fe9ccadea57f0f894e40d124549a8dd6f325162ed.jpg', 'Intel Core i7-1365U', '16GB', '1TB SSD', '14" IPS WUXGA', 'До 15 часов', 'Black', '1.12 кг', '36 мес.', 'Китай', TRUE, 10
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Ноутбук Lenovo ThinkPad X1 Carbon Gen 11');

-- 4. Samsung Galaxy S24 Ultra
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Смартфон Samsung Galaxy S24 Ultra', '6.8″ Dynamic AMOLED, Snapdragon 8 Gen 3, 12/512 ГБ, 200 МП камера, S Pen.',
       (SELECT id FROM categories WHERE name = 'Смартфоны'), (SELECT id FROM brands WHERE name = 'Samsung'), 119990, 139990,
       'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/7e6666b709d71427aa189f8e2150c722/7bb18f6f859063ef21e86697f97589ab7bc609973e205108183e29b0bb173c8b.jpg', 'Snapdragon 8 Gen 3', '12GB', '512GB', '6.8" Dynamic AMOLED 2X, 120Hz', '5000 мАч', 'Titanium Violet', '232 г', '24 мес.', 'Корея', TRUE, 30
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Смартфон Samsung Galaxy S24 Ultra');

-- 5. Xiaomi 14 Ultra
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Смартфон Xiaomi 14 Ultra', 'Leica-камера 1″, Snapdragon 8 Gen 3, 16/512 ГБ, 90 Вт зарядка.',
       (SELECT id FROM categories WHERE name = 'Смартфоны'), (SELECT id FROM brands WHERE name = 'Xiaomi'), 89990, 99990,
       'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/4c8d61370303b6683572eeeee3e77e72/4fea4bc87792b8698618a948b7ac0ba847a895bec6d7294e720e291b879a75c9.jpg', 'Snapdragon 8 Gen 3', '16GB', '512GB', '6.73" AMOLED WQHD+ 120Hz', '5000 мАч', 'Black', '220 г', '12 мес.', 'Китай', TRUE, 20
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Смартфон Xiaomi 14 Ultra');

-- 6. Apple iPhone 15 Pro
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Смартфон Apple iPhone 15 Pro', 'Титан, A17 Pro, 8/256 ГБ, камера 48 МП, USB-C 3.0.',
       (SELECT id FROM categories WHERE name = 'Смартфоны'), (SELECT id FROM brands WHERE name = 'Apple'), 99990, 109990,
       'https://c.dns-shop.ru/thumb/st1/fit/0/0/5e0c7e45ab87a5edda0feb4a2d622833/57c3fa75db8745654a371cbec253d141e7b1ac632f61e9dce6b5bd421941132e.jpg', 'Apple A17 Pro', '8GB', '256GB', '6.1" Super Retina XDR, 120Hz', 'До 23 часов', 'Natural Titanium', '187 г', '12 мес.', 'Китай', TRUE, 25
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Смартфон Apple iPhone 15 Pro');

-- 7. Google Pixel 8 Pro
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Смартфон Google Pixel 8 Pro', '6.7″ OLED 120Hz, Google Tensor G3, 12/256 ГБ, ИИ-камера.',
       (SELECT id FROM categories WHERE name = 'Смартфоны'), (SELECT id FROM brands WHERE name = 'Google'), 79990, 89990,
       'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/567788e12c71501fcb083ffec4531a31/7c732ab63ff0cacea590cb38ae774f00462eec74c469143abd24d34a510e4f9e.jpg', 'Google Tensor G3', '12GB', '256GB', '6.7" OLED 120Hz', '5050 мАч', 'Obsidian', '213 г', '12 мес.', 'Китай', TRUE, 15
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Смартфон Google Pixel 8 Pro');

-- 8. LG OLED C3 65"
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, warranty, country, in_stock, stock_quantity)
SELECT 'Телевизор LG OLED65C3RLA', '65-дюймовый OLED 4K с процессором α9 Gen6 AI, поддержка Dolby Vision и G-SYNC.',
       (SELECT id FROM categories WHERE name = 'Телевизоры'), (SELECT id FROM brands WHERE name = 'LG'), 149990, 179990,
       'https://ir.ozone.ru/s3/multimedia-1-2/wc1000/8277794318.jpg', 'α9 Gen6 AI', '3GB', '8GB', '65" OLED 4K 120Hz', '24 мес.', 'Корея', TRUE, 8
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Телевизор LG OLED65C3RLA');

-- 9. Samsung Neo QLED 8K 75"
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, warranty, country, in_stock, stock_quantity)
SELECT 'Телевизор Samsung Neo QLED 8K 75"', '75-дюймовый 8K-телевизор с Mini LED, 100% цветовой охват.',
       (SELECT id FROM categories WHERE name = 'Телевизоры'), (SELECT id FROM brands WHERE name = 'Samsung'), 299990, 349990,
       'https://ir.ozone.ru/s3/multimedia-1-1/wc1000/8277909445.jpg', 'Neo Quantum 8K', '4GB', '32GB', '75" 8K 7680x4320', '24 мес.', 'Корея', TRUE, 5
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Телевизор Samsung Neo QLED 8K 75"');

-- 10. Sony WH-1000XM5
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Наушники Sony WH-1000XM5', 'Беспроводные наушники с активным шумоподавлением, до 30 ч работы, LDAC.',
       (SELECT id FROM categories WHERE name = 'Аудиотехника'), (SELECT id FROM brands WHERE name = 'Sony'), 29990, 34990,
       'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/da703c4ba95708d23fc83061b7f32c4e/2df2632475190df8324dd72376786ed737facef7dc387bf5fcd76f88d5fc28ec.jpg', 'До 30 часов', 'Black', '250 г', '12 мес.', 'Малайзия', TRUE, 50
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Наушники Sony WH-1000XM5');

-- 11. Apple AirPods Pro 2
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Наушники Apple AirPods Pro 2', 'TWS с активным шумоподавлением, чип H2, улучшенный звук, кейс MagSafe.',
       (SELECT id FROM categories WHERE name = 'Аудиотехника'), (SELECT id FROM brands WHERE name = 'Apple'), 24990, 28990,
       'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/3908093ea7d4c4fbdcd0adcfd5769327/4b1c1955a2530fa2de2ad1f4faa496f553779822690c1505f5400e6c34a1dbe1.jpg', 'До 6 часов (30 ч с кейсом)', 'White', '5.3 г', '12 мес.', 'Китай', TRUE, 35
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Наушники Apple AirPods Pro 2');

-- 12. Apple Watch Series 9
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, display, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Apple Watch Series 9 GPS 45mm', 'Always-On Retina, датчик кислорода в крови, отслеживание тренировок.',
       (SELECT id FROM categories WHERE name = 'Смарт-часы'), (SELECT id FROM brands WHERE name = 'Apple'), 39990, 44990,
       'https://ir.ozone.ru/s3/multimedia-z/wc1000/6771570899.jpg', 'S9 SiP', '1.9" Retina LTPO', 'До 18 часов', 'Starlight', '38.7 г', '12 мес.', 'Китай', TRUE, 40
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Apple Watch Series 9 GPS 45mm');

-- 13. Samsung Galaxy Watch 6 Classic
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, display, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Смарт-часы Samsung Galaxy Watch 6 Classic 47mm', 'Вращающийся безель, ECG, мониторинг сна, Exynos W930.',
       (SELECT id FROM categories WHERE name = 'Смарт-часы'), (SELECT id FROM brands WHERE name = 'Samsung'), 29990, 34990,
       'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/cef5ca86f21b54076e32c939f6774045/5a707a3d118ae3d0930691d6e052574d429f5f85932a233cbd564c744d3320d8.jpg', 'Exynos W930', '1.5" Super AMOLED', 'До 40 часов', 'Black', '59 г', '12 мес.', 'Корея', TRUE, 25
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Смарт-часы Samsung Galaxy Watch 6 Classic 47mm');

-- 14. Монитор Samsung Odyssey G7 32"
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, display, warranty, country, in_stock, stock_quantity)
SELECT 'Монитор Samsung Odyssey G7 32"', '32″ изогнутый QLED, 240 Гц, 1 мс, поддержка G-SYNC и FreeSync.',
       (SELECT id FROM categories WHERE name = 'Мониторы'), (SELECT id FROM brands WHERE name = 'Samsung'), 49990, 59990,
       'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/53e0ef5824fb21d50c1527beafa82ba7/f87a0701f6376f5a937b2a5c678839a3be273a9e5f60213c99f63525f47ee820.jpg', '32" QLED 2560x1440, 240Hz', '24 мес.', 'Китай', TRUE, 15
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Монитор Samsung Odyssey G7 32"');

-- 15. Мышь Logitech G502 X Plus
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, battery, color, weight, warranty, country, in_stock, stock_quantity)
SELECT 'Мышь Logitech G502 X Plus', 'Беспроводная игровая мышь с подсветкой Lightsync, 8 кнопок, сенсор Hero 25K.',
       (SELECT id FROM categories WHERE name = 'Игровые товары'), (SELECT id FROM brands WHERE name = 'Logitech'), 14990, 19990,
       'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/1bffe56570e94a6b19dd06f4babfafff/a5c59b99b1689ef01641e8dc3166b7d3fa7d7cfc3c0417641b205c77554508c3.png', 'До 120 часов', 'Black', '106 г', '24 мес.', 'Китай', TRUE, 35
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Мышь Logitech G502 X Plus');

-- 16. Клавиатура Razer BlackWidow V4 Pro
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, warranty, country, in_stock, stock_quantity)
SELECT 'Клавиатура Razer BlackWidow V4 Pro', 'Механическая клавиатура с опциональными переключателями, RGB-подсветка, магнитная подставка.',
       (SELECT id FROM categories WHERE name = 'Клавиатуры'), (SELECT id FROM brands WHERE name = 'Razer'), 18990, 22990,
       'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/b32f7fc712eab03e95bd9235051b733e/3cd5d99d3b469e6dec57b820d2413fdfa247afbbe5055c2f48f900a376206992.jpg', '12 мес.', 'Китай', TRUE, 25
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Клавиатура Razer BlackWidow V4 Pro');

-- 17. Power Bank Xiaomi 20000mAh
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, battery, warranty, country, in_stock, stock_quantity)
SELECT 'Power Bank Xiaomi 20000mAh 22.5W', '20 000 мАч, 2 USB-A + USB-C, быстрая зарядка, поддержка 22.5 Вт.',
       (SELECT id FROM categories WHERE name = 'Power Bank'), (SELECT id FROM brands WHERE name = 'Xiaomi'), 2990, 3990,
       'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/51b5275cf1f5da8aad2a3edfbf1c8a08/49975a25651ef415bbb337cf730220564204a19e80810b1fa79e0fc764566d21.jpg', '20000 мАч', '6 мес.', 'Китай', TRUE, 100
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Power Bank Xiaomi 20000mAh 22.5W');

-- 18. Игровая клавиатура SteelSeries Apex Pro TKL
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, warranty, country, in_stock, stock_quantity)
SELECT 'Клавиатура SteelSeries Apex Pro TKL', 'Магнитные переключатели OmniPoint, регулировка хода клавиш, OLED-дисплей.',
       (SELECT id FROM categories WHERE name = 'Клавиатуры'), (SELECT id FROM brands WHERE name = 'SteelSeries'), 22990, 26990,
       'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/b3a6e27e0e0a2d08dae9ca5f47aaf639/4b757a5349dcdcb441c4a1553e8104499543e2638cf0788feccd9bb1c547e380.jpg', '12 мес.', 'Китай', TRUE, 20
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Клавиатура SteelSeries Apex Pro TKL');




-- =====================================================
-- МНОЖЕСТВЕННЫЕ ИЗОБРАЖЕНИЯ ДЛЯ ВСЕХ ТОВАРОВ
-- (ТОЛЬКО ДОПОЛНИТЕЛЬНЫЕ, БЕЗ ПЕРВЫХ КАРТИНОК)
-- =====================================================

-- 1. Apple MacBook Air 15 M2
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://ir.ozone.ru/s3/multimedia-1-t/wc2500/7500916649.jpg', FALSE, 1 FROM products WHERE name = 'Ноутбук Apple MacBook Air 15 M2'
UNION ALL
SELECT id, 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=600', FALSE, 2 FROM products WHERE name = 'Ноутбук Apple MacBook Air 15 M2'
ON CONFLICT DO NOTHING;

-- 2. ASUS ROG Zephyrus G14
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/ef445946d467c2a9fc63beec7d1e9725/eda7d4adcec040eaa1174b900fdb7e19ee40de4bc6318e05bd7d81ba105b7c52.jpg', FALSE, 1 FROM products WHERE name = 'Ноутбук ASUS ROG Zephyrus G14 (2024)'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/7f8bbc7d14a9eaacd94081568a5f7035/747f7ca918d2c7d60c54aea99abc472ef904bbc22526f47ebdc02fa2edee0b2d.jpg', FALSE, 2 FROM products WHERE name = 'Ноутбук ASUS ROG Zephyrus G14 (2024)'
ON CONFLICT DO NOTHING;

-- 3. Lenovo ThinkPad X1 Carbon
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/2a2156060d960423e454db18977df7ea/0964ec0b77715e64c22aaf7e2776672cd30555ef227168f81a682d6874e7e319.jpg', FALSE, 1 FROM products WHERE name = 'Ноутбук Lenovo ThinkPad X1 Carbon Gen 11'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/cf001ac9c34d43c0e34928172a60207f/231ec41356af30b9301256cd2c652cff2ba6b763bcc471a342f0bf853e2abfdd.jpg', FALSE, 2 FROM products WHERE name = 'Ноутбук Lenovo ThinkPad X1 Carbon Gen 11'
ON CONFLICT DO NOTHING;

-- 4. Samsung Galaxy S24 Ultra
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/31e9fa3b020cfa6f6831aed6d5626a05/943a51dc4c5dc07d841f17fab48aa040e5465c988147717deece48dc9c0d4b35.jpg', FALSE, 1 FROM products WHERE name = 'Смартфон Samsung Galaxy S24 Ultra'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/030a43baa3493817d00dbeba0f032e9d/7364d26e00e5e0424c2608bd1f1cd8e11f1369cef3a22cf012f9b409756f1bc7.jpg', FALSE, 2 FROM products WHERE name = 'Смартфон Samsung Galaxy S24 Ultra'
ON CONFLICT DO NOTHING;

-- 5. Xiaomi 14 Ultra
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/3b2a0e3be2978ab576054eadd71e0200/5eee7bdf56a7e713201e9cc36331e6648d8e33517f6bcd0d867539b1339a5b12.jpg', FALSE, 1 FROM products WHERE name = 'Смартфон Xiaomi 14 Ultra'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/dadff0c19e70d05b40e6ae63b8b70ac2/06a45bf19764b1b7f1aa96e10ff877228da2beef69659d209e7cb8ba07370adc.jpg', FALSE, 2 FROM products WHERE name = 'Смартфон Xiaomi 14 Ultra'
ON CONFLICT DO NOTHING;

-- 6. Apple iPhone 15 Pro
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/0/0/b98143c68135039a292364d2539676f7/c2d1d1b87e08e74c8bae79a30ec0dafaf50fb75bee34352b84e8f75605c77f9a.jpg', FALSE, 1 FROM products WHERE name = 'Смартфон Apple iPhone 15 Pro'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/0/0/46a7e2fb8210b2f478ae4bfe75f1fb00/6e5c9d571e509203f16dcca345f0a24437f90d6c181acd46b4183ef4676b4179.jpg', FALSE, 2 FROM products WHERE name = 'Смартфон Apple iPhone 15 Pro'
ON CONFLICT DO NOTHING;

-- 7. Google Pixel 8 Pro
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/32a8261872d308cbe239d5b352117e78/17b684ec7db13d538b24d6d1794f77cab59689010314be9283e9b287d750a9d3.jpg', FALSE, 1 FROM products WHERE name = 'Смартфон Google Pixel 8 Pro'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/82c813b5bdf2de73d52ae1e7ac295c1c/9af42aac585676929a55453febc7d1c0afcee122f098829fee94fe6992de248f.jpg', FALSE, 2 FROM products WHERE name = 'Смартфон Google Pixel 8 Pro'
ON CONFLICT DO NOTHING;

-- 8. LG OLED C3 65"
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://ir.ozone.ru/s3/multimedia-1-g/wc1000/8277909460.jpg', FALSE, 1 FROM products WHERE name = 'Телевизор LG OLED65C3RLA'
UNION ALL
SELECT id, 'https://ir.ozone.ru/s3/multimedia-1-1/wc1000/8277909841.jpg', FALSE, 2 FROM products WHERE name = 'Телевизор LG OLED65C3RLA'
ON CONFLICT DO NOTHING;

-- 9. Samsung Neo QLED 8K 75"
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://ir.ozone.ru/s3/multimedia-1-g/wc1000/8277909460.jpg', FALSE, 1 FROM products WHERE name = 'Телевизор Samsung Neo QLED 8K 75"'
ON CONFLICT DO NOTHING;

-- 10. Sony WH-1000XM5
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/36a2843f63061be1c155035bc1708b50/da9e742289e85bbff398e7b3fc1d6e7cfce693fd9644c8c15efdb6badd484644.jpg', FALSE, 1 FROM products WHERE name = 'Наушники Sony WH-1000XM5'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/8224a9f101fb13a86d07eacd04ac88a7/a30bd180e2fbbed03c432319feb09821367ce915532c8c1f23758ebffbfe3c73.jpg', FALSE, 2 FROM products WHERE name = 'Наушники Sony WH-1000XM5'
ON CONFLICT DO NOTHING;

-- 11. Apple AirPods Pro 2
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/419f033469292a0feef116b222e162f4/1930777d7cc89fa47668ef6c1de8ebd9c72acb0fdb8be9da0005b6c9e0f1bb45.jpg', FALSE, 1 FROM products WHERE name = 'Наушники Apple AirPods Pro 2'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/f373615aa6fadb22f0b5849d55cf143b/fb4ce035f130b7812895d06d2db154b87347d28044c3b7615f89a139e7f82c0e.jpg', FALSE, 2 FROM products WHERE name = 'Наушники Apple AirPods Pro 2'
ON CONFLICT DO NOTHING;

-- 12. Apple Watch Series 9
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://ir.ozone.ru/s3/multimedia-q/wc1000/6771571286.jpg', FALSE, 1 FROM products WHERE name = 'Apple Watch Series 9 GPS 45mm'
ON CONFLICT DO NOTHING;

-- 13. Samsung Galaxy Watch 6 Classic
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/4e2ac97c1dc47e8857b3ac7920145da6/cfc92cd5a52f315d0a325911fe60b40a9792d186773a37ab8bd689578e6b60b9.jpg', FALSE, 1 FROM products WHERE name = 'Смарт-часы Samsung Galaxy Watch 6 Classic 47mm'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/58fe953e4a9718de107804397dff57c8/ec24e29fae15a317404449fd25a0e69bf7616a0088e39ab8d17e1ed1b322d747.jpg', FALSE, 2 FROM products WHERE name = 'Смарт-часы Samsung Galaxy Watch 6 Classic 47mm'
ON CONFLICT DO NOTHING;

-- 14. Монитор Samsung Odyssey G7 32"
INSERT INTO product_images (product_id, image_url, is_primary, display_order)

SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/642973d652a7e1ba3ba82bb87b3663d2/b59df998f0d254275a9201d39763b5e1e1caaa83e20a20f013a53196fc2284ec.jpg', FALSE, 1 FROM products WHERE name = 'Монитор Samsung Odyssey G7 32"'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/345fb8e0999b877da2b118444627aa38/c363c73e9d389ec0a7d36eeb8b5f44295bac5206255d0ababbcfc1dc621665b0.jpg', FALSE, 2 FROM products WHERE name = 'Монитор Samsung Odyssey G7 32"'
ON CONFLICT DO NOTHING;

-- 15. Мышь Logitech G502 X Plus
INSERT INTO product_images (product_id, image_url, is_primary, display_order)

SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/6acfa34ceb86b2775e31b8be3b4bb97d/4a277bbfa4df3cab76cb45e3fcd2c9b53409bf291980062e12e0ba83470fcae8.jpg', FALSE, 1 FROM products WHERE name = 'Мышь Logitech G502 X Plus'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/92254ea3259454814c0a5590d6d6760a/422c9de307749a96980c1dc13141f0cbda64d251cb7f63ae267178309f56391c.jpg', FALSE, 2 FROM products WHERE name = 'Мышь Logitech G502 X Plus'
ON CONFLICT DO NOTHING;

-- 16. Клавиатура Razer BlackWidow V4 Pro
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/251eaefd7aa8aee43834b4e00612d691/009af35a41e372a6b92021c387b7c82eaaa43d123fe5511e5f6c9bbaf6421d11.jpg', FALSE, 1 FROM products WHERE name = 'Клавиатура Razer BlackWidow V4 Pro'
UNION ALL
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/bc0a779b1853c83687c5c1f02550212b/ba4bcb01df76f5700c8d77ffeec85e1bd1902c5c1b8a2e49b1febbe937693798.jpg', FALSE, 2 FROM products WHERE name = 'Клавиатура Razer BlackWidow V4 Pro'
ON CONFLICT DO NOTHING;

-- 17. Power Bank Xiaomi 20000mAh
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/3a79aa141f9569f81de71a51930bac76/ae2b22968da44cc56b8d17b44139edb48f7c428a5d6ed5b9f88f211248875ff9.jpg', FALSE, 1 FROM products WHERE name = 'Power Bank Xiaomi 20000mAh 22.5W'
ON CONFLICT DO NOTHING;

-- 18. Клавиатура SteelSeries Apex Pro TKL
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/c9c3ded5ad0725ed69a57c659e9b6836/686ffc3e249eae617ff6cc4b8e980bffdb706eca4a6bb01c1623f94c05982fd0.jpg', FALSE, 1 FROM products WHERE name = 'Клавиатура SteelSeries Apex Pro TKL'
ON CONFLICT DO NOTHING;



-- =====================================================
-- ДОЗАПОЛНЕНИЕ БАЗЫ ДАННЫХ (ПОЛЬЗОВАТЕЛИ, ЗАКАЗЫ, ОТЗЫВЫ, СТАТЬИ, РЕАКЦИИ)
-- =====================================================

-- 1. ДОБАВЛЕНИЕ ТЕСТОВЫХ ПОЛЬЗОВАТЕЛЕЙ (ЕСЛИ ИХ НЕТ)
-- Пароль для всех: 'user123' (BCrypt)
INSERT INTO users (username, name, surname, password, email, phone, registration_date, role_id, address)
SELECT 'user', 'Иван', 'Петров', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOpw7KcI3QHqG',
       'user@example.com', '+7 (999) 123-45-67', CURRENT_DATE, (SELECT id FROM roles WHERE name = 'USER'),
       'г. Москва, ул. Тверская, д. 10, кв. 25'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'user');

INSERT INTO users (username, name, surname, password, email, phone, registration_date, role_id, address)
SELECT 'admin', 'Админ', 'Админов', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOpw7KcI3QHqG',
       'admin@example.com', '+7 (999) 999-99-99', CURRENT_DATE, (SELECT id FROM roles WHERE name = 'ADMIN'),
       'г. Москва, Административный центр'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin');

-- 2. ЗАКАЗЫ (3 заказа для пользователя user)
-- =====================================================
-- 2. ЗАКАЗЫ (3 заказа для пользователя user) - ИСПРАВЛЕННАЯ ВЕРСИЯ
-- =====================================================
-- =====================================================
-- 2. ЗАКАЗЫ (3 заказа для пользователя user) - ИСПРАВЛЕННАЯ ВЕРСИЯ (без конфликта имён)
-- =====================================================
DO $$
  DECLARE
    v_user_id INT;
    order1_id INT;
    order2_id INT;
    order3_id INT;
    prod1_id INT;
    prod2_id INT;
    prod3_id INT;
    prod4_id INT;
    prod5_id INT;
    prod6_id INT;
    total1 DECIMAL(10,2) := 0;
    total2 DECIMAL(10,2) := 0;
    total3 DECIMAL(10,2) := 0;
  BEGIN
    SELECT id INTO v_user_id FROM users WHERE username = 'user' LIMIT 1;

    IF v_user_id IS NOT NULL THEN
      -- Получаем ID товаров заранее
      SELECT id INTO prod1_id FROM products WHERE name ILIKE '%MacBook Air 15%' LIMIT 1;
      SELECT id INTO prod2_id FROM products WHERE name ILIKE '%Samsung Galaxy S24 Ultra%' LIMIT 1;
      SELECT id INTO prod3_id FROM products WHERE name ILIKE '%Apple Watch Series 9%' LIMIT 1;
      SELECT id INTO prod4_id FROM products WHERE name ILIKE '%Sony WH-1000XM5%' LIMIT 1;
      SELECT id INTO prod5_id FROM products WHERE name ILIKE '%Power Bank Xiaomi%' LIMIT 1;
      SELECT id INTO prod6_id FROM products WHERE name ILIKE '%Razer BlackWidow%' LIMIT 1;

      -- Вычисляем суммы для каждого заказа
      IF prod1_id IS NOT NULL THEN total1 := total1 + (SELECT price FROM products WHERE id = prod1_id); END IF;
      IF prod2_id IS NOT NULL THEN total1 := total1 + (SELECT price FROM products WHERE id = prod2_id); END IF;

      IF prod3_id IS NOT NULL THEN total2 := total2 + (SELECT price FROM products WHERE id = prod3_id); END IF;
      IF prod4_id IS NOT NULL THEN total2 := total2 + (SELECT price FROM products WHERE id = prod4_id); END IF;

      IF prod5_id IS NOT NULL THEN total3 := total3 + 2 * (SELECT price FROM products WHERE id = prod5_id); END IF;
      IF prod6_id IS NOT NULL THEN total3 := total3 + (SELECT price FROM products WHERE id = prod6_id); END IF;

      -- Заказ 1 (завершён)
      INSERT INTO orders (user_id, order_date, status, total_price, address, delivery_method, payment_method)
      VALUES (v_user_id, CURRENT_TIMESTAMP - INTERVAL '20 days', 'COMPLETED', total1,
              'г. Москва, ул. Тверская, д. 10, кв. 25', 'Курьерская доставка', 'Банковская карта')
      RETURNING id INTO order1_id;

      -- Заказ 2 (в обработке)
      INSERT INTO orders (user_id, order_date, status, total_price, address, delivery_method, payment_method)
      VALUES (v_user_id, CURRENT_TIMESTAMP - INTERVAL '5 days', 'PROCESSING', total2,
              'г. Москва, ул. Тверская, д. 10, кв. 25', 'Постамат', 'Наличные при получении')
      RETURNING id INTO order2_id;

      -- Заказ 3 (отменён)
      INSERT INTO orders (user_id, order_date, status, total_price, address, delivery_method, payment_method)
      VALUES (v_user_id, CURRENT_TIMESTAMP - INTERVAL '2 days', 'CANCELLED', total3,
              'г. Москва, ул. Тверская, д. 10, кв. 25', 'Почта России', 'Банковская карта')
      RETURNING id INTO order3_id;

      -- Добавляем товары в заказы
      IF order1_id IS NOT NULL THEN
        IF prod1_id IS NOT NULL THEN
          INSERT INTO order_items (order_id, product_id, quantity, price)
          VALUES (order1_id, prod1_id, 1, (SELECT price FROM products WHERE id = prod1_id));
        END IF;
        IF prod2_id IS NOT NULL THEN
          INSERT INTO order_items (order_id, product_id, quantity, price)
          VALUES (order1_id, prod2_id, 1, (SELECT price FROM products WHERE id = prod2_id));
        END IF;
      END IF;

      IF order2_id IS NOT NULL THEN
        IF prod3_id IS NOT NULL THEN
          INSERT INTO order_items (order_id, product_id, quantity, price)
          VALUES (order2_id, prod3_id, 1, (SELECT price FROM products WHERE id = prod3_id));
        END IF;
        IF prod4_id IS NOT NULL THEN
          INSERT INTO order_items (order_id, product_id, quantity, price)
          VALUES (order2_id, prod4_id, 1, (SELECT price FROM products WHERE id = prod4_id));
        END IF;
      END IF;

      IF order3_id IS NOT NULL THEN
        IF prod5_id IS NOT NULL THEN
          INSERT INTO order_items (order_id, product_id, quantity, price)
          VALUES (order3_id, prod5_id, 2, (SELECT price FROM products WHERE id = prod5_id));
        END IF;
        IF prod6_id IS NOT NULL THEN
          INSERT INTO order_items (order_id, product_id, quantity, price)
          VALUES (order3_id, prod6_id, 1, (SELECT price FROM products WHERE id = prod6_id));
        END IF;
      END IF;

      RAISE NOTICE 'Заказы созданы: order1_id=%, order2_id=%, order3_id=%', order1_id, order2_id, order3_id;
    ELSE
      RAISE NOTICE 'Пользователь user не найден';
    END IF;
  END $$;

-- 3. ПЛАТЕЖИ (для завершённых заказов)
INSERT INTO payments (order_id, user_id, amount, payment_date, status)
SELECT o.id, o.user_id, o.total_price, o.order_date + INTERVAL '1 hour', 'COMPLETED'
FROM orders o
WHERE o.status = 'COMPLETED'
  AND NOT EXISTS (SELECT 1 FROM payments p WHERE p.order_id = o.id)
ON CONFLICT DO NOTHING;

-- 4. ОТЗЫВЫ (по 2-3 отзыва на популярные товары)
DO $$
  DECLARE
    v_user_id INT;
    v_admin_id INT;
    v_prod_id INT;
  BEGIN
    SELECT id INTO v_user_id FROM users WHERE username = 'user' LIMIT 1;
    SELECT id INTO v_admin_id FROM users WHERE username = 'admin' LIMIT 1;

    -- Отзыв на MacBook Air
    SELECT id INTO v_prod_id FROM products WHERE name ILIKE '%MacBook Air 15%' LIMIT 1;
    IF v_prod_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM reviews WHERE product_id = v_prod_id AND user_id = v_user_id) THEN
      INSERT INTO reviews (user_id, product_id, rating, comment, review_date)
      VALUES (v_user_id, v_prod_id, 5, 'Отличный ноутбук! Батарея держит почти два дня, экран шикарный, работает тихо. M2 справляется со всем на ура. Рекомендую!', CURRENT_TIMESTAMP - INTERVAL '3 days');
    END IF;

    -- Отзыв на iPhone 15 Pro
    SELECT id INTO v_prod_id FROM products WHERE name ILIKE '%iPhone 15 Pro%' LIMIT 1;
    IF v_prod_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM reviews WHERE product_id = v_prod_id AND user_id = v_user_id) THEN
      INSERT INTO reviews (user_id, product_id, rating, comment, review_date)
      VALUES (v_user_id, v_prod_id, 5, 'Лучший телефон за последние годы. Камера невероятная, титан выглядит дорого. iOS работает плавно. Единственный минус – цена. Но оно того стоит.', CURRENT_TIMESTAMP - INTERVAL '1 day');
    END IF;

    -- Отзыв на Sony WH-1000XM5
    SELECT id INTO v_prod_id FROM products WHERE name ILIKE '%Sony WH-1000XM5%' LIMIT 1;
    IF v_prod_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM reviews WHERE product_id = v_prod_id AND user_id = v_admin_id) THEN
      INSERT INTO reviews (user_id, product_id, rating, comment, review_date)
      VALUES (v_admin_id, v_prod_id, 5, 'Шумоподавление – космос. В метро не слышно ничего. Батареи хватает на неделю. Звук чистый, басы глубокие. Лучшая покупка в этом году.', CURRENT_TIMESTAMP - INTERVAL '5 days');
    END IF;

    -- Отзыв на Samsung Galaxy S24 Ultra
    SELECT id INTO v_prod_id FROM products WHERE name ILIKE '%Samsung Galaxy S24 Ultra%' LIMIT 1;
    IF v_prod_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM reviews WHERE product_id = v_prod_id AND user_id = v_admin_id) THEN
      INSERT INTO reviews (user_id, product_id, rating, comment, review_date)
      VALUES (v_admin_id, v_prod_id, 4, 'Отличный телефон, камера 200 МП – огонь. S Pen удобен. Но очень маркий корпус и тяжеловат. В остальном топ.', CURRENT_TIMESTAMP - INTERVAL '2 days');
    END IF;
  END $$;

-- 5. КОРЗИНА (для пользователя user – 2 товара)
DO $$
  DECLARE
    v_user_id INT;
    v_prod_id INT;
  BEGIN
    SELECT id INTO v_user_id FROM users WHERE username = 'user' LIMIT 1;
    IF v_user_id IS NOT NULL THEN
      SELECT id INTO v_prod_id FROM products WHERE name ILIKE '%ASUS ROG Zephyrus G14%' LIMIT 1;
      IF v_prod_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM shopping_cart WHERE user_id = v_user_id AND product_id = v_prod_id) THEN
        INSERT INTO shopping_cart (user_id, product_id, quantity) VALUES (v_user_id, v_prod_id, 1);
      END IF;

      SELECT id INTO v_prod_id FROM products WHERE name ILIKE '%Xiaomi 14 Ultra%' LIMIT 1;
      IF v_prod_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM shopping_cart WHERE user_id = v_user_id AND product_id = v_prod_id) THEN
        INSERT INTO shopping_cart (user_id, product_id, quantity) VALUES (v_user_id, v_prod_id, 1);
      END IF;
    END IF;
  END $$;

-- 6. ИЗБРАННОЕ (пользователь user добавляет 4 товара)
-- 6. ИЗБРАННОЕ (пользователь user добавляет 4 товара)
DO $$
  DECLARE
    v_user_id INT;
    v_prod_id INT;
  BEGIN
    SELECT id INTO v_user_id FROM users WHERE username = 'user' LIMIT 1;
    IF v_user_id IS NOT NULL THEN
      FOR v_prod_id IN
        SELECT id FROM products
        WHERE name ILIKE '%Apple Watch%'
           OR name ILIKE '%Lenovo ThinkPad%'
           OR name ILIKE '%Samsung Odyssey%'
           OR name ILIKE '%Logitech G502%'
        LIMIT 4
        LOOP
          INSERT INTO user_favorites (user_id, product_id, added_date)
          VALUES (v_user_id, v_prod_id, CURRENT_TIMESTAMP)
          ON CONFLICT DO NOTHING;
        END LOOP;
    END IF;
  END $$;

-- =====================================================
-- 7. БОЛЬШИЕ СТАТЬИ (БЛОГ) — 10 ШТУК, ОБЪЁМНЫЕ
-- =====================================================

-- Статья 1
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'iPhone 15 Pro: полный обзор флагмана 2024',
       'iphone-15-pro-polnyj-obzor',
       '<h2>Дизайн и материалы</h2><p>iPhone 15 Pro получил титановый корпус, что сделало его легче и прочнее. Новые закругленные грани улучшают эргономику. Вес уменьшился на 10% по сравнению с 14 Pro. Доступны цвета: натуральный титан, синий, белый и чёрный. Кнопка действия (Action Button) заменила переключатель беззвучного режима – её можно настроить на любую функцию.</p>
<h2>Дисплей</h2><p>6.1-дюймовый Super Retina XDR с ProMotion (120 Гц) и Always-On Display. Яркость до 2000 нит на улице – изображение отлично видно в солнечный день. Защита Ceramic Shield нового поколения устойчивее к падениям.</p>
<h2>Производительность</h2><p>Чип A17 Pro (3 нм) – первый 3-нм процессор в телефоне. 6-ядерный CPU на 10% быстрее, 6-ядерный GPU на 20% быстрее. Поддержка трассировки лучей в играх (Ray Tracing). 8 ГБ оперативной памяти. В синтетических тестах AnTuTu – более 1,5 млн баллов.</p>
<h2>Камера</h2><p>Основная камера 48 МП (f/1.78) делает 24 МП фото по умолчанию. 2-кратный оптический зум без потери качества. Телеобъектив 12 МП с 3-кратным оптическим зумом. Сверхширик 12 МП с макро. Ночной режим улучшен – шумов меньше, детализация выше. Портреты теперь можно редактировать после съёмки (выбирать фокус). Поддержка ProRAW, Log-видео, возможность записи видео прямо на внешний SSD через USB-C 3.0.</p>
<h2>Автономность и зарядка</h2><p>Время работы до 23 часов видео. USB-C 3.0 (до 10 Гбит/с). Быстрая зарядка 20 Вт (50% за 30 минут). Беспроводная MagSafe до 15 Вт. В комплекте по-прежнему нет зарядного блока – только кабель USB-C.</p>
<h2>Вывод</h2><p>iPhone 15 Pro – идеальный выбор для тех, кто хочет максимальную производительность, отличную камеру и премиальный дизайн. Недостатков почти нет, кроме высокой цены и отсутствия зарядки в комплекте.</p>',
       'Титановый корпус, A17 Pro, 48 МП камера – подробный обзор нового флагмана Apple.',
       'https://www.idolstore.ru/upload/medialibrary/b70/1xlfmx8x696xw9cowiy2ome2ci1ddwnq.jpg',
       'REVIEW', 'PUBLISHED', (SELECT id FROM users WHERE username = 'admin'), CURRENT_TIMESTAMP - INTERVAL '10 days'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'iphone-15-pro-polnyj-obzor');

-- Статья 2
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'Как выбрать ноутбук для работы и игр: полное руководство 2025',
       'kak-vybrat-noutbuk-dlya-raboty-i-igr',
       '<h2>1. Определите свои задачи</h2><p>Для офисной работы и учёбы подойдут ультрабуки с процессором Intel Core i5 / AMD Ryzen 5. Для игр и видеомонтажа нужен i7/Ryzen 7 и дискретная видеокарта. Для программирования достаточно средней производительности, но важно много ОЗУ (от 16 ГБ).</p>
<h2>2. Процессор</h2><p>Intel 13-14 поколения (например, i5-13420H) или AMD Ryzen 7040/8040. Для игр лучше Ryzen 9 или Intel Core i9. Обратите внимание на тепловыделение – игровые процессоры греются сильнее, потребляя больше энергии.</p>
<h2>3. Оперативная память</h2><p>Минимум 16 ГБ в 2025 году, 32 ГБ для профессиональных задач. DDR5 предпочтительнее DDR4 (выше скорость и энергоэффективность). Многие ультрабуки имеют распаянную память – выбирайте с запасом, так как потом не добавить.</p>
<h2>4. Накопитель</h2><p>Только SSD. NVMe PCIe 4.0 даёт скорость 5000+ МБ/с. Объём: от 512 ГБ, лучше 1 ТБ. Проверьте возможность установки второго диска (часто в игровых ноутбуках есть дополнительный слот M.2).</p>
<h2>5. Видеокарта</h2><p>Для игр: RTX 4060 – минимум, RTX 4070/4080 – для 1440p. Для работы (рендеринг, AI) желательна RTX 4080 с 12 ГБ видеопамяти. Для учёбы – встроенной графики достаточно.</p>
<h2>6. Экран</h2><p>Матрица IPS (хорошо) или OLED (отлично, но дороже и есть риск выгорания). Частота 120–165 Гц – для игр и плавного интерфейса. Разрешение от Full HD (1920x1080) до 2.5K. Яркость от 300 нит для комнаты, от 500 нит для улицы.</p>
<h2>7. Вес и автономность</h2><p>Ультрабуки: 1.0–1.5 кг, до 10-12 часов. Игровые: 2.0–2.5 кг, 4-6 часов. Смотрите ёмкость батареи (от 50 Втч).</p>
<h2>8. Порты и охлаждение</h2><p>Желательно USB-C с зарядкой (Power Delivery), HDMI, 2-3 USB-A. Для игр – хорошая система охлаждения (два вентилятора, несколько теплотрубок).</p>',
       'Исчерпывающий гид по выбору ноутбука: процессор, видеокарта, память, экран и другие параметры.',
       'https://mobi-like.com/uploads/blog/6b721f9bd6377d4d5600272ebdcc9b6116-10-2025-20-06.jpg',
       'GUIDE', 'PUBLISHED', (SELECT id FROM users WHERE username = 'admin'), CURRENT_TIMESTAMP - INTERVAL '9 days'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'kak-vybrat-noutbuk-dlya-raboty-i-igr');

-- Статья 3
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'Топ-10 аксессуаров для смартфона, которые реально нужны',
       'top-10-aksessuarov-dlya-smartfona-2025',
       '<ul><li><strong>Беспроводная зарядка</strong> – удобно, не надо втыкать кабель. MagSafe – лучший вариант.</li>
<li><strong>Чехол-книжка</strong> – защита экрана и карт (можно хранить 2-3 пластиковые карты).</li>
<li><strong>Портативный аккумулятор (Power Bank)</strong> – зарядка в дороге. Ёмкость 10000-20000 мАч.</li>
<li><strong>Стабилизатор (гимбал)</strong> – для плавного видео. DJI Osmo Mobile – один из лучших.</li>
<li><strong>Наушники TWS</strong> – свобода от проводов. AirPods Pro, Sony WF-1000XM5.</li>
<li><strong>Стилус</strong> – для заметок и рисования. Universal Capacitive или активные для iPad.</li>
<li><strong>Защитное стекло</strong> – защита от царапин. Лучше с олеофобным покрытием.</li>
<li><strong>Магнитный держатель в авто</strong> – надёжно фиксирует телефон.</li>
<li><strong>Фотобокс для микро-фото</strong> – помогает делать чёткие снимки мелких предметов.</li>
<li><strong>Чехол с подставкой</strong> – для просмотра видео. Особенно удобен для длинных поездок.</li></ul>
<p>Эти аксессуары сделают использование смартфона комфортнее и продят его жизнь. Не экономьте на качестве – дешёвые зарядки могут повредить батарею.</p>',
       '10 полезных аксессуаров для любого смартфона: от защитного стекла до портативной зарядки.',
       'https://yadro.kz/wp-content/uploads/2026/01/TOP-10-aksessuarov-dlya-smartfona.webp',
       'TIPS', 'PUBLISHED', (SELECT id FROM users WHERE username = 'user'), CURRENT_TIMESTAMP - INTERVAL '8 days'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'top-10-aksessuarov-dlya-smartfona-2025');

-- Статья 4
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'Будущее технологий: как ИИ меняет носимые устройства',
       'budushchee-ii-nosimye-ustrojstva',
       '<p>Искусственный интеллект проникает в смарт-часы, фитнес-браслеты и даже умную одежду. Алгоритмы анализируют здоровье, предсказывают заболевания, помогают тренироваться. Новые процессоры с NPU (нейронные блоки) позволяют обрабатывать данные прямо на устройстве без отправки в облако – это повышает конфиденциальность и скорость.</p>
<p>В 2025 году ожидаем прорыв в речевых интерфейсах и дополненной реальности в очках. Уже сейчас Apple Watch Series 9 могут определять падения, измерять уровень кислорода в крови и ЭКГ. В будущем появятся неинвазивные глюкометры и датчики гидратации.</p>
<h3>Что нас ждёт в ближайшие 3-5 лет?</h3>
<ul><li>Персонализированные рекомендации по питанию и спорту на основе ИИ-анализа биометрии.</li>
<li>Автоматический вызов скорой при опасных отклонениях (инсульт, инфаркт).</li>
<li>Нейроинтерфейсы для управления техникой силой мысли – первые коммерческие образцы уже тестируются.</li>
<li>Носимые устройства с гибкими экранами и энергонезависимой памятью.</li></ul>
<p>Будущее уже близко – осталось несколько лет до массового внедрения. Подписывайтесь на наш блог, чтобы не пропустить новости.</p>',
       'Как искусственный интеллект изменит смарт-часы и другие гаджеты в ближайшие годы.',
       'https://icdn.lenta.ru/images/2021/12/27/10/20211227105622818/wide_4_3_e5e87987eb108f2555f3eb6ed70b7ad1.jpg',
       'NEWS', 'PUBLISHED', (SELECT id FROM users WHERE username = 'admin'), CURRENT_TIMESTAMP - INTERVAL '7 days'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'budushchee-ii-nosimye-ustrojstva');

-- Статья 5
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'OLED против QLED: что лучше для дома? Полное сравнение',
       'oled-protiv-qled-chto-luchshe-dlya-doma',
       '<p>OLED обеспечивает идеальный чёрный цвет и бесконечную контрастность, но боится выгорания (burn-in). QLED ярче и дешевле, но чёрный цвет хуже из-за подсветки. Технологии MiniLED и QD-OLED уже размывают границы.</p>
<h2>OLED – плюсы и минусы</h2>
<p><strong>Плюсы:</strong> абсолютно чёрный цвет, шикарная цветопередача, тонкий профиль, быстрый отклик (идеально для игр).<br>
<strong>Минусы:</strong> риск выгорания при статичных элементах (логотипы каналов), максимальная яркость ниже, чем у QLED, выше цена.</p>
<h2>QLED – плюсы и минусы</h2>
<p><strong>Плюсы:</strong> высокая яркость (хорошо для светлых комнат), дешевле, нет риска выгорания, большие диагонали по адекватной цене.<br>
<strong>Минусы:</strong> чёрный цвет не идеальный (эффект засветки), углы обзора хуже.</p>
<h2>Что выбрать?</h2>
<p>Для тёмной комнаты и киномарафонов – OLED. Для светлой гостиной и просмотра новостей / спорта – QLED. Если бюджет позволяет, присмотритесь к QD-OLED – он объединяет преимущества обоих типов.</p>',
       'Сравнение технологий телевизоров: плюсы и минусы OLED и QLED. Какой выбрать в 2025 году?',
       'https://best-magazin.com/image/catalog/NEWS/2023/oled-protiv-qled-chto-vibrat.png',
       'REVIEW', 'PUBLISHED', (SELECT id FROM users WHERE username = 'admin'), CURRENT_TIMESTAMP - INTERVAL '6 days'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'oled-protiv-qled-chto-luchshe-dlya-doma');

-- Статья 6
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'Sony WH-1000XM5: лучшие наушники с шумоподавлением – обзор',
       'sony-wh-1000xm5-obzor-luchshie-naushniki',
       '<h2>Внешний вид и комфорт</h2><p>Наушники стали легче (250 г), но не складываются. Оголовье и амбушюры из мягкой синтетической кожи, часовой пояс не давит даже после 5 часов ношения. Доступны цвета: чёрный и кремовый (бежевый).</p>
<h2>Активное шумоподавление (ANC)</h2><p>Новый процессор QN1 и 8 микрофонов. Noise Cancelling на высшем уровне – подавляет даже звук космической станции (тестировали в метро и самолёте). Режим Ambient Sound с автоматической регулировкой пропускает нужные звуки (объявления, сигналы машин).</p>
<h2>Качество звука</h2><p>Новый драйвер 30 мм, поддержка LDAC (990 кбит/с), 360 Reality Audio. Звук чистый, детальный, с глубокими басами и чёткими верхами. При прослушивании классики инструменты легко различимы.</p>
<h2>Автономность и зарядка</h2><p>До 30 часов с ANC, 40 часов без. Быстрая зарядка: 3 минуты = 3 часа воспроизведения. USB-C + поддержка беспроводной зарядки (опционально – нужен специальный чехол).</p>
<h2>Управление и фишки</h2><p>Сенсорное управление на правой чашке (свайпы, тапы). Функция Speak-to-Chat (автопауза при разговоре), адаптивное шумоподавление (подстраивается под окружение), поддержка голосовых ассистентов (Google, Alexa).</p>
<h2>Вывод</h2><p>Лучшие наушники с шумоподавлением на рынке. Минусы: цена (30 000 ₽) и отсутствие складывания. Но если вы цените тишину и качество звука – берите не раздумывая.</p>',
       'Лучшие наушники с активным шумоподавлением: обзор Sony WH-1000XM5, тест батареи и звука.',
       'https://tehnobzor.ru/wp-content/uploads/2022/06/sony-wh-1000xm5-4.jpg',
       'REVIEW', 'PUBLISHED', (SELECT id FROM users WHERE username = 'user'), CURRENT_TIMESTAMP - INTERVAL '5 days'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'sony-wh-1000xm5-obzor-luchshie-naushniki');

-- Статья 7
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'Как выбрать смарт-часы: полный гид 2025',
       'kak-vybrat-smart-chasy-polnyj-gid',
       '<p>На что обратить внимание при выборе умных часов:</p>
<ul><li><strong>Совместимость с ОС</strong> – Apple Watch работают только с iPhone, остальные – с Android и iOS (но с ограничениями).</li>
<li><strong>Датчики</strong>: пульс, кислород в крови (SpO2), ECG (электрокардиограмма), измерение температуры кожи, GPS (для бега без телефона).</li>
<li><strong>Время работы</strong>: от 1 дня (Apple Watch) до 2 недель (Garmin, Huawei).</li>
<li><strong>Материалы корпуса</strong>: алюминий (лёгкий), нержавейка (прочный), титан (премиум), пластик (дешёвый).</li>
<li><strong>Дополнительно</strong>: наличие eSIM (для звонков без телефона), NFC (оплата), защита от воды (5 ATM для плавания).</li></ul>
<p>Для спорта подойдут Garmin или Polar – они точнее отслеживают активность. Для повседневного использования – Apple Watch или Samsung Galaxy Watch. Не забудьте про ремешки – силикон для тренировок, кожа для офиса, металл для вечеринок.</p>',
       'Советы по выбору умных часов: функции, бренды, цена, датчики. Что важно в 2025 году.',
       'https://topdisc.ru/upload/resize_cache/medialibrary/c20/600_600_1/znx7r1c4iyw8xjeqhgbqcp70eqhi0qt1.jpg',
       'GUIDE', 'PUBLISHED', (SELECT id FROM users WHERE username = 'admin'), CURRENT_TIMESTAMP - INTERVAL '4 days'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'kak-vybrat-smart-chasy-polnyj-gid');

-- Статья 8
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'Xiaomi 14 Ultra – король камеры? Полный обзор',
       'xiaomi-14-ultra-obzor-kamera-zaryadka',
       '<h2>Дизайн</h2><p>Кожаная задняя панель (экокожа), огромный блок камер с выступающим кольцом, толщина 9 мм. В руке лежит уверенно, но тяжеловат – 220 грамм.</p>
<h2>Камера</h2><p>Четыре модуля: 1-дюймовый сенсор Sony IMX989 (50 МП, главный), ультраширик 50 МП, телефото 3x (50 МП) и 5x (50 МП). Leica-фильтры дают неповторимую атмосферу – фото напоминают кадры с плёнки. Ночная съёмка на высоте, портреты – с правильным боке.</p>
<h2>Производительность</h2><p>Snapdragon 8 Gen 3, 16 ГБ оперативной памяти LPDDR5X, 512 ГБ накопителя UFS 4.0 – всё летает. Игры идут на максимальных настройках без троттлинга.</p>
<h2>Автономность и зарядка</h2><p>5000 мАч, 90 Вт проводная зарядка (полностью за 35 минут), 50 Вт беспроводная. В комплекте идёт адаптер на 90 Вт – приятный бонус.</p>
<h2>Вывод</h2><p>Лучший камерофон для энтузиастов, но дорого (90 000 ₽) и тяжело. Если вам нужна лучшая мобильная камера – берите.</p>',
       'Leica-камера, Snapdragon 8 Gen 3, 90 Вт зарядка – главный Android-флагман 2025.',
       'https://tehnoopt.net/images/14ultra.jpg',
       'REVIEW', 'PUBLISHED', (SELECT id FROM users WHERE username = 'admin'), CURRENT_TIMESTAMP - INTERVAL '3 days'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'xiaomi-14-ultra-obzor-kamera-zaryadka');

-- Статья 9
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'Samsung Galaxy S24 Ultra: что нового? Обзор всех инноваций',
       'samsung-galaxy-s24-ultra-chto-novogo',
       '<p>Samsung Galaxy S24 Ultra получил новый дизайн с титановой рамкой (как у iPhone 15 Pro), более яркий экран – до 2600 нит. Искусственный интеллект теперь помогает в обработке фото и текста: функция Circle to Search (обвести объект – и Google найдёт), генеративное редактирование фото (удаление лишних объектов, дорисовка фона).</p>
<p>Камера: 200 МП (f/1.7) с улучшенной стабилизацией, телефото 5x и 10x (оптический зум до 10x, цифровой до 100x). Видео: 8K при 30 fps, замедленная съёмка 4K при 120 fps.</p>
<p>Процессор Snapdragon 8 Gen 3 for Galaxy (разогнанная версия), 12/16 ГБ ОЗУ, One UI 6.1 на Android 14. Аккумулятор 5000 мАч, 45 Вт зарядка. S Pen по-прежнему в комплекте.</p>
<p>Вывод: лучший Android-смартфон для поклонников Samsung, но переплата за ИИ-фишки ощутима.</p>',
       'Все нововведения флагманского смартфона Samsung Galaxy S24 Ultra: обзор характеристик, камеры, ИИ.',
       'https://gsmki.by/image/cache/data/News/s24%20ultra%20rev/Samsung_Galaxy_S24_Ultra_review_00-776x388w.jpg',
       'NEWS', 'PUBLISHED', (SELECT id FROM users WHERE username = 'user'), CURRENT_TIMESTAMP - INTERVAL '2 days'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'samsung-galaxy-s24-ultra-chto-novogo');

-- Статья 10
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
SELECT 'Как продлить жизнь батарее ноутбука: 5 простых советов',
       'kak-prodlit-zhizn-batarei-noutbuka',
       '<ol><li><strong>Не держите ноутбук постоянно на зарядке</strong> – современные литий-ионные батареи оптимально работают при уровне 20-80%. Постоянное нахождение на 100% ускоряет износ.</li>
<li><strong>Избегайте перегрева</strong> – не ставьте ноутбук на мягкие поверхности (диван, подушку). Используйте подставку для охлаждения или чистите вентиляторы раз в год.</li>
<li><strong>Не разряжайте до нуля</strong> – глубокий разряд сокращает срок службы. Старайтесь заряжать при 15-20%.</li>
<li><strong>Используйте режим энергосбережения</strong> – снизьте яркость экрана, отключите ненужные фоновые приложения, отключайте Wi-Fi/Bluetooth, если они не нужны.</li>
<li><strong>Калибруйте батарею раз в 2-3 месяца</strong> – полностью зарядите до 100%, затем полностью разрядите до выключения, после снова зарядите до 100%. Это помогает контроллеру питания точнее оценивать ёмкость.</li></ol>
<p>Соблюдая эти простые правила, вы продлите жизнь аккумулятору на 1-2 года. При необходимости замены обращайтесь в авторизованные сервисные центры.</p>',
       'Простые советы, которые помогут сохранить ёмкость аккумулятора вашего ноутбука надолго.',
       'https://club.dns-shop.ru/api/v1/image/getOriginal/q93_4b73d5dfe7d26ac267e189ff42c7be5e27d28ae6973a839cbca53353769313da.jpg',
       'TIPS', 'PUBLISHED', (SELECT id FROM users WHERE username = 'admin'), CURRENT_TIMESTAMP - INTERVAL '1 day'
WHERE NOT EXISTS (SELECT 1 FROM articles WHERE slug = 'kak-prodlit-zhizn-batarei-noutbuka');

-- =====================================================
-- 8. РЕАКЦИИ НА СТАТЬИ (ЛАЙКИ/ДИЗЛАЙКИ ОТ ПОЛЬЗОВАТЕЛЕЙ)
-- =====================================================
-- 8. РЕАКЦИИ НА СТАТЬИ (ЛАЙКИ/ДИЗЛАЙКИ ОТ ПОЛЬЗОВАТЕЛЕЙ)
DO $$
  DECLARE
    v_user_id INT;
    v_article_rec RECORD;
  BEGIN
    SELECT id INTO v_user_id FROM users WHERE username = 'user' LIMIT 1;
    IF v_user_id IS NOT NULL THEN
      FOR v_article_rec IN (SELECT id FROM articles WHERE status = 'PUBLISHED' LIMIT 8)
        LOOP
          INSERT INTO article_reactions (article_id, user_id, reaction_type, created_at)
          VALUES (v_article_rec.id, v_user_id, 'LIKE', CURRENT_TIMESTAMP - (random() * INTERVAL '5 days'))
          ON CONFLICT DO NOTHING;
        END LOOP;
    END IF;

    SELECT id INTO v_user_id FROM users WHERE username = 'admin' LIMIT 1;
    IF v_user_id IS NOT NULL THEN
      FOR v_article_rec IN (SELECT id FROM articles WHERE status = 'PUBLISHED' OFFSET 2 LIMIT 5)
        LOOP
          INSERT INTO article_reactions (article_id, user_id, reaction_type, created_at)
          VALUES (v_article_rec.id, v_user_id, 'LIKE', CURRENT_TIMESTAMP - (random() * INTERVAL '3 days'))
          ON CONFLICT DO NOTHING;
        END LOOP;

      -- Один дизлайк на первую статью
      SELECT id INTO v_article_rec FROM articles ORDER BY id LIMIT 1;
      IF v_article_rec.id IS NOT NULL THEN
        INSERT INTO article_reactions (article_id, user_id, reaction_type, created_at)
        VALUES (v_article_rec.id, v_user_id, 'DISLIKE', CURRENT_TIMESTAMP - INTERVAL '1 day')
        ON CONFLICT DO NOTHING;
      END IF;
    END IF;

    -- Обновляем счётчики лайков/дизлайков в таблице articles
    UPDATE articles SET likes = (
      SELECT COUNT(*) FROM article_reactions WHERE article_id = articles.id AND reaction_type = 'LIKE'
    );
    UPDATE articles SET dislikes = (
      SELECT COUNT(*) FROM article_reactions WHERE article_id = articles.id AND reaction_type = 'DISLIKE'
    );
  END $$;

-- =====================================================
-- 9. ОБНОВЛЕНИЕ СЧЁТЧИКОВ ПРОСМОТРОВ СТАТЕЙ (случайные числа)
-- =====================================================
UPDATE articles SET views = floor(random() * 1500 + 200) WHERE views = 0;

-- =====================================================
-- 10. ДОБАВЛЯЕМ ЕЩЁ ПАРУ ОТЗЫВОВ ДЛЯ РАЗНООБРАЗИЯ
-- =====================================================

DO $$
  DECLARE
    v_user_id INT;
    v_admin_id INT;
    v_prod_id INT;
  BEGIN
    SELECT id INTO v_user_id FROM users WHERE username = 'user' LIMIT 1;
    SELECT id INTO v_admin_id FROM users WHERE username = 'admin' LIMIT 1;

    -- Отзыв на клавиатуру Razer
    SELECT id INTO v_prod_id FROM products WHERE name ILIKE '%Razer BlackWidow%' LIMIT 1;
    IF v_prod_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM reviews WHERE product_id = v_prod_id AND user_id = v_user_id) THEN
      INSERT INTO reviews (user_id, product_id, rating, comment, review_date)
      VALUES (v_user_id, v_prod_id, 5, 'Шикарная клавиатура! Переключатели очень приятные, подсветка настраивается под любой стиль. Подставка для рук спасает при долгом печатании. Рекомендую всем геймерам.', CURRENT_TIMESTAMP - INTERVAL '10 days');
    END IF;

    -- Отзыв на монитор Samsung Odyssey
    SELECT id INTO v_prod_id FROM products WHERE name ILIKE '%Odyssey G7%' LIMIT 1;
    IF v_prod_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM reviews WHERE product_id = v_prod_id AND user_id = v_admin_id) THEN
      INSERT INTO reviews (user_id, product_id, rating, comment, review_date)
      VALUES (v_admin_id, v_prod_id, 4, 'Отличный 240 Гц монитор, очень плавно всё работает. Но кривизна 1000R подходит не всем – сперва непривычно. В остальном минусов нет.', CURRENT_TIMESTAMP - INTERVAL '12 days');
    END IF;
  END $$;