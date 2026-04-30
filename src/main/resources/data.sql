-- 1. РОЛИ
INSERT INTO roles (name) VALUES ('USER'), ('ADMIN');

-- 2. КАТЕГОРИИ
INSERT INTO categories (name) VALUES
                                ('Ноутбуки'), ('Смартфоны'), ('Телевизоры'), ('Аудиотехника'),
                                ('Игровые товары'), ('Аксессуары'), ('Планшеты'), ('Умный дом'),
                                ('Смарт-часы'), ('Наушники'), ('Мониторы'), ('Клавиатуры'),
                                ('Мыши'), ('Принтеры'), ('Роутеры'), ('Power Bank');

-- 3. БРЕНДЫ
INSERT INTO brands (name) VALUES
                            ('Apple'), ('Samsung'), ('Xiaomi'), ('Lenovo'), ('Sony'), ('LG'),
                            ('Huawei'), ('JBL'), ('Asus'), ('Acer'), ('Microsoft'), ('Dell'),
                            ('HP'), ('Realme'), ('OnePlus'), ('Logitech'), ('Razer'),
                            ('SteelSeries'), ('Google'), ('MSI'), ('Gigabyte');

-- 4. ПОЛЬЗОВАТЕЛИ (ID 1 - user, ID 2 - admin)
INSERT INTO users (username, name, surname, password, email, phone, registration_date, role_id, address) VALUES
                                                                                                           ('user', 'Иван', 'Петров', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOpw7KcI3QHqG', 'user@example.com', '+79991234567', CURRENT_DATE, 1, 'Москва'),
                                                                                                           ('admin', 'Админ', 'Админов', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOpw7KcI3QHqG', 'admin@example.com', '+79999999999', CURRENT_DATE, 2, 'Центр');

-- 5. ТОВАРЫ (50 ШТУК)
-- Группа 1: Ноутбуки (ID 1-10)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, stock_quantity) VALUES
                                                                                                                                                                                           ('MacBook Pro 14 M3', 'Профи.', 1, 1, 185000, 205000, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8', 'M3', '16GB', '512GB', '14.2', '18h', 'Gray', '1.5kg', '1г', 'Кит', 10),
                                                                                                                                                                                           ('ASUS Zephyrus G14', 'Игры.', 1, 9, 155000, 170000, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45', 'R9', '32GB', '1TB', '14', '10h', 'White', '1.6kg', '2г', 'Кит', 5),
                                                                                                                                                                                           ('Dell XPS 13 Plus', 'Дизайн.', 1, 12, 165000, NULL, 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed', 'i7', '16GB', '512GB', '13.4', '12h', 'Silver', '1.2kg', '1г', 'Кит', 8),
                                                                                                                                                                                           ('Lenovo Yoga Slim 7', 'Стиль.', 1, 4, 95000, 105000, 'https://images.unsplash.com/photo-1541807084-5c52b6b3adef', 'R7', '16GB', '1TB', '14.5', '15h', 'Grey', '1.3kg', '1г', 'Кит', 12),
                                                                                                                                                                                           ('Razer Blade 15', 'Мощь.', 1, 17, 280000, 300000, 'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2', 'i9', '32GB', '1TB', '15.6', '8h', 'Black', '2kg', '1г', 'Кит', 4),
                                                                                                                                                                                           ('HP Envy x360', 'Трансф.', 1, 13, 85000, 95000, 'https://images.unsplash.com/photo-1544006659-f0b21f04cb1d', 'R5', '8GB', '512GB', '15.6', '12h', 'Silver', '1.8kg', '1г', 'Кит', 10),
                                                                                                                                                                                           ('MSI Stealth 16', 'Игры.', 1, 20, 215000, NULL, 'https://images.unsplash.com/photo-1603302576837-37561b2e2302', 'i7', '16GB', '1TB', '16', '9h', 'Blue', '1.9kg', '1г', 'Кит', 6),
                                                                                                                                                                                           ('Acer Swift Edge', 'Легкий.', 1, 10, 110000, 120000, 'https://images.unsplash.com/photo-1585338107529-13afc5f02586', 'R7', '16GB', '1TB', '16', '10h', 'Black', '1.1kg', '1г', 'Кит', 15),
                                                                                                                                                                                           ('Huawei MateBook D16', 'Офис.', 1, 7, 72000, 82000, 'https://images.unsplash.com/photo-1510511459019-5dee9954ff92', 'i5', '16GB', '512GB', '16', '11h', 'Gray', '1.7kg', '1г', 'Кит', 20),
                                                                                                                                                                                           ('Surface Laptop 5', 'MS.', 1, 11, 130000, NULL, 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2', 'i5', '8GB', '256GB', '13.5', '17h', 'Sage', '1.2kg', '1г', 'Кит', 7);

-- Группа 2: Смартфоны (ID 11-20)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, stock_quantity) VALUES
                                                                                                                                                                                           ('iPhone 15 Pro Max', 'Титан.', 2, 1, 145000, 160000, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569', 'A17', '8GB', '256GB', '6.7', '4422', 'Titan', '221g', '1г', 'Кит', 30),
                                                                                                                                                                                           ('Samsung S24 Ultra', 'AI.', 2, 2, 120000, 135000, 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf', 'SD 8 Gen 3', '12GB', '512GB', '6.8', '5000', 'Black', '232g', '1г', 'Вьет', 25),
                                                                                                                                                                                           ('Google Pixel 8 Pro', 'Камера.', 2, 19, 95000, 110000, 'https://images.unsplash.com/photo-1696446701796-da61225697cc', 'G3', '12GB', '128GB', '6.7', '5050', 'Blue', '213g', '1г', 'Кит', 15),
                                                                                                                                                                                           ('Xiaomi 13 Ultra', 'Leica.', 2, 3, 105000, NULL, 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c', 'SD 8 Gen 2', '16GB', '512GB', '6.73', '5000', 'Green', '227g', '1г', 'Кит', 12),
                                                                                                                                                                                           ('OnePlus 12', 'Скорость.', 2, 15, 82000, 89000, 'https://images.unsplash.com/photo-1614102073832-030967418971', 'Gen 3', '16GB', '256GB', '6.8', '5400', 'Green', '220g', '1г', 'Кит', 20),
                                                                                                                                                                                           ('Nothing Phone (2)', 'Дизайн.', 2, 3, 68000, 75000, 'https://images.unsplash.com/photo-1690189448552-690562e1050c', '8+ Gen 1', '12GB', '256GB', '6.7', '4700', 'Gray', '201g', '1г', 'Кит', 18),
                                                                                                                                                                                           ('Sony Xperia 1 V', 'Фото.', 2, 5, 115000, NULL, 'https://images.unsplash.com/photo-1610438235354-a6fa55280b5c', 'Gen 2', '12GB', '256GB', '6.5', '5000', 'Black', '187g', '1г', 'Яп', 5),
                                                                                                                                                                                           ('Realme GT 5', '240W.', 2, 14, 52000, 60000, 'https://images.unsplash.com/photo-1598327105666-5b89351aff97', 'Gen 2', '16GB', '512GB', '6.7', '4600', 'Silver', '205g', '1г', 'Кит', 40),
                                                                                                                                                                                           ('Huawei P60 Pro', 'Топ.', 2, 7, 85000, 95000, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9', '8+ Gen 1', '8GB', '256GB', '6.6', '4815', 'Pearl', '200g', '1г', 'Кит', 15),
                                                                                                                                                                                           ('iPhone 15', 'База.', 2, 1, 80000, 90000, 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c', 'A16', '6GB', '128GB', '6.1', '3349', 'Black', '171g', '1г', 'Кит', 50);

-- Группа 3: Наушники (ID 21-30)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, stock_quantity) VALUES
                                                                                                                                                                                           ('Sony WH-1000XM5', 'ANC.', 10, 5, 36000, 42000, 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb', NULL, NULL, NULL, NULL, '30h', 'Black', '250g', '1г', 'Мал', 50),
                                                                                                                                                                                           ('AirPods Pro 2', 'Apple.', 10, 1, 24500, 28000, 'https://images.unsplash.com/photo-1588423770574-91993ca07291', 'H2', NULL, NULL, NULL, '6h', 'White', '5.3g', '1г', 'Кит', 100),
                                                                                                                                                                                           ('Bose QC Ultra', 'Quiet.', 10, 2, 42000, NULL, 'https://images.unsplash.com/photo-1546435770-a3e426da473b', NULL, NULL, NULL, NULL, '24h', 'Black', '250g', '1г', 'Кит', 20),
                                                                                                                                                                                           ('Marshall Major IV', 'Rock.', 10, 5, 15500, 18000, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e', NULL, NULL, NULL, NULL, '80h', 'Brown', '165g', '1г', 'Кит', 35),
                                                                                                                                                                                           ('Sennheiser Momentum 4', 'Sound.', 10, 2, 34000, 39000, 'https://images.unsplash.com/photo-1484704849700-f032a568e944', NULL, NULL, NULL, NULL, '60h', 'White', '293g', '2г', 'Герм', 15),
                                                                                                                                                                                           ('JBL Tune 720BT', 'Bass.', 10, 8, 7500, 9000, 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df', NULL, NULL, NULL, NULL, '76h', 'Blue', '220g', '1г', 'Кит', 40),
                                                                                                                                                                                           ('Beats Studio Pro', 'Style.', 10, 1, 31000, NULL, 'https://images.unsplash.com/photo-1520170350707-b2da59970118', NULL, NULL, NULL, NULL, '40h', 'Navy', '260g', '1г', 'Кит', 25),
                                                                                                                                                                                           ('Sony WF-1000XM5', 'TWS.', 10, 5, 28000, 32000, 'https://images.unsplash.com/photo-1599666505327-7758b44a9985', NULL, NULL, NULL, NULL, '8h', 'Silver', '5.9g', '1г', 'Мал', 30),
                                                                                                                                                                                           ('JBL Charge 5', 'Party.', 4, 8, 15000, 18000, 'https://images.unsplash.com/photo-1608156639585-34a070a04143', NULL, NULL, NULL, NULL, '20h', 'Blue', '960g', '1г', 'Кит', 30),
                                                                                                                                                                                           ('Xiaomi Buds 4 Pro', 'Gold.', 10, 3, 14000, 17000, 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df', NULL, NULL, NULL, NULL, '9h', 'Gold', '5g', '1г', 'Кит', 50);

-- Группа 4: Гейминг (ID 31-40)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, stock_quantity) VALUES
                                                                                                                                                                                           ('PlayStation 5 Slim', 'Sony.', 5, 5, 55000, 62000, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3', 'Custom', '16GB', '1TB', NULL, NULL, 'White', '3.2kg', '1г', 'Кит', 15),
                                                                                                                                                                                           ('Xbox Series X', 'MS.', 5, 11, 58000, NULL, 'https://images.unsplash.com/photo-1605901309584-818e25960a8f', 'Custom', '16GB', '1TB', NULL, NULL, 'Black', '4.4kg', '1г', 'Кит', 10),
                                                                                                                                                                                           ('Nintendo Switch OLED', 'Nint.', 5, 11, 35000, 39000, 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e', 'Tegra', '4GB', '64GB', '7', '9h', 'White', '320g', '1г', 'Кит', 20),
                                                                                                                                                                                           ('Logitech G502 Hero', 'Mouse.', 13, 16, 7500, 9000, 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7', NULL, NULL, NULL, NULL, NULL, 'Black', '121g', '2г', 'Кит', 80),
                                                                                                                                                                                           ('Razer BlackWidow V4', 'Keyb.', 12, 17, 18000, 21000, 'https://images.unsplash.com/photo-1595225476474-87563907a212', NULL, NULL, NULL, NULL, NULL, 'Black', '1.1kg', '2г', 'Кит', 30),
                                                                                                                                                                                           ('SteelSeries Apex Pro', 'Fast.', 12, 18, 22000, 25000, 'https://images.unsplash.com/photo-1511467687858-23d96c32e4ae', NULL, NULL, NULL, NULL, NULL, 'Black', '1kg', '2г', 'Кит', 10),
                                                                                                                                                                                           ('Steam Deck OLED', 'Valve.', 5, 20, 65000, 75000, 'https://images.unsplash.com/photo-1683478440316-d309081e7d08', 'APU', '16GB', '512GB', '7.4', '12h', 'Black', '640g', '1г', 'Кит', 8),
                                                                                                                                                                                           ('Keychron K3', 'Mech.', 12, 16, 11000, 13000, 'https://images.unsplash.com/photo-1511467687858-23d96c32e4ae', NULL, NULL, NULL, NULL, '34h', 'Grey', '400g', '1г', 'Кит', 40),
                                                                                                                                                                                           ('MSI MAG274QRF', 'Monitor.', 11, 20, 42000, NULL, 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf', NULL, NULL, NULL, '27', NULL, 'Black', '6kg', '3г', 'Кит', 12),
                                                                                                                                                                                           ('Logitech G Pro X 2', 'Audio.', 5, 16, 26000, 30000, 'https://images.unsplash.com/photo-1583394838336-acd977730f90', NULL, NULL, NULL, NULL, '50h', 'White', '345g', '2г', 'Кит', 20);

-- Группа 5: ТВ и Прочее (ID 41-50)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage, display, battery, color, weight, warranty, country, stock_quantity) VALUES
                                                                                                                                                                                           ('iPad Pro 12.9 M2', 'Tab.', 7, 1, 118000, 130000, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0', 'M2', '8GB', '128GB', '12.9', '10h', 'Gray', '682g', '1г', 'Кит', 12),
                                                                                                                                                                                           ('Samsung Tab S9 Ultra', 'giant.', 7, 2, 110000, NULL, 'https://images.unsplash.com/photo-1585792180666-f7347c490ee2', 'SD 8 Gen 2', '12GB', '512GB', '14.6', '12h', 'Gray', '732g', '1г', 'Вьет', 8),
                                                                                                                                                                                           ('LG C3 55 OLED', 'TV.', 3, 6, 145000, 165000, 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1', 'A9', NULL, NULL, '55', NULL, 'Silver', '16kg', '1г', 'Пол', 5),
                                                                                                                                                                                           ('Apple Watch 9', 'Watch.', 9, 1, 42000, 48000, 'https://images.unsplash.com/photo-1546868871-70ca48370f65', 'S9', NULL, '64GB', 'OLED', '18h', 'Midnight', '32g', '1г', 'Кит', 40),
                                                                                                                                                                                           ('Samsung Watch 6', 'Classic.', 9, 2, 32000, 38000, 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1', 'W930', NULL, '16GB', 'OLED', '40h', 'Silver', '52g', '1г', 'Вьет', 25),
                                                                                                                                                                                           ('Xiaomi Pad 6', 'Best.', 7, 3, 38000, 45000, 'https://images.unsplash.com/photo-1589739900243-4b52cd9b104e', 'SD 870', '8GB', '256GB', '11', '14h', 'Gold', '490g', '1г', 'Кит', 25),
                                                                                                                                                                                           ('Xiaomi Band 8', 'Fit.', 9, 3, 4500, 5500, 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6', NULL, NULL, NULL, '1.62', '16d', 'Black', '27g', '6м', 'Кит', 100),
                                                                                                                                                                                           ('Samsung QN90C', 'TV.', 3, 2, 135000, NULL, 'https://images.unsplash.com/photo-1509281373149-e957c6296406', NULL, NULL, NULL, '55', NULL, 'Silver', '17kg', '1г', 'Вьет', 7),
                                                                                                                                                                                           ('Sony BRAVIA A80L', 'OLED.', 3, 5, 175000, 195000, 'https://images.unsplash.com/photo-1593784991095-a205069470b6', NULL, NULL, NULL, '55', NULL, 'Black', '18kg', '2г', 'Яп', 4),
                                                                                                                                                                                           ('Huawei Watch GT 4', 'Steel.', 9, 7, 21000, NULL, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30', NULL, NULL, NULL, 'AMOLED', '14d', 'Steel', '48g', '1г', 'Кит', 50);

-- 6. ГАЛЕРЕЯ (По 4 фото на товар)
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, file_url, TRUE, 0 FROM products;

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://images.unsplash.com/photo-1531297484001-80022131f5a1', FALSE, 1 FROM products;

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://images.unsplash.com/photo-1498050108023-c5249f4df085', FALSE, 2 FROM products;

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
SELECT id, 'https://images.unsplash.com/photo-1519389950473-47ba0277781c', FALSE, 3 FROM products;

-- 7. ЗАКАЗЫ (DATEADD)
INSERT INTO orders (user_id, order_date, status, total_price, address, delivery_method, payment_method) VALUES
                                                                                                          (1, DATEADD('DAY', -20, CURRENT_TIMESTAMP), 'COMPLETED', 330000.00, 'Москва', 'Курьер', 'Карта'),
                                                                                                          (1, DATEADD('DAY', -5, CURRENT_TIMESTAMP), 'PROCESSING', 78000.00, 'Москва', 'Самовывоз', 'Наличные');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
                                                                  (1, 1, 1, 185000.00),
                                                                  (1, 11, 1, 145000.00),
                                                                  (2, 41, 1, 42000.00),
                                                                  (2, 21, 1, 36000.00);

-- 8. ПЛАТЕЖИ И ОТЗЫВЫ (DATEADD)
INSERT INTO payments (order_id, user_id, amount, payment_date, status) VALUES
  (1, 1, 330000.00, DATEADD('DAY', -19, CURRENT_TIMESTAMP), 'COMPLETED');

INSERT INTO reviews (user_id, product_id, rating, comment, review_date) VALUES
                                                                          (1, 1, 5, 'Шикарно!', DATEADD('DAY', -3, CURRENT_TIMESTAMP)),
                                                                          (1, 11, 5, 'Топ камера.', DATEADD('DAY', -1, CURRENT_TIMESTAMP)),
                                                                          (2, 21, 5, 'Лучший звук.', DATEADD('DAY', -5, CURRENT_TIMESTAMP));

-- 9. СТАТЬИ (DATEADD)
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
                                                                                                                 ('Обзор iPhone 15 Pro', 'iphone-15-review', 'Текст обзора...', 'Титановый флагман.', 'https://www.idolstore.ru/upload/medialibrary/b70/1xlfmx8x696xw9cowiy2ome2ci1ddwnq.jpg', 'REVIEW', 'PUBLISHED', 2, DATEADD('DAY', -10, CURRENT_TIMESTAMP)),
                                                                                                                 ('Выбор ноутбука 2025', 'laptop-guide', 'Текст гида...', 'Советы.', 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853', 'GUIDE', 'PUBLISHED', 2, DATEADD('DAY', -9, CURRENT_TIMESTAMP));

-- 10. РЕАКЦИИ И СЧЕТЧИКИ (RAND)
INSERT INTO article_reactions (article_id, user_id, reaction_type) VALUES (1, 1, 'LIKE'), (2, 1, 'LIKE');



-- =====================================================
-- ПОЛНЫЕ СТАТЬИ ДЛЯ БЛОГА (10 ШТУК)
-- =====================================================

-- Статья 1: iPhone 15 Pro - полный обзор
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('iPhone 15 Pro: полный обзор флагмана 2024',
   'iphone-15-pro-polnyj-obzor',
   '<h2>Дизайн и материалы</h2>
  <p>iPhone 15 Pro получил титановый корпус, что сделало его легче и прочнее. Новые закругленные грани улучшают эргономику. Вес уменьшился на 10% по сравнению с 14 Pro. Доступны цвета: натуральный титан, синий, белый и чёрный. Кнопка действия (Action Button) заменила переключатель беззвучного режима – её можно настроить на любую функцию: открыть камеру, включить фонарик, запустить голосовую заметку или выполнить любую команду через Shortcuts.</p>

  <h2>Дисплей</h2>
  <p>6.1-дюймовый Super Retina XDR с ProMotion (120 Гц) и Always-On Display. Яркость до 2000 нит на улице – изображение отлично видно даже в солнечный день. Защита Ceramic Shield нового поколения устойчивее к падениям. Always-On Display показывает время, уведомления и виджеты, при этом частота обновления снижается до 1 Гц для экономии энергии. Контрастность 2 000 000:1, поддержка HDR и Dolby Vision.</p>

  <h2>Производительность</h2>
  <p>Чип A17 Pro (3 нм) – первый 3-нм процессор в телефоне. 6-ядерный CPU на 10% быстрее, 6-ядерный GPU на 20% быстрее. Поддержка трассировки лучей в играх (Ray Tracing) – теперь игры выглядят почти как на консолях. 8 ГБ оперативной памяти. В синтетических тестах AnTuTu – более 1,5 млн баллов. Нейронный движок 16 ядер выполняет 35 триллионов операций в секунду. Благодаря новому чипу появилась поддержка USB-C 3.0 со скоростью до 10 Гбит/с.</p>

  <h2>Камера</h2>
  <p>Основная камера 48 МП (f/1.78) делает 24 МП фото по умолчанию – идеальный баланс между детализацией и размером файла. 2-кратный оптический зум без потери качества (кроп с 48 МП сенсора). Телеобъектив 12 МП с 3-кратным оптическим зумом. Сверхширик 12 МП (120°) с макро режимом. Ночной режим улучшен – шумов меньше, детализация выше благодаря новому алгоритму Deep Fusion. Портреты теперь можно редактировать после съёмки (выбирать фокус и регулировать глубину резкости). Поддержка ProRAW (для профессиональной обработки), Log-видео (для цветокоррекции), возможность записи видео прямо на внешний SSD через USB-C 3.0. Добавлена возможность записи пространственного видео для просмотра на Apple Vision Pro.</p>

  <h2>Автономность и зарядка</h2>
  <p>Время работы до 23 часов воспроизведения видео. USB-C 3.0 (до 10 Гбит/с). Быстрая зарядка 20 Вт (50% за 30 минут). Беспроводная MagSafe до 15 Вт с новыми магнитными аксессуарами. В комплекте по-прежнему нет зарядного блока – только кабель USB-C. Qi2 совместимость для зарядки с любыми MagSafe-аксессуарами сторонних производителей.</p>

  <h2>Связь и новые функции</h2>
  <p>5G (Sub-6 и mmWave), Wi-Fi 6E, Bluetooth 5.3, сверхширокополосный чип U2 (улучшенная точность定位). Спутниковый вызов экстренной помощи теперь работает и без активного сотового сигнала (Roadside Assistance через спутник). Функция Precision Finding для поиска друзей с помощью дополненной реальности.</p>

  <h2>Вывод</h2>
  <p>iPhone 15 Pro – идеальный выбор для тех, кто хочет максимальную производительность, отличную камеру и премиальный дизайн. Титан, USB-C, 48 МП камера, A17 Pro – всё это делает его лучшим iPhone на сегодня. Недостатков почти нет, кроме высокой цены и отсутствия зарядки в комплекте. Но если бюджет позволяет – однозначно стоит брать. Приобрести iPhone 15 Pro вы можете в нашем магазине по лучшей цене.</p>',
   'Титановый корпус, A17 Pro, 48 МП камера – подробный обзор нового флагмана Apple. Рассказываем о всех нововведениях, производительности, камерах и автономности.',
   'https://www.idolstore.ru/upload/medialibrary/b70/1xlfmx8x696xw9cowiy2ome2ci1ddwnq.jpg',
   'REVIEW', 'PUBLISHED', 2, DATEADD('DAY', -10, CURRENT_TIMESTAMP));

-- Статья 2: Как выбрать ноутбук
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('Как выбрать ноутбук для работы и игр: полное руководство 2025',
   'kak-vybrat-noutbuk-dlya-raboty-i-igr',
   '<h2>1. Определите свои задачи</h2>
  <p>Для офисной работы и учёбы подойдут ультрабуки с процессором Intel Core i5 / AMD Ryzen 5. Для игр и видеомонтажа нужен i7/Ryzen 7 и дискретная видеокарта. Для программирования достаточно средней производительности, но важно много ОЗУ (от 16 ГБ). Для дизайнеров и архитекторов – важна цветопередача экрана (минимум 95% sRGB) и наличие дискретной видеокарты.</p>

  <h2>2. Процессор</h2>
  <p>Intel 13-14 поколения (например, i5-13420H, i7-13700H) или AMD Ryzen 7040/8040 серии. Для игр лучше Ryzen 9 или Intel Core i9. Новые процессоры Intel Core Ultra имеют встроенный NPU для задач ИИ. Обратите внимание на тепловыделение – игровые процессоры греются сильнее, потребляя больше энергии. Для ультрабуков лучше выбирать процессоры с литерой U (низкое энергопотребление) – например, i7-1355U.</p>

  <h2>3. Оперативная память</h2>
  <p>Минимум 16 ГБ в 2025 году, 32 ГБ для профессиональных задач (видеомонтаж, виртуальные машины). DDR5 предпочтительнее DDR4 (выше скорость и энергоэффективность). Частота DDR5 от 4800 МГц, а DDR4 от 3200 МГц. Многие ультрабуки имеют распаянную память – выбирайте с запасом, так как потом не добавить. В игровых ноутбуках чаще всего есть слоты для апгрейда.</p>

  <h2>4. Накопитель</h2>
  <p>Только SSD. NVMe PCIe 4.0 даёт скорость 5000+ МБ/с, PCIe 5.0 даёт до 12000 МБ/с, но пока дорого. Объём: от 512 ГБ, лучше 1 ТБ. Проверьте возможность установки второго диска (часто в игровых ноутбуках есть дополнительный слот M.2). Для хранения файлов можно использовать внешний SSD.</p>

  <h2>5. Видеокарта</h2>
  <p>Для игр: RTX 4060 – минимум для 1080p, RTX 4070/4080 – для 1440p, RTX 4090 – для 4K. Для работы (рендеринг, AI) желательна RTX 4080 с 12 ГБ видеопамяти или RTX 4090 с 16 ГБ. Для учёбы – встроенной графики Intel Arc или AMD Radeon 700M достаточно. Новые видеокарты RTX 40 серии поддерживают DLSS 3.5 с генерацией кадров, что увеличивает FPS в играх.</p>

  <h2>6. Экран</h2>
  <p>Матрица IPS (хорошо, углы обзора 178°) или OLED (отлично, но дороже и есть риск выгорания). Частота 120–165 Гц – для игр и плавного интерфейса, ультрабукам достаточно 60-90 Гц. Разрешение: от Full HD (1920x1080) до 2.5K (2560x1600). Яркость от 300 нит для комнаты, от 500 нит для улицы. Для работы с цветом важна заводская калибровка и охват цветовых пространств (sRGB, DCI-P3).</p>

  <h2>7. Вес и автономность</h2>
  <p>Ультрабуки: 1.0–1.5 кг, до 10-12 часов работы. Игровые ноутбуки: 2.0–2.5 кг, 4-6 часов работы. Смотрите ёмкость батареи (от 50 Втч). Для долгих поездок важна поддержка быстрой зарядки – например, 65 Вт через USB-C заряжает ноутбук до 70% за час.</p>

  <h2>8. Порты и охлаждение</h2>
  <p>Желательно USB-C с зарядкой (Power Delivery), HDMI 2.1 (для подключения мониторов 4K@120Hz), 2-3 USB-A (для мыши и флешки), разъём для наушников 3.5 мм. Для игр – хорошая система охлаждения (два вентилятора, несколько теплотрубок). Наличие Thunderbolt 4 для Mac и премиальных Windows-ноутбуков даёт возможность подключения нескольких мониторов 4K и внешних видеокарт.</p>

  <h2>9. Дополнительные функции</h2>
  <p>Сканер отпечатка пальца (для быстрого входа), ИК-камера с Windows Hello (разблокировка по лицу), подсветка клавиатуры (обязательна для работы в темноте), возможность апгрейда (замена ОЗУ и SSD). Сейчас всё больше моделей предлагают 4G/5G-модемы для постоянного доступа в интернет.</p>

  <h2>Заключение</h2>
  <p>Мы подготовили для вас таблицу рекомендаций:</p>
  <ul><li><strong>Для учёбы и офиса</strong>: ASUS Vivobook, Lenovo IdeaPad, HP Pavilion</li>
  <li><strong>Для программистов</strong>: Apple MacBook Pro, Dell XPS, Lenovo ThinkPad</li>
  <li><strong>Для дизайнеров</strong>: Apple MacBook Pro, MSI Creator, ASUS ProArt</li>
  <li><strong>Для геймеров</strong>: ASUS ROG, MSI GE, Lenovo Legion</li></ul>
  <p>При выборе также учитывайте бренд и сервисный центр в вашем городе. В интернет-магазине «ТехноШок» представлены все популярные модели ноутбуков, вы можете сравнить характеристики и выбрать лучший вариант по цене.</p>',
   'Исчерпывающий гид по выбору ноутбука: процессор, видеокарта, память, экран, вес, автономность и другие параметры. Советы для разных задач.',
   'https://mobi-like.com/uploads/blog/6b721f9bd6377d4d5600272ebdcc9b6116-10-2025-20-06.jpg',
   'GUIDE', 'PUBLISHED', 2, DATEADD('DAY', -9, CURRENT_TIMESTAMP));

-- Статья 3: Топ-10 аксессуаров
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('Топ-10 аксессуаров для смартфона, которые реально нужны',
   'top-10-aksessuarov-dlya-smartfona-2025',
   '<h2>1. Беспроводная зарядка</h2>
  <p>Удобно – не надо каждый раз втыкать кабель. MagSafe – лучший вариант, так как магниты обеспечивают идеальное позиционирование. Мощность 15 Вт для iPhone и 30 Вт для Android. Цена: 1500-4000 ₽. Рекомендуем модели от Belkin, Anker и Samsung.</p>

  <h2>2. Чехол-книжка</h2>
  <p>Защита экрана и карт (можно хранить 2-3 пластиковые карты). Кожаные модели выглядят премиально и не скользят в руке. Некоторые чехлы имеют подставку для просмотра видео. Цена: 800-3000 ₽.</p>

  <h2>3. Портативный аккумулятор (Power Bank)</h2>
  <p>Зарядка в дороге. Ёмкость 10000-20000 мАч – хватит на 2-3 полных зарядки. Ищите модели с USB-C Power Delivery (быстрая зарядка до 65 Вт) и цифровым дисплеем. Компактные модели (20000 мАч) можно брать в самолёт. Цена: 1500-6000 ₽. Смотрите на Anker PowerCore, Xiaomi Mi Power Bank, Samsung.</p>

  <h2>4. Стабилизатор (гимбал)</h2>
  <p>Для плавного видео. DJI Osmo Mobile 6 – один из лучших. Автоматическое отслеживание объекта (ActiveTrack), встроенный штатив, поддержка фирменных приложений. Встроенный аккумулятор на 10 часов работы. Цена: 8000-15000 ₽.</p>

  <h2>5. Наушники TWS</h2>
  <p>Свобода от проводов. AirPods Pro 2 (идеальная интеграция с iPhone), Sony WF-1000XM5 (лучшее шумоподавление), Samsung Galaxy Buds2 Pro (лучшие для Samsung), Xiaomi Buds 4 Pro (бюджетный вариант). Обратите внимание на поддержку кодеков AAC, LDAC, aptX Adaptive. Цена: 5000-25000 ₽.</p>

  <h2>6. Стилус</h2>
  <p>Для заметок и рисования. Universal Capacitive (работает на любом экране, но без чувствительности к нажатию) или активные для iPad (Apple Pencil), Samsung S Pen (идут в комплекте с Galaxy S Ultra и Tab). Активные стилусы имеют до 4096 уровней давления и поддержку наклона. Цена: 500-15000 ₽.</p>

  <h2>7. Защитное стекло</h2>
  <p>Защита от царапин. Лучше с олеофобным покрытием (не собирает отпечатки) и 9H твёрдостью. Ударопрочные стёкла могут спасти экран при падении. Есть модели с функцией приватности – затемняют экран под углом. Цена: 300-2000 ₽.</p>

  <h2>8. Магнитный держатель в авто</h2>
  <p>Надёжно фиксирует телефон. Совместим с MagSafe или использует металлическую пластину. Важно выбирать с мощными магнитами, чтобы телефон не падал на кочках. Цена: 800-3000 ₽.</p>

  <h2>9. Фотобокс для микро-фото</h2>
  <p>Помогает делать чёткие снимки мелких предметов (ювелирка, еда для блогов). Подсветка 3-4 цветовых температур, встроенный диффузор для мягкого света. Цена: 1000-4000 ₽.</p>

  <h2>10. Чехол с подставкой</h2>
  <p>Для просмотра видео. Особенно удобен для длинных поездок. Подставка может быть встроенной в корпус или выдвижной. Некоторые чехлы имеют кольцо-держатель для пальца – удобно для селфи и предотвращает падения. Цена: 500-2000 ₽.</p>

  <h2>Заключение</h2>
  <p>Эти аксессуары сделают использование смартфона комфортнее и продлят его жизнь. Не экономьте на самых важных (защитное стекло, зарядка) – дешёвые зарядки могут повредить батарею, а плохие стёкла могут не защитить экран. В нашем магазине вы найдёте все эти аксессуары от проверенных производителей по лучшим ценам.</p>',
   '10 полезных аксессуаров для любого смартфона: от защитного стекла до портативной зарядки. Что действительно нужно, а без чего можно обойтись?',
   'https://yadro.kz/wp-content/uploads/2026/01/TOP-10-aksessuarov-dlya-smartfona.webp',
   'TIPS', 'PUBLISHED', 1, DATEADD('DAY', -8, CURRENT_TIMESTAMP));

-- Статья 4: ИИ в носимых устройствах
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('Будущее технологий: как ИИ меняет носимые устройства',
   'budushchee-ii-nosimye-ustrojstva',
   '<p>Искусственный интеллект проникает в смарт-часы, фитнес-браслеты и даже умную одежду. Алгоритмы анализируют здоровье, предсказывают заболевания, помогают тренироваться. Новые процессоры с NPU (нейронные блоки) позволяют обрабатывать данные прямо на устройстве без отправки в облако – это повышает конфиденциальность и скорость.</p>

  <p>В 2025 году ожидаем прорыв в речевых интерфейсах и дополненной реальности в очках. Уже сейчас Apple Watch Series 9 могут определять падения, измерять уровень кислорода в крови и ЭКГ на основе ИИ-алгоритмов. Samsung Galaxy Watch 6 анализирует фазы сна и даёт персонализированные рекомендации. Garmin использует ИИ для оценки восстановления после тренировок.</p>

  <h3>Как ИИ меняет здоровье:</h3>
  <ul>
  <li><strong>Предсказание заболеваний</strong> – алгоритмы анализируют пульс, давление и другие показатели, чтобы предупредить о риске гипертонии, диабета или аритмии за несколько дней до симптомов.</li>
  <li><strong>Мониторинг стресса</strong> – анализ вариабельности сердечного ритма, определение уровня кортизола, дыхательные упражнения с обратной связью.</li>
  <li><strong>Персонализированные тренировки</strong> – ИИ корректирует план нагрузок в реальном времени, подбирает упражнения под уровень подготовки, даёт советы по технике через акселерометр.</li>
  <li><strong>Раннее обнаружение инфекций</strong> – анализ температуры кожи и частоты дыхания; новые алгоритмы могут выявлять COVID-19 и грипп за день до появления симптомов.</li>
  <li><strong>Контроль приёма лекарств</strong> – напоминания на основе пульса и других показателей; интеграция с приложениями телемедицины.</li>
  </ul>

  <h3>Что нас ждёт в ближайшие 3-5 лет?</h3>
  <ul>
  <li><strong>Неинвазивные глюкометры</strong> – измерения сахара через кожу без проколов (Apple уже работает над этой технологией).</li>
  <li><strong>Датчики гидратации</strong> – определение уровня воды в организме, напоминание пить воду.</li>
  <li><strong>Имплантируемые чипы</strong> – непрерывный мониторинг здоровья, автоматический вызов скорой при инсульте или инфаркте. Уже проводятся клинические испытания.</li>
  <li><strong>Нейроинтерфейсы</strong> – управление техникой силой мысли; первые коммерческие образцы уже тестируются Neuralink и другими компаниями.</li>
  <li><strong>Умная одежда</strong> – футболки и носки со встроенными датчиками для мониторинга здоровья спортсменов и пожилых людей.</li>
  <li><strong>ИИ-ассистенты</strong> – полноценные голосовые помощники в часах, которые могут отвечать на звонки, делать переводы в реальном времени и даже шутить.</li>
  </ul>

  <p>Производители уже анонсировали первые модели умных очков с ИИ для синхронного перевода речи и распознавания объектов – Google Glass Enterprise Edition 3, Meta Ray-Ban Stories с ИИ-камерой. Такие устройства будут полезны туристам, бизнесменам и слабослышащим людям.</p>

  <p>Однако есть и вызовы: вопросы приватности (кто имеет доступ к данным о нашем здоровье), энергопотребление (ИИ-чипы пока довольно прожорливы), стандартизация данных (чтобы разные устройства могли обмениваться информацией). Регуляторы по всему миру уже начинают разрабатывать законы для контроля ИИ в медицине.</p>

  <p>Будущее уже близко – осталось несколько лет до массового внедрения этих технологий. Подписывайтесь на наш блог, чтобы не пропустить новости. А пока вы можете приобрести современные смарт-часы в нашем интернет-магазине – они уже сегодня помогут вам лучше понимать своё здоровье.</p>',
   'Как искусственный интеллект изменит смарт-часы и другие гаджеты в ближайшие годы. Мониторинг здоровья, предсказание болезней, нейроинтерфейсы и умная одежда.',
   'https://icdn.lenta.ru/images/2021/12/27/10/20211227105622818/wide_4_3_e5e87987eb108f2555f3eb6ed70b7ad1.jpg',
   'NEWS', 'PUBLISHED', 2, DATEADD('DAY', -7, CURRENT_TIMESTAMP));

-- Статья 5: OLED vs QLED
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('OLED против QLED: что лучше для дома? Полное сравнение',
   'oled-protiv-qled-chto-luchshe-dlya-doma',
   '<p>Выбор между OLED и QLED телевизором – одна из самых частых дилемм покупателей. Рассказываем все плюсы и минусы, чтобы вы могли принять взвешенное решение.</p>

  <h2>OLED – плюсы и минусы</h2>
  <p><strong>Плюсы:</strong><br>
  - Идеальный чёрный цвет (пиксели полностью отключаются) – контрастность стремится к бесконечности<br>
  - Шикарная цветопередача (100% DCI-P3, поддержка Dolby Vision и HDR10+)<br>
  - Тонкий профиль (телевизоры могут быть толщиной всего 4 мм)<br>
  - Быстрый отклик (0.1 мс) – идеально для игр, нет размытия в динамичных сценах<br>
  - Широкие углы обзора (до 178° без потери цвета и контраста)</p>
  <p><strong>Минусы:</strong><br>
  - Риск выгорания при статичных элементах (логотипы каналов, новостные строки, элементы HUD в играх)<br>
  - Максимальная яркость ниже, чем у QLED (700-900 нит против 1500-2000 нит у QLED)<br>
  - Выше цена (на 20-40% дороже QLED аналогичной диагонали)<br>
  - Деградация синих пикселей со временем (после 3-5 лет активного использования)</p>

  <h2>QLED – плюсы и минусы</h2>
  <p><strong>Плюсы:</strong><br>
  - Высокая яркость (хорошо для светлых комнат, окна не мешают)<br>
  - Дешевле (оптимальное соотношение цена/качество)<br>
  - Нет риска выгорания – можно смотреть новости, играть в игры со статичным HUD без опасений<br>
  - Большие диагонали по адекватной цене (85 дюймов за 200-300 тысяч рублей)<br>
  - Современные модели с Mini LED подсветкой имеют тысячи зон затемнения, приближаясь к OLED по контрасту</p>
  <p><strong>Минусы:</strong><br>
  - Чёрный цвет не идеальный (эффект засветки, особенно на тёмных сценах)<br>
  - Углы обзора хуже (цвета и контраст искажаются при взгляде сбоку)<br>
  - Более толстые из-за слоя подсветки (3-5 см)<br>
  - Возможны проблемы с равномерностью подсветки (эффект «грязного экрана» – DSE)</p>

  <h2>Что выбрать?</h2>
  <h3>Для тёмной комнаты и киномарафонов – OLED</h3>
  <p>Если вы смотрите фильмы преимущественно в темноте (вечером или в комнате с плотными шторами), OLED даст лучшую картинку. Идеальный чёрный и бесконечный контраст особенно заметны в тёмных сценах – например, космос, ночные города, хорроры.</p>

  <h3>Для светлой гостиной и просмотра новостей / спорта – QLED</h3>
  <p>Если телевизор стоит в комнате с большими окнами, QLED будет ярче и не будет бликовать. Для просмотра телеканалов с логотипами и бегущими строками лучше выбрать QLED – не будет риска выгорания. Спортивные трансляции также выигрывают из-за высокой яркости.</p>

  <h3>Для игр – смотрите на приоритеты</h3>
  <p>Для консольных игр (PS5, Xbox Series) с поддержкой 4K/120Hz и VRR – OLED выдаёт лучшую картинку благодаря мгновенному отклику. Но для длительных игровых сессий со статичным HUD (полоски здоровья, миникарты) лучше присмотреться к QLED – нет риска выгорания. В любом случае, ищите телевизоры с поддержкой HDMI 2.1, ALLM и Game Mode.</p>

  <h3>Промежуточное решение – QD-OLED</h3>
  <p>Если бюджет позволяет, присмотритесь к QD-OLED – он объединяет преимущества обоих типов. Квантовые точки улучшают яркость QLED и цветопередачу OLED, а подсветка на уровне пикселей даёт идеальный чёрный. Отсутствие риска выгорания благодаря использованию квантовых точек. Основной минус – высокая цена.</p>

  <h2>Рекомендации по выбору</h2>
  <ul><li><strong>Бюджет до 50 000 ₽</strong> – берите QLED, OLED в этом сегменте слишком бюджетные и быстро выгорят.</li>
  <li><strong>Бюджет 50 000 - 100 000 ₽</strong> – хорошие QLED с Mini LED подсветкой или бюджетный OLED (например, LG B серия).</li>
  <li><strong>Бюджет от 100 000 ₽</strong> – смотрите QD-OLED (Sony, Samsung) или топовый OLED (LG G серия, Panasonic).</li></ul>

  <p>В интернет-магазине «ТехноШок» представлены лучшие модели телевизоров как на OLED, так и на QLED матрицах. Приходите выбирать, наши консультанты помогут определиться.</p>',
   'Сравнение технологий телевизоров: плюсы и минусы OLED и QLED. Какой выбрать в 2025 году? Идеальный чёрный против высокой яркости. Что лучше для дома?',
   'https://best-magazin.com/image/catalog/NEWS/2023/oled-protiv-qled-chto-vibrat.png',
   'REVIEW', 'PUBLISHED', 2, DATEADD('DAY', -6, CURRENT_TIMESTAMP));

-- Статья 6: Sony WH-1000XM5 обзор
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('Sony WH-1000XM5: лучшие наушники с шумоподавлением – обзор',
   'sony-wh-1000xm5-obzor-luchshie-naushniki',
   '<h2>Внешний вид и комфорт</h2>
  <p>Наушники стали легче (250 г), но не складываются – это главный компромисс новой модели. Оголовье стало более массивным, с мягкой синтетической кожей и поролоном с эффектом памяти. Амбушюры из мягкой пены с эффектом памяти, очень мягкие и приятные на ощупь, не давят даже после 5 часов ношения. Доступны цвета: чёрный (универсальный) и кремовый/бежевый (Silver). Шарниры металлические, регулировка размера плавная, общее качество сборки отличное – ничего не скрипит, не люфтит.</p>

  <h2>Активное шумоподавление (ANC)</h2>
  <p>Новый процессор V1 + QN1 и 8 микрофонов (4 на каждой чашке). Noise Cancelling на высшем уровне – подавляет даже звук двигателя самолёта и шум метро. Частоты до 50 Гц глушатся эффективнее, чем у конкурентов. Шумоподавление автоматически подстраивается под окружение (атмосферное давление, ветер, уровень шума). Режим Ambient Sound с автоматической регулировкой пропускает нужные звуки (объявления в аэропорту, сигналы машин на дороге). При этом вы можете говорить, не снимая наушники – функция Speak-to-Chat автоматически ставит музыку на паузу.</p>

  <h2>Качество звука</h2>
  <p>Новый драйвер 30 мм из углеродного волокна, поддержка LDAC (990 кбит/с) – это почти lossless качество. Возможность отключения DSEE Extreme (апскейлинг сжатого аудио). Поддержка 360 Reality Audio для объёмного звука (особенно заметно на живых записях и оркестровой музыке). Звук чистый, детальный, с глубокими басами (они не перекрывают другие частоты) и чёткими верхами. Сцена широкая, инструменты легко различимы. По умолчанию эквалайзер нейтральный, но в приложении можно настроить под свой вкус – есть готовые пресеты (Bass Boost, Treble Boost, Vocal).</p>

  <h2>Автономность и зарядка</h2>
  <p>До 30 часов с включённым ANC (40 часов без ANC) – хватит на трансатлантический перелёт. Быстрая зарядка: 3 минуты = 3 часа воспроизведения – удобно, если забыли зарядить перед выходом. Полная зарядка через USB-C занимает 3.5 часа. Поддержка беспроводной зарядки Qi (опционально – нужен специальный чехол или Qi-коврик). На корпусе есть индикатор уровня заряда.</p>

  <h2>Управление и фишки</h2>
  <p>Сенсорное управление на правой чашке (свайпы вверх/вниз – громкость, влево/вправо – треки, тап – пауза/ответ на звонок, двойной тап – пропуск). Функция Speak-to-Chat (автопауза при разговоре) – наушники распознают ваш голос и ставят музыку на паузу, возобновляют через 30 секунд после окончания разговора. Адаптивное шумоподавление – наушники сами подстраиваются под окружение (например, усиливают шумоподавление в метро и ослабляют на улице). Поддержка голосовых ассистентов – Google Assistant и Amazon Alexa (настройка через приложение). Есть датчик ношения – если снять наушники, музыка автоматически приостановится. Функция Multipoint – можно подключиться к двум устройствам одновременно (например, ноутбук и телефон).</p>

  <h2>Приложение Sony Headphones Connect</h2>
  <p>В приложении можно настроить эквалайзер, включить адаптивное шумоподавление, настроить Multipoint, обновить прошивку и даже измерить форму ушей для персонализации 360 Reality Audio. Приложение интуитивно понятное, на русском языке.</p>

  <h2>Вывод</h2>
  <p>Лучшие наушники с шумоподавлением на рынке на сегодняшний день. Они отлично подходят для частых перелётов, работы в открытых офисах и просто для погружения в музыку. Минусы: высокая цена (около 30 000 – 35 000 ₽), отсутствие складывания (чехол стал громоздким, наушники не поместятся в маленькую сумку). Но если вы цените тишину и качество звука – берите не раздумывая. Если хотите сэкономить – обратите внимание на WH-1000XM4 (почти такие же по качеству, но складываются).</p>',
   'Лучшие наушники с активным шумоподавлением: обзор Sony WH-1000XM5. Тест батареи, качества звука, эффективности шумоподавления и вызов конкурентам.',
   'https://tehnobzor.ru/wp-content/uploads/2022/06/sony-wh-1000xm5-4.jpg',
   'REVIEW', 'PUBLISHED', 1, DATEADD('DAY', -5, CURRENT_TIMESTAMP));

-- Статья 7: Как выбрать смарт-часы
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('Как выбрать смарт-часы: полный гид 2025',
   'kak-vybrat-smart-chasy-polnyj-gid',
   '<p>На что обратить внимание при выборе умных часов? Делимся полным гайдом, чтобы вы не ошиблись с выбором.</p>

  <h2>1. Совместимость с ОС</h2>
  <p>Apple Watch работают ТОЛЬКО с iPhone – это их главное ограничение. Android Wear, Samsung Galaxy Watch, Garmin, Huawei, Amazfit работают и с Android, и с iOS (но часть функций может быть недоступна). Например, ответ на сообщения с часов возможен только на телефонах той же экосистемы. Если у вас iPhone – ваш выбор ограничен Apple Watch и Garmin, но у последних не будет полной интеграции (отвечать на сообщения не получится). Если Android – выбор огромен: Samsung, Xiaomi, Huawei, Google Pixel Watch.</p>

  <h2>2. Датчики и медицинские функции</h2>
  <ul>
  <li><strong>Пульсокардиограмма (ECG)</strong> – обнаружение аритмии и мерцательной аритмии. Есть у Apple Watch (начиная с Series 4), Samsung Galaxy Watch (с Active 2), Withings.</li>
  <li><strong>Кислород в крови (SpO2)</strong> – особенно полезно для спортсменов и при коронавирусе. Нормальный уровень: 95-100%.</li>
  <li><strong>Температура кожи</strong> – отслеживание цикла у женщин, раннее обнаружение инфекций. Есть у Apple Watch Series 8/9, Samsung Galaxy Watch 5/6, Oura Ring.</li>
  <li><strong>Датчик стресса</strong> – анализ вариабельности сердечного ритма (HRV). Чем выше вариабельность, тем лучше восстановление.</li>
  <li><strong>GPS</strong> – для бега и велоспорта без телефона. Важно для трекинга маршрутов и точного измерения дистанции.</li>
  <li><strong>Акселерометр и гироскоп</strong> – определение падений (важно для пожилых людей), подсчёт шагов, отслеживание сна (фазы сна: лёгкий, глубокий, REM).</li>
  </ul>

  <h2>3. Время работы</h2>
  <ul>
  <li><strong>Apple Watch</strong> – около 1 дня (18 часов). Нужно заряжать каждый вечер. Более новые модели (Ultra) держат до 3 дней.</li>
  <li><strong>Samsung Galaxy Watch 6</strong> – 2-3 дня (при активном использовании) или до 40 часов постоянно включённого дисплея.</li>
  <li><strong>Huawei Watch GT 4</strong> – до 14 дней (без AOD) и до 8 дней (с постоянно включённым дисплеем). Отличная автономность.</li>
  <li><strong>Garmin (спортивные)</strong> – 7-14 дней в умном режиме, до 80 часов с GPS.</li>
  <li><strong>Amazfit GTR 4</strong> – до 14 дней, зарядка за час.</li>
  </ul>
  <p>Если вы не хотите постоянно думать о зарядке – выбирайте модели от Huawei, Amazfit, Garmin. Если вам нужен максимум функций и интеграция – Apple Watch или Samsung.</p>

  <h2>4. Материалы корпуса и дизайн</h2>
  <ul>
  <li><strong>Алюминий</strong> – самый лёгкий, бюджетный (Apple Watch SE, Series 9). Бывает матовый.</li>
  <li><strong>Нержавеющая сталь</strong> – прочный, зеркальный, дороже (Apple Watch с Stainless).</li>
  <li><strong>Титан</strong> – максимальная прочность, лёгкий, очень дорогой (Apple Watch Ultra).</li>
  <li><strong>Пластик / поликарбонат</strong> – бюджетные модели, легче, но менее премиально (Amazfit Bip).</li>
  <li><strong>Керамика</strong> – царапиноустойчивая, но хрупкая (была у Apple Watch Edition).</li>
  </ul>
  <p>Для спорта лучше взять алюминий или пластик (с силиконовым ремешком). Для офиса и вечеринок подойдёт сталь или титан (кожаный или металлический ремешок). Многие часы поддерживают быструю смену ремешков – можно менять под любой стиль.</p>

  <h2>5. Дополнительные функции</h2>
  <ul>
  <li><strong>eSIM</strong> – возможность звонить без телефона, слушать музыку через Spotify, стримить подкасты. Поддержка есть у Apple Watch Cellular, Samsung Galaxy Watch LTE, Huawei Watch eSIM. Нужна поддержка оператора.</li>
  <li><strong>NFC</strong> – бесконтактная оплата (Apple Pay, Google Pay, Samsung Pay). Работает везде, где есть терминал.</li>
  <li><strong>Защита от воды</strong> – 5 ATM (50 метров) для плавания, 10 ATM (100 метров) для дайвинга. Большинство часов имеют защиту от брызг, некоторые (Garmin) выдерживают глубоководное погружение.</li>
  <li><strong>Встроенный динамик и микрофон</strong> – приём звонков с часов, голосовые ответы, Siri/Google Assistant.</li>
  <li><strong>Яркий AMOLED экран</strong> – для лучшей читаемости на солнце и экономии энергии (у Apple Watch – LTPO OLED, поддерживает Always-On Display).</li>
  </ul>

  <h2>6. Рекомендации по брендам</h2>
  <ul><li><strong>Для iPhone</strong> – только Apple Watch (лучшая интеграция, экосистема). Альтернатива – Garmin (для спорта).</li>
  <li><strong>Для Android</strong> – Samsung Galaxy Watch (премиум), Xiaomi/Huawei (бюджет), Amazfit (средний сегмент).</li>
  <li><strong>Для спорта</strong> – Garmin, Polar, Suunto. У них профессиональные датчики, долгое время работы, навигация и карты.</li>
  <li><strong>Для повседневного использования</strong> – Galaxy Watch 6, Apple Watch Series 9/Ultra, Xiaomi Watch 2 Pro.</li>
  <li><strong>Для детей и пожилых</strong> – детские смарт-часы с GPS-трекером (Aimoto, Elari), модели с кнопкой SOS и мониторингом давления для пожилых (Huawei Watch D).</li></ul>

  <h2>Заключение</h2>
  <p>Выбирайте часы, исходя из вашего телефона, необходимых функций и стиля жизни. Не забудьте про ремешки – силикон для тренировок, кожа для офиса, металл для вечеринок. В интернет-магазине «ТехноШок» представлены популярные модели от всех производителей. Наши консультанты помогут подобрать идеальный вариант под ваш бюджет и задачи.</p>',
   'Советы по выбору умных часов: функции, бренды, цена, датчики здоровья. Что важно в 2025 году? Совместимость, автономность, дизайн.',
   'https://topdisc.ru/upload/resize_cache/medialibrary/c20/600_600_1/znx7r1c4iyw8xjeqhgbqcp70eqhi0qt1.jpg',
   'GUIDE', 'PUBLISHED', 2, DATEADD('DAY', -4, CURRENT_TIMESTAMP));

-- Статья 8: Xiaomi 14 Ultra обзор
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('Xiaomi 14 Ultra – король камеры? Полный обзор',
   'xiaomi-14-ultra-obzor-kamera-zaryadka',
   '<h2>Дизайн</h2>
  <p>Кожаная задняя панель (экокожа) – очень приятная на ощупь, не скользит, не собирает отпечатки. Огромный блок камер с  выступающим кольцом и золотистой окантовкой, толщина 9 мм. В руке лежит уверенно, но тяжеловат – 220 грамм. Рамка из алюминия, есть защита от воды IP68. Доступные цвета: чёрный, белый и синий.</p>

  <h2>Камера</h2>
  <p>Четыре модуля от Leica:<br>
  - 1-дюймовый сенсор Sony IMX989 (50 МП, главная, f/1.8) – огромный физический размер даёт невероятную светосилу и размытие фона<br>
  - Ультраширик 50 МП (f/1.8, 122°) – режим Macro для съёмки объектов с 5 см<br>
  - Телефото 3x (50 МП, оптический зум 3x, эквивалент 75 мм)<br>
  - Телефото 5x (50 МП, перископный, оптический зум 5x, эквивалент 120 мм) – цифровой зум до 200x</p>
  <p>Leica-фильтры дают неповторимую атмосферу – фото напоминают кадры с плёнки. Ночная съёмка на высоте, шумов почти нет благодаря большой апертуре и алгоритмам Leica. Портреты – с правильным боке и идеальным разделением переднего и заднего планов. Zoom до 120 мм позволяет снимать удалённые объекты без потери качества. Поддержка видео 8K при 30 fps, 4K при 60 fps, замедленная съёмка 1080p при 960 fps.</p>

  <h2>Производительность</h2>
  <p>Snapdragon 8 Gen 3 – 4-нм процессор, до 20% быстрее предыдущего. 16 ГБ оперативной памяти LPDDR5X, 512 ГБ накопителя UFS 4.0 – всё летает. Игры идут на максимальных настройках без троттлинга (Fairchild), но корпус нагревается несильно благодаря большой испарительной камере. Any и PUBG Mobile держат стабильные 90-120 FPS. В бенчмарках AnTuTu – 2.1 млн баллов.</p>

  <h2>Автономность и зарядка</h2>
  <p>5000 мАч аккумулятор, 90 Вт проводная зарядка (полностью за 35 минут) – приятно, не нужно ждать. 50 Вт беспроводная зарядка (за 50 минут). В комплекте идёт мощный адаптер на 90 Вт и кабель USB-C – приятный бонус в отличие от Apple и Samsung. Есть обратная беспроводная зарядка (10 Вт) для наушников и других телефонов. Батареи хватает на день активного использования (экран до 6-7 часов).</p>

  <h2>Дисплей</h2>
  <p>6.73-дюймовый AMOLED LTPO (1-120 Гц) – адаптивная частота экономит энергию. Разрешение WQHD+ (3200x1440), пиковая яркость до 3000 нит – отлично видно на солнце. Защита Gorilla Glass Victus 2. Поддержка HDR10+, Dolby Vision. Цветопередача отличная, есть калибровка от Leica – приятные естественные цвета без перенасыщения.</p>

  <h2>Программное обеспечение и остальное</h2>
  <p>HyperOS (на базе Android 14) – быстрая и плавная, обновления безопасности 4 года. Есть ИК-порт для управления техникой (телевизоры, кондиционеры). Стереодинамики с поддержкой Dolby Atmos – громкие и чистые. Сканер отпечатка под экраном (оптический) реагирует быстро. Есть поддержка eSIM.</p>

  <h2>Вывод</h2>
  <p>Лучший камерофон для энтузиастов, который действительно может заменить компактную камеру. Но дорого (около 90 000 – 100 000 ₽) и тяжело (220 грамм). Если вам нужна лучшая мобильная камера с фирменной Leica-обработкой – берите Xiaomi 14 Ultra. Альтернативы – Samsung S24 Ultra (более универсальный) и iPhone 15 Pro Max (лучшее видео).</p>',
   'Leica-камера, Snapdragon 8 Gen 3, 90 Вт зарядка – главный Android-флагман 2025. Полный обзор камер, производительности и автономности.',
   'https://tehnoopt.net/images/14ultra.jpg',
   'REVIEW', 'PUBLISHED', 2, DATEADD('DAY', -3, CURRENT_TIMESTAMP));

-- Статья 9: Samsung Galaxy S24 Ultra обзор
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('Samsung Galaxy S24 Ultra: что нового? Обзор всех инноваций',
   'samsung-galaxy-s24-ultra-chto-novogo',
   '<p>Samsung Galaxy S24 Ultra получил новый дизайн с титановой рамкой (как у iPhone 15 Pro), более яркий экран – до 2600 нит. Искусственный интеллект теперь помогает в обработке фото и текста: функция Circle to Search (обвести объект на экране – и Google найдёт), генеративное редактирование фото (удаление лишних объектов, дорисовка недостающих деталей фона).</p>

  <h2>Камера</h2>
  <p>Основная: 200 МП (f/1.7) с улучшенной оптической стабилизацией, делает 12 МП фото по умолчанию с пиксельным биннингом. Телефото 5x (50 МП) и 10x (10 МП) – оптический зум до 10x, качественный цифровой до 100x. Сверхширик 12 МП с автофокусом. Видео: 8K при 30 fps с поддержкой HDR, замедленная съёмка 4K при 120 fps. Ночной режим теперь может использоваться на всех объективах. Портретный режим с возможностью симуляции диафрагмы f/1.4-f/2.4.</p>
  <p>Новые ИИ-фишки: <br>
  - Предложение оптимального кадра при съёмке<br>
  - Замена фона на видео в реальном времени (Zoom Anyplace)<br>
  - Улучшение текстур в зуме (Zoom Enhancer)<br>
  - Запись 120 fps в 4K для плавного slow-mo</p>

  <h2>Производительность</h2>
  <p>Процессор Snapdragon 8 Gen 3 for Galaxy (разогнанная версия, частоты до 3.4 ГГц), 12/16 ГБ оперативной памяти LPDDR5X. One UI 6.1 на Android 14 с 7 годами обновлений безопасности. Игровой режим AI Game Booster подстраивает частоты под игру, экономит заряд. В троттлинг-тесте не теряет производительность даже через час нагрузок.</p>

  <h2>Экран и S Pen</h2>
  <p>6.8-дюймовый Dynamic AMOLED 2X (QHD+, 3120x1440), 1-120 Гц адаптивная частота обновления. Пиковая яркость 2600 нит, контрастность бесконечная. Защита Gorilla Glass Armor – ещё более прочная. S Pen по-прежнему в комплекте! Владельцы оценят Air Actions для управления презентациями или камерой на расстоянии, возможность рисования и заметок, выделение текста и быстрые команды (воздушные жесты).</p>

  <h2>Аккумулятор и зарядка</h2>
  <p>5000 мАч, 45 Вт зарядка (полная за 1 час). Беспроводная 15 Вт (включая обратную). Батарея держит день при активном использовании (экран до 8 часов). Поддержка Fast Wireless Charging 2.0.</p>

  <h2>Искусственный интеллект в One UI 6.1</h2>
  <p>Live Translate – перевод звонков в реальном времени, поддерживает 13 языков. Chat Assist – ИИ подбирает тон сообщений при ответах на электронную почту и в мессенджерах. Note Assist – структурирование записей в Samsung Notes, автоматическое создание резюме и обложек. Transcript Assist – транскрипция голосовых заметок с выделением ключевых моментов.</p>
  <p>Circle to Search – обведи объект на экране, и Google найдёт информацию, не переключая приложения. Работает на любом контенте: фото, видео, тексте, даже если экран заблокирован.</p>

  <h2>Дополнительные функции</h2>
  <p>Поддержка спутниковой связи для экстренных случаев (SOS через спутник). Wi-Fi 7, Bluetooth 5.3, UWB для точной геолокации. Емкость аккумулятора 5000 мАч, зарядка 45 Вт (USB 3.2 Gen 1).</p>

  <h2>Вывод</h2>
  <p>Лучший Android-смартфон для поклонников Samsung. Титановая рамка, S Pen, 200 МП камера и передовые ИИ-функции делают его идеальным инструментом для профессионалов и энтузиастов. Минусы: высокая цена (120 000 – 150 000 ₽) и переплата за ИИ-фишки ощутима. Если вам нужен просто хороший смартфон, можно рассмотреть S24+ или прошлогодний S23 Ultra – они тоже отличные, но дешевле.</p>',
   'Все нововведения флагманского смартфона Samsung Galaxy S24 Ultra: обзор характеристик, камеры 200 МП, ИИ-функций, производительности и S Pen.',
   'https://gsmki.by/image/cache/data/News/s24%20ultra%20rev/Samsung_Galaxy_S24_Ultra_review_00-776x388w.jpg',
   'NEWS', 'PUBLISHED', 1, DATEADD('DAY', -2, CURRENT_TIMESTAMP));

-- Статья 10: Как продлить жизнь батарее ноутбука
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at) VALUES
  ('Как продлить жизнь батарее ноутбука: 5 простых советов',
   'kak-prodlit-zhizn-batarei-noutbuka',
   '<ol>
  <li><strong>Не держите ноутбук постоянно на зарядке</strong> – современные литий-ионные батареи оптимально работают при уровне 20-80%. Постоянное нахождение на 100% ускоряет износ. Если вы используете ноутбук как стационарный, установите лимит зарядки через ПО производителя (Lenovo Vantage, ASUS Battery Health Charging, Dell Power Manager).</li>
  <li><strong>Избегайте перегрева</strong> – не ставьте ноутбук на мягкие поверхности (диван, подушку) – это блокирует вентиляцию. Используйте подставку для охлаждения или чистите вентиляторы раз в полгода. Идеальная температура для аккумулятора – 15-25°C, при 40°C срок службы сокращается в 2 раза.</li>
  <li><strong>Не разряжайте до нуля</strong> – глубокий разряд сокращает срок службы. Старайтесь заряжать при 15-20%. Калибровка батареи (полный разряд до 0% и заряд до 100%) нужна раз в 2-3 месяца только для калибровки контроллера, а не для продления жизни.</li>
  <li><strong>Используйте режим энергосбережения</strong> – снизьте яркость экрана (до 50-70%), отключите ненужные фоновые приложения, отключайте Wi-Fi и Bluetooth, если они не нужны. В Windows есть режим «Экономия заряда», на Mac – режим «Энергосбережение». Новые ноутбуки на Windows 11 имеют режим Battery Saver, который отключает фоновую синхронизацию и снижает частоту процессора.</li>
  <li><strong>Калибруйте батарею раз в 2-3 месяца</strong> – полностью зарядите до 100%, затем полностью разрядите до автоматического выключения (это важно для точной работы контроллера питания), после снова зарядите до 100%. Это помогает контроллеру питания точнее оценивать реальную ёмкость и избегать ложных отключений. Не делайте это чаще – изнашиваете батарею.</li>
  <li><strong>Храните правильно</strong> – если не планируете использовать ноутбук несколько недель/месяцев, храните батарею заряженной на 40-60% при комнатной температуре. При 0% батарея может глубоко разрядиться и не включиться, при 100% – быстрее потеряет ёмкость.</li>
  </ol>
  <p><strong>Бонус-совет: обновляйте прошивку BIOS/драйверов</strong> – производители часто улучшают алгоритмы управления питанием, что может продлить жизнь батареи на 10-15%.</p>
  <p>Соблюдая эти простые правила, вы продлите жизнь аккумулятору на 1-2 года (средний срок службы Li-ion – 3-4 года или 500-1000 циклов заряда). При необходимости замены обращайтесь в авторизованные сервисные центры – замена батареи в ноутбуке стоит 3000-8000 ₽ в зависимости от модели.</p>',
   'Простые советы, которые помогут сохранить ёмкость аккумулятора вашего ноутбука надолго. Правильная зарядка, температура, хранение и калибровка. Не дайте батарее умереть раньше времени!',
   'https://club.dns-shop.ru/api/v1/image/getOriginal/q93_4b73d5dfe7d26ac267e189ff42c7be5e27d28ae6973a839cbca53353769313da.jpg',
   'TIPS', 'PUBLISHED', 2, DATEADD('DAY', -1, CURRENT_TIMESTAMP));

UPDATE articles a SET a.likes = (SELECT COUNT(*) FROM article_reactions r WHERE r.article_id = a.id AND r.reaction_type = 'LIKE');
UPDATE articles SET views = CAST(RAND() * 1000 AS INT) + 100;

