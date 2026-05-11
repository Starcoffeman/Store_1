-- 1. РОЛИ
INSERT INTO roles (name)
VALUES ('USER'),
       ('ADMIN');

-- 2. КАТЕГОРИИ
INSERT INTO categories (name)
VALUES ('Ноутбуки'),
       ('Смартфоны'),
       ('Телевизоры'),
       ('Аудиотехника'),
       ('Игровые товары'),
       ('Аксессуары'),
       ('Планшеты'),
       ('Умный дом'),
       ('Смарт-часы'),
       ('Наушники'),
       ('Мониторы'),
       ('Клавиатуры'),
       ('Мыши'),
       ('Принтеры'),
       ('Роутеры'),
       ('Power Bank');

-- 3. БРЕНДЫ
INSERT INTO brands (name)
VALUES ('Apple'),
       ('Samsung'),
       ('Xiaomi'),
       ('Lenovo'),
       ('Sony'),
       ('LG'),
       ('Huawei'),
       ('JBL'),
       ('Asus'),
       ('Acer'),
       ('Microsoft'),
       ('Dell'),
       ('HP'),
       ('Realme'),
       ('OnePlus'),
       ('Logitech'),
       ('Razer'),
       ('SteelSeries'),
       ('Google'),
       ('MSI'),
       ('Gigabyte');

-- 4. ПОЛЬЗОВАТЕЛИ (ID 1 - user, ID 2 - admin)
INSERT INTO users (username, name, surname, password, email, phone, registration_date, role_id, address)
VALUES ('user', 'Иван', 'Петров', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOpw7KcI3QHqG', 'user@example.com',
        '+79991234567', CURRENT_DATE, 1, 'Москва'),
       ('admin', 'Админ', 'Админов', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOpw7KcI3QHqG',
        'admin@example.com', '+79999999999', CURRENT_DATE, 2, 'Центр');

-- Создание пользователя-администратора (если нужно добавить ещё одного)
INSERT INTO users (username, name, surname, password, email, phone, registration_date, role_id, address)
VALUES ('admin2', -- username
        'Сергей', -- name
        'Иванов', -- surname
        '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOpw7KcI3QHqG', -- password (пароль: "password")
        'sergey@admin.com', -- email
        '+79998887766', -- phone
        CURRENT_DATE, -- registration_date
        2, -- role_id (2 = ADMIN, 1 = USER)
        'Санкт-Петербург' -- address
       );

-- 5. ТОВАРЫ (50 ШТУК)
-- Группа 1: Ноутбуки (ID 1-10)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage,
                      display, battery, color, weight, warranty, country, stock_quantity)
VALUES ('MacBook Pro 14 M3', 'Профи.', 1, 1, 185000, 205000,
        'https://c.dns-shop.ru/thumb/st1/fit/0/0/d653150a5d92ec80e94750a3af8cc3a8/7fb49886aea7ba96b869deef5303519cceb5e8cacf074d7595c50231cbfd009a.jpg.webp',
        'M3', '16GB', '512GB', '14.2', '18h', 'Gray',
        '1.5kg', '1г', 'Кит', 10),
       ('ASUS Zephyrus G14', 'Игры.', 1, 9, 155000, 170000,
        'https://c.dns-shop.ru/thumb/st1/fit/300/300/70906875e9dfbd422de7df1b01fa5940/6a5611edabc38db962213daaf0affb5ee9111344033a1cb7f525bbbf02a6dd35.jpg.webp', 'R9', '32GB', '1TB', '14', '10h', 'White',
        '1.6kg', '2г', 'Кит', 5),
       ('Dell XPS 13 Plus', 'Дизайн.', 1, 12, 165000, NULL,
        'https://cdn.citilink.ru/GDXuV1wmtkQTcB9WMRQYIFvG6I9JlTYcpL9R3mvTOb0/resizing_type:fit/gravity:sm/width:400/height:400/plain/product-images/be251ab7-d7c6-48c4-8e8d-3c6461d78aa8.jpg', 'i7', '16GB', '512GB', '13.4', '12h', 'Silver',
        '1.2kg', '1г', 'Кит', 8),
       ('Lenovo Yoga Slim 7', 'Стиль.', 1, 4, 95000, 105000,
        'https://static.insales-cdn.com/r/L-hQu6hv6i0/rs:fit:1000:0:1/plain/images/products/1/6259/1007687795/2025-04-26_11-50-24.png@png', 'R7', '16GB', '1TB', '14.5', '15h', 'Grey',
        '1.3kg', '1г', 'Кит', 12),
       ('Razer Blade 15', 'Мощь.', 1, 17, 280000, 300000,
        'https://cdn.citilink.ru/UL52G1-_CH2xbJVmxJ1AJScjlPtJbYnTL7mXEdC7XOE/resizing_type:fit/gravity:sm/width:400/height:400/plain/product-images/0e64f092-1141-463c-8020-b7803e44e299.jpg', 'i9', '32GB', '1TB', '15.6', '8h', 'Black',
        '2kg', '1г', 'Кит', 4),
       ('HP Envy x360', 'Трансф.', 1, 13, 85000, 95000, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/02f0470cfdb5874a982f7aba5f4df3d0/597b3ce0dde3761fb0877e417197eb5bf75318ba63c75967786a7df187e7f0a5.jpg.webp',
        'R5', '8GB', '512GB', '15.6', '12h', 'Silver', '1.8kg', '1г', 'Кит', 10),
       ('MSI Stealth 16', 'Игры.', 1, 20, 215000, NULL, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/62e25f3ceba11d7456840754724ef5b2/79e119815c61df8a5eee92369feeab110f6f06a0265c3d7ac1377a5542799cf1.jpg.webp',
        'i7', '16GB', '1TB', '16', '9h', 'Blue', '1.9kg', '1г', 'Кит', 6),
       ('Acer Swift Edge', 'Легкий.', 1, 10, 110000, 120000,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/a71a94ffc34b129c949211a106646c4d/cd662bbbd4562ef19aba22f95cc49f3bd5c3ff6dc5e4aa1eadb0f38d2c766453.png.webp', 'R7', '16GB', '1TB', '16', '10h', 'Black',
        '1.1kg', '1г', 'Кит', 15),
       ('Huawei MateBook D16', 'Офис.', 1, 7, 72000, 82000,
        'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/a20a08d11a4195d3606d657894fbe12b/f8c1d514292bd887b7279a1fa5f26692c8c70e6dd1ca86b6a8a7b3a4f4b6b0bd.jpg.webp', 'i5', '16GB', '512GB', '16', '11h', 'Gray',
        '1.7kg', '1г', 'Кит', 20),
       ('Surface Laptop 5', 'MS.', 1, 11, 130000, NULL, 'https://avatars.mds.yandex.net/get-mpic/5234464/2a00000194f24b4f47f0a10b153fda022140/optimize',
        'i5', '8GB', '256GB', '13.5', '17h', 'Sage', '1.2kg', '1г', 'Кит', 7);

-- Группа 2: Смартфоны (ID 11-20)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage,
                      display, battery, color, weight, warranty, country, stock_quantity)
VALUES ('iPhone 15 Pro Max', 'Титан.', 2, 1, 145000, 160000,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/181951125c576d8b27159bdc64683cfa/08de377a334a375eeea526e445142e522659d533e9f6c41955a6bcfc53f8beff.jpg.webp', 'A17', '8GB', '256GB', '6.7', '4422', 'Titan',
        '221g', '1г', 'Кит', 30),
       ('Samsung S24 Ultra', 'AI.', 2, 2, 120000, 135000,
        'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/7e6666b709d71427aa189f8e2150c722/7bb18f6f859063ef21e86697f97589ab7bc609973e205108183e29b0bb173c8b.jpg.webp', 'SD 8 Gen 3', '12GB', '512GB', '6.8', '5000',
        'Black', '232g', '1г', 'Вьет', 25),
       ('Google Pixel 8 Pro', 'Камера.', 2, 19, 95000, 110000,
        'https://c.dns-shop.ru/thumb/st4/fit/500/500/9b893b6ed1ce1fa2805df55c6d420fbd/7c732ab63ff0cacea590cb38ae774f00462eec74c469143abd24d34a510e4f9e.jpg.webp', 'G3', '12GB', '128GB', '6.7', '5050', 'Blue',
        '213g', '1г', 'Кит', 15),
       ('Xiaomi 13 Ultra', 'Leica.', 2, 3, 105000, NULL, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/f046cfd5f6ab22de750f986430c7cd1c/2c2c1118729a1f12afb65429fe349cf0b63daf8fc95ae65217a00c656d852095.jpg.webp',
        'SD 8 Gen 2', '16GB', '512GB', '6.73', '5000', 'Green', '227g', '1г', 'Кит', 12),
       ('OnePlus 12', 'Скорость.', 2, 15, 82000, 89000, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/23d0283d0a9da0b871ff03914c2e1a38/a6366186a4d3a528c169a0f05ac580a5b034926fe66b2df559416f23a8db61d9.jpg.webp',
        'Gen 3', '16GB', '256GB', '6.8', '5400', 'Green', '220g', '1г', 'Кит', 20),
       ('Nothing Phone (2)', 'Дизайн.', 2, 3, 68000, 75000,
        'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/efe615e5cb74cf73b2f754894b87dddb/68fe4404f7e3dac01f1d1c2abccd863e7cc647749968aaac3750a6fd7682077c.jpg.webp', '8+ Gen 1', '12GB', '256GB', '6.7', '4700',
        'Gray', '201g', '1г', 'Кит', 18),
       ('Sony Xperia 1 V', 'Фото.', 2, 5, 115000, NULL, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/77e3a8145184c8a2140ffcc8dfd22042/2f8119f29e9b78791b6fc4144109c6d9bd2866dac66dbd57d628256dedcf8f40.jpg.webp',
        'Gen 2', '12GB', '256GB', '6.5', '5000', 'Black', '187g', '1г', 'Яп', 5),
       ('Realme GT 5', '240W.', 2, 14, 52000, 60000, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/0b6eba3cb0cf8906cc05d403d71734b2/c607779c40aef820a606af101df78b11fac6c4708c9e1ba86d0c78c7727f039a.jpg.webp',
        'Gen 2', '16GB', '512GB', '6.7', '4600', 'Silver', '205g', '1г', 'Кит', 40),
       ('Huawei P60 Pro', 'Топ.', 2, 7, 85000, 95000, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/e64f614107ee39bf2889a2474dad7443/793c58ee49e58d5c826baabffa9a27838ce6beae21b98c2c23d03f25fb27a651.jpg.webp',
        '8+ Gen 1', '8GB', '256GB', '6.6', '4815', 'Pearl', '200g', '1г', 'Кит', 15),
       ('iPhone 15', 'База.', 2, 1, 80000, 90000, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/41edbfdd1b4ef4a38f3ac15b85e02902/2258685cc32bbd96de406852bd9b2d94916029658cd6fa120a9f97a4bc0af297.jpg.webp', 'A16',
        '6GB', '128GB', '6.1', '3349', 'Black', '171g', '1г', 'Кит', 50);

-- Группа 3: Наушники (ID 21-30)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage,
                      display, battery, color, weight, warranty, country, stock_quantity)
VALUES ('Sony WH-1000XM5', 'ANC.', 10, 5, 36000, 42000, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/92f5097a5043cd3526f7b4f492d02459/2df2632475190df8324dd72376786ed737facef7dc387bf5fcd76f88d5fc28ec.jpg.webp',
        NULL, NULL, NULL, NULL, '30h', 'Black', '250g', '1г', 'Мал', 50),
       ('AirPods Pro 2', 'Apple.', 10, 1, 24500, 28000, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/44b4b28ba1256a0bbd0cb163d2e1c5e6/4b1c1955a2530fa2de2ad1f4faa496f553779822690c1505f5400e6c34a1dbe1.jpg.webp',
        'H2', NULL, NULL, NULL, '6h', 'White', '5.3g', '1г', 'Кит', 100),
       ('Bose QC Ultra', 'Quiet.', 10, 2, 42000, NULL, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/61320b907aa1db6765a1086900e7aee1/3eaeaf9f9a84ec53125c672a86b6cdd3cfc974301b0a1f032c871a6c3898c4c7.jpg.webp',
        NULL, NULL, NULL, NULL, '24h', 'Black', '250g', '1г', 'Кит', 20),
       ('Marshall Major IV', 'Rock.', 10, 5, 15500, 18000,
        'https://c.dns-shop.ru/thumb/st4/fit/500/500/b82e970016b73cfff7f319e1886dffaa/b3caa95705c1e92f6d442deb5531405a7d7268817e53ad9f8e757c3b9f5f3d33.jpg.webp', NULL, NULL, NULL, NULL, '80h', 'Brown', '165g',
        '1г', 'Кит', 35),
       ('Sennheiser Momentum 4', 'Sound.', 10, 2, 34000, 39000,
        'https://c.dns-shop.ru/thumb/st4/fit/500/500/8c39d57612ae00119c82b8fdc8bfd36b/aa26a1683a5df301c315ebb471ae5458a823049959f39a22496a28741ac19df0.jpg.webp', NULL, NULL, NULL, NULL, '60h', 'White', '293g',
        '2г', 'Герм', 15),
       ('JBL Tune 720BT', 'Bass.', 10, 8, 7500, 9000, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/3cca3c41153253551f578ac48b49b469/0b45c7ef67fa1881b69c8c4c48b7a638fbde6fbbfa6415996110c363687a36da.jpg.webp',
        NULL, NULL, NULL, NULL, '76h', 'Blue', '220g', '1г', 'Кит', 40),
       ('Beats Studio Pro', 'Style.', 10, 1, 31000, NULL,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/a6e29c682e8ac6e24d6a12418c675014/bad2882220e9ed3acab47aec5eda8177ab6ba9ab2b42ebc9d793e3758584100e.jpg.webp', NULL, NULL, NULL, NULL, '40h', 'Navy', '260g',
        '1г', 'Кит', 25),
       ('Sony WF-1000XM5', 'TWS.', 10, 5, 28000, 32000, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/dfd90a5a471c48d46bef908ba1538396/d02fdf8c622d8f41b9b58f7848e93b053d6b3aa013f11adaed6a6cd778f07b24.jpg.webp',
        NULL, NULL, NULL, NULL, '8h', 'Silver', '5.9g', '1г', 'Мал', 30),
       ('JBL Charge 5', 'Party.', 4, 8, 15000, 18000, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/c35c5db1205b02b3ebdf4b778ed2324a/d9d56f02ec67bec1895f5cd1a49d49080981ea92df6770c69ee279052d5b6378.jpg.webp',
        NULL, NULL, NULL, NULL, '20h', 'Blue', '960g', '1г', 'Кит', 30),
       ('Xiaomi Buds 4 Pro', 'Gold.', 10, 3, 14000, 17000,
        'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/a2de7c2e35d8df8ae40fab64ef20dacb/cf21a8839cbcc4c4775d01979d25371cd900d86f43206b8ab12b47f0fe9dabbc.jpg.webp', NULL, NULL, NULL, NULL, '9h', 'Gold', '5g',
        '1г', 'Кит', 50);

-- Группа 4: Гейминг (ID 31-40)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage,
                      display, battery, color, weight, warranty, country, stock_quantity)
VALUES ('PlayStation 5 Slim', 'Sony.', 5, 5, 55000, 62000,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/1a47e30926071c56ce70a816c419f07f/84cf1a12a3a79953cebfba38182df1a14449d71d52da68cbcfdffc594cfd6bf8.jpg.webp', 'Custom', '16GB', '1TB', NULL, NULL, 'White',
        '3.2kg', '1г', 'Кит', 15),
       ('Xbox Series X', 'MS.', 5, 11, 58000, NULL, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/b4562592dd38dc2a80405bd2fd3f8374/92f5cbbe76cbccb59e28290a71366bae0581ff7ea0ece9b90426275db520108a.jpg.webp',
        'Custom', '16GB', '1TB', NULL, NULL, 'Black', '4.4kg', '1г', 'Кит', 10),
       ('Nintendo Switch OLED', 'Nint.', 5, 11, 35000, 39000,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/97460839bedcf575e3675a64816be900/8b4b0384b13c9c259b102bdce435782c095060c4c4dd96ede991fe1219b9299a.jpg.webp', 'Tegra', '4GB', '64GB', '7', '9h', 'White',
        '320g', '1г', 'Кит', 20),
       ('Logitech G502 Hero', 'Mouse.', 13, 16, 7500, 9000,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/1a17bf39f7e1c6cd33ed6476f411d925/0991ca8c863afd7dd77f0e8f50fd6739c94a3bb8c6d9683def7c60d98507cd03.jpg.webp', NULL, NULL, NULL, NULL, NULL, 'Black', '121g',
        '2г', 'Кит', 80),
       ('Razer BlackWidow V4', 'Keyb.', 12, 17, 18000, 21000,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/8040be690ebeb243cd004157b89c9ee0/3cd5d99d3b469e6dec57b820d2413fdfa247afbbe5055c2f48f900a376206992.jpg.webp', NULL, NULL, NULL, NULL, NULL, 'Black', '1.1kg',
        '2г', 'Кит', 30),
       ('SteelSeries Apex Pro', 'Fast.', 12, 18, 22000, 25000,
        'https://c.dns-shop.ru/thumb/st4/fit/500/500/95b16d7d3d37df84934d1d743dab542e/c051ec99fd2b83f6878b3700d8496d944e6720be6d4cd9f2b8a3593b60fb1132.jpg.webp', NULL, NULL, NULL, NULL, NULL, 'Black', '1kg',
        '2г', 'Кит', 10),
       ('Steam Deck OLED', 'Valve.', 5, 20, 65000, 75000,
        'https://c.dns-shop.ru/thumb/st4/fit/500/500/e7ea45e45e6c407bc76dc8ff4fea0631/2b2c9fcad6869829aefa2024ae5c07e03321376085bb672ea0f96d8ece8ab680.jpg.webp', 'APU', '16GB', '512GB', '7.4', '12h', 'Black',
        '640g', '1г', 'Кит', 8),
       ('Keychron K3', 'Mech.', 12, 16, 11000, 13000, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/af3b67e63ded484e9bc72861609138a8/e6c4d26a94e6fac0ba29166e2b2c794b7ae67974c52523c9d0ebef0a56a94665.jpg.webp',
        NULL, NULL, NULL, NULL, '34h', 'Grey', '400g', '1г', 'Кит', 40),
       ('MSI MAG274QRF', 'Monitor.', 11, 20, 42000, NULL,
        'https://c.dns-shop.ru/thumb/st4/fit/500/500/f18f0ab04503be54ffa8fbe6687a4ffd/1bc1f3f63226942f519e3e66e321f53cdfa88ba006bdd203915a5bf9cab3758b.jpg.webp', NULL, NULL, NULL, '27', NULL, 'Black', '6kg',
        '3г', 'Кит', 12),
       ('Logitech G Pro X 2', 'Audio.', 5, 16, 26000, 30000,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/dfb26a538e3dbecfe7c3442d96782276/83caee6487e7440f03e8ab2946e662a8b60c9ed2b4c11c1cd4451dd5bba7ee68.jpg.webp', NULL, NULL, NULL, NULL, '50h', 'White', '345g',
        '2г', 'Кит', 20);

-- Группа 5: ТВ и Прочее (ID 41-50)
INSERT INTO products (name, description, category_id, brand_id, price, old_price, file_url, processor, ram, storage,
                      display, battery, color, weight, warranty, country, stock_quantity)
VALUES ('iPad Pro 12.9 M2', 'Tab.', 7, 1, 118000, 130000, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/912f907a315499ce76c50e847592be62/91df1c340702a992c1d86f77005e5080f4fb753cf701247196f59d3463b4049d.png.webp',
        'M2', '8GB', '128GB', '12.9', '10h', 'Gray', '682g', '1г', 'Кит', 12),
       ('Samsung Tab S9 Ultra', 'giant.', 7, 2, 110000, NULL,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/64f69571a77571bb44f047939aea8210/9fc328667fe705a071ea2d85f7515a99c60345b5efcb0317c628c5eec63c94c2.jpg.webp', 'SD 8 Gen 2', '12GB', '512GB', '14.6', '12h',
        'Gray', '732g', '1г', 'Вьет', 8),
       ('LG C3 55 OLED', 'TV.', 3, 6, 145000, 165000, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/4e32d9065f48897e02c12af5811681be/54063ab2dc79c72e3cc1ca5e00e31a4c15f5bced3e24d963e75983653da06285.jpg.webp',
        'A9', NULL, NULL, '55', NULL, 'Silver', '16kg', '1г', 'Пол', 5),
       ('Apple Watch 9', 'Watch.', 9, 1, 42000, 48000, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/31836c27a5513db1eb209279e65084d0/69c8d7e2e7350e09ff26c27168fe4736f05575e2089bd6288aab3275d8f40958.jpg.webp',
        'S9', NULL, '64GB', 'OLED', '18h', 'Midnight', '32g', '1г', 'Кит', 40),
       ('Samsung Watch 6', 'Classic.', 9, 2, 32000, 38000,
        'https://c.dns-shop.ru/thumb/st4/fit/500/500/5573c491241f8e28f58a257f15c80ff5/48a195c0b858690281bd39962bae30b68ef77192aeedfae68f37526a2f1fc412.jpg.webp', 'W930', NULL, '16GB', 'OLED', '40h', 'Silver',
        '52g', '1г', 'Вьет', 25),
       ('Xiaomi Pad 6', 'Best.', 7, 3, 38000, 45000, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/9bde8229a1a576bd40db9379f1cb2794/d11104bdfbcc559d7d38a4db7c33af47d471899b92685203be4379facceaf9d7.jpg.webp',
        'SD 870', '8GB', '256GB', '11', '14h', 'Gold', '490g', '1г', 'Кит', 25),
       ('Xiaomi Band 8', 'Fit.', 9, 3, 4500, 5500, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/ced9bb35b85dfc117dd02cb4bf1ff88d/4efa44d824e2648dd388c7e060d7a6e1b91ccd82ce3ac159567b6981bc1a2279.jpg.webp', NULL,
        NULL, NULL, '1.62', '16d', 'Black', '27g', '6м', 'Кит', 100),
       ('Samsung QN90C', 'TV.', 3, 2, 135000, NULL, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/17e202768e594126c4e51f44934a5680/6b53333798e266f4f880c834e7381db215ebf5148ecad9301d3ecf201d62d739.jpg.webp',
        NULL, NULL, NULL, '55', NULL, 'Silver', '17kg', '1г', 'Вьет', 7),
       ('Sony BRAVIA A80L', 'OLED.', 3, 5, 175000, 195000,
        'https://c.dns-shop.ru/thumb/st1/fit/500/500/c04b3a6fee0dc7e94fea8ade9a80381d/4a917ae831e0564c2f0a09e4be737fb002a1601411c4a37697fcea994d6dfce2.jpg.webp', NULL, NULL, NULL, '55', NULL, 'Black', '18kg',
        '2г', 'Яп', 4),
       ('Huawei Watch GT 4', 'Steel.', 9, 7, 21000, NULL,
        'https://c.dns-shop.ru/thumb/st4/fit/500/500/9ce1f1383a64ec945b94b96de7b47bd9/4f5c77d1a7c73e18144faf5a51f96e9cab91f037523c6828955fd532867b9d80.jpg.webp', NULL, NULL, NULL, 'AMOLED', '14d', 'Steel',
        '48g', '1г', 'Кит', 50);

-- 6. ГАЛЕРЕЯ (По 4 фото на товар)
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (1, 'https://c.dns-shop.ru/thumb/st4/fit/0/0/75f9c3cb0ee41afe4a66dc9bed0afbee/03798a318a900460a7bf0e05c065586a98918ca55f75985b068a9cf28f290660.jpg.webp', TRUE, 1),
       (1, 'https://c.dns-shop.ru/thumb/st4/fit/0/0/b1ca1e5dcb22bfb6c1f5b469147a5087/0ea38f66b2ae9d63d9e85d7735464ebf343b09079a62380b9a02d67c96c7101a.jpg.webp', FALSE, 2),
       (1, 'https://c.dns-shop.ru/thumb/st1/fit/0/0/1bddc31da3ed39518f9fede973ff0d59/32c6ef88bb89d2f3de77f1f34b1b20e31b78004ee73450092d57fb52d8828845.jpg.webp', FALSE, 3);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (2, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/cd9ad5336cb1f6fa35c3a1ce023838da/e76e3a8a23638d8a8515a2df93a7018fc68673ca182b4dc6ec4b1d0f995ea375.jpg.webp', TRUE, 1),
       (2, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/2a6862c6bef0913f4791133ac292bbcb/b24f23c6c28377d92c2ec4ae5c2b7b21fafd04560c93eee8ecfaae9b07a4d7a7.jpg.webp', FALSE, 2),
       (2, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/a94518b28a0aad6c73804dd2ce5554fe/58aa1c01e9d6ff0d5bf5bfa8434b01a202608657cadb21c8a8ab3f88343881b0.jpg.webp', FALSE, 3);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (3, 'https://cdn.citilink.ru/z5QNAZCU5SaNO2EnqLe54GucxsOoURm7tt1ltBPXCyU/resizing_type:fit/gravity:sm/width:400/height:400/plain/product-images/f1166d85-4958-426b-90e6-1101daf68b01.jpg', TRUE, 1),
       (3, 'https://cdn.citilink.ru/6PmcbUZ8qi8JLV0vkcKlk0i_y2r1GQn9y9pZEKNKFQM/resizing_type:fit/gravity:sm/width:400/height:400/plain/product-images/6b69dff1-dd4c-4546-8c5d-88ccf91eaf0d.jpg', FALSE, 2),
       (3, 'https://cdn.citilink.ru/pLNFhkoGrF5jJknSWGzepKhnLHwAOLcCGw5XvRtPKHE/resizing_type:fit/gravity:sm/width:400/height:400/plain/product-images/fe4e147f-4050-47f3-a2a9-262b2d5a5f6f.jpg', FALSE, 3);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (4, 'https://c.dns-shop.ru/thumb/st1/fit/300/300/8a5fd084966a2dd765d149f7f9d37f9f/7ea013849f9b886dc69ab23bb20b35eb0624ff34107c148372da8b3baac31b29.jpg.webp', TRUE, 1),
       (4,'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/5cf4c8277cc60ef1aed4f0e43e2d1e7b/2bc2a7ff0de11c2ef0d1e85cb94bc3b9e261798b6ac16cb41c1c7fd7396b0da4.jpg.webp' , FALSE, 2),
       (4, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/0e41f7d1ddbcc87853258380ce44ff7d/906aa98010244da3670b6f0626c76a316656791c069c672fa2bfe93ab6312ce9.jpg.webp', FALSE, 3);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (5, 'https://cdn.citilink.ru/It6Z81hNINiRCiHO2DzdxUdfCghqeGiTJcJ_1YlFD98/resizing_type:fit/gravity:sm/width:400/height:400/plain/product-images/e1fad7b4-660d-41b2-b12d-058bc073d51c.jpg', TRUE, 1),
       (5, 'https://cdn.citilink.ru/myH9WYRuKVUOWlhZO2bzw50saOpOPmxgo78LkiTVD_Y/resizing_type:fit/gravity:sm/width:400/height:400/plain/product-images/89ce1906-cfa9-40ab-8934-2ae87f81141b.jpg', FALSE, 2),
       (5, 'https://cdn.citilink.ru/sE00mKBZyV5GZj7qq5l-ZietODXODw55FpENbctuZHA/resizing_type:fit/gravity:sm/width:400/height:400/plain/product-images/8ebc8adf-c1ba-4275-811f-ba31d1186014.jpg', FALSE, 3);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (6,'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/c20f4a0e5592d0aa6777a181cf891cc4/1eede391e313573c7a8c1a3e1303797793c5858c9b2565d5a9a60569d5886b6c.jpg.webp', TRUE, 1),
       (6,'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/7f0ab189c6b1e0e7c58ceec077af77da/8708c22c4bb9422d391a6b0df8f16e2f679e5e1a2062682a4d8be9dae63169de.jpg.webp' , FALSE, 2),
       (6, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/df2878e1f5da672885e18b6210d7a6e3/dcd367f391a84a2ecf39a0fda84eb11a621e37b43b3aff15bb76a4200ba1f467.jpg.webp', FALSE, 3);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (7, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/347586035a579aeb99c04cc647659d2d/a5a94e3a68177f6b194cd716c2eb82d0429522c944b514d4f299a03291410197.jpg.webphttps://c.dns-shop.ru/thumb/st1/fit/wm/0/0/347586035a579aeb99c04cc647659d2d/a5a94e3a68177f6b194cd716c2eb82d0429522c944b514d4f299a03291410197.jpg.webp', TRUE, 1),
       (7, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/02ece3a4d08efb2778f5ecc785395bb2/93d07e6d0cd9d557e4446c09fc93e8a0bf28324b61526bf8a6358cafd22bc4fe.jpg.webp', FALSE, 2);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (8,'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/82b81251f05b6f5cc3969e8fa0ecc368/1d0eeb44985ef58af55e57a5801432894fb248a6a525504a88bcdc9996c29533.jpg.webp' , TRUE, 1),
       (8, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/926e7d98af886feda25efcbe204187c0/13ddea9d4dfc10f51be9ccba7b8e8c33b7d25a7728eb3916d7ada610356d57cf.jpg.webp', FALSE, 2);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (9, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/063d5305f35d3e6b841ee37681e015a7/417c4fe8125c5320cff95c3ac34dd74be77937f8ecf7beb45cb2070ac7ac63d1.jpg.webp', TRUE, 1),
       (9, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/e47013b31059a82be96e368fb1ae7cd0/50e378f5324e68193e0efaaf4cb81afd09746ee6eb8cd140b279b7c73b710d2c.jpg.webp', FALSE, 2),
       (9, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/32e6df3d465acafa673af264876e0d88/8b8259d87fa1994cce253bf6c0c155e41d50ec510f118e9275d687e32ebd5f76.jpg.webp', FALSE, 3);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (10, 'https://avatars.mds.yandex.net/get-mpic/13733939/2a00000194f2390c7d124093ea182bfead71/optimize', TRUE, 1),
       (10,'https://avatars.mds.yandex.net/get-mpic/5173149/2a00000194f24b4f4a2ade94c285ffe0a01e/optimize' , FALSE, 2),
       (10, 'https://avatars.mds.yandex.net/get-mpic/5236177/2a00000194f24b4f496e5f3db5d002eaaab2/optimize', FALSE, 3);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (11, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/5f69c1f4061e959527c7af3113000853/dd3531d9a9470880430939cc74a603121be902b4624098c4dfa8ac87e4a3f5bc.jpg.webp', TRUE, 1),
       (11, 'https://c.dns-shop.ru/thumb/st1/fit/0/0/46195e735cf011c072380e87c145e3c5/8421f22cdca8acfda0d58b7be17e3dae07e7673e80800f30c810680bdc34468f.jpg.webp', FALSE, 2),
       (11, 'https://c.dns-shop.ru/thumb/st1/fit/0/0/9e21e9f74ac1160c38f264021c06c5ca/7b24e33d2373b6589b15b3f27d1f39fb25667bbb235b0b620482cfc816e03687.jpg.webp', FALSE, 3);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (12,'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/31e9fa3b020cfa6f6831aed6d5626a05/943a51dc4c5dc07d841f17fab48aa040e5465c988147717deece48dc9c0d4b35.jpg.webp' , TRUE, 1),
       (12,'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/030a43baa3493817d00dbeba0f032e9d/7364d26e00e5e0424c2608bd1f1cd8e11f1369cef3a22cf012f9b409756f1bc7.jpg.webp' , FALSE, 2);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (13, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/557a3cced654da489bbddf773a0828e7/e24ef5e3dbd3ae2c9696a94caead53e45f4d18c6fb165cc01b1444300c6b62c4.jpg.webp', TRUE, 1);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (14, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/3ff6ea96e7f1b1358f052d01964b7b76/be281b2fca18da99755004c6c0f26a8bb81cfd278b108e27fc10065a14699153.jpg.webp', TRUE, 1),
       (14, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/c18e7bc49fcf8ba3804561e6ea56f432/a569beb02eb0ea49435af2417400d7362bfab833efbd121792a6f9dc0c2e61bc.jpg.webp', FALSE, 2);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (15, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/664aec1de7d53f6131f25109be7532ea/ff8b3ff85cbb37fc459c7aa2ee4c62209a533c54582627ebe831a7cc8e7eec1e.jpg.webp', TRUE, 1),
       (15, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/03187fdc835014275fabaae0b205cc79/c209ab0e314c0803eb201e73c465d31cc446728bbd8082a4aed22f6a33648e0b.jpg.webp', FALSE, 2);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (16, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/e109734b4e8a55fe016cc3014f6fb9d2/91bad219116b0b171ff140ab72f1c6b494d13bea67a99eed7a96e25c654a6d73.jpg.webp', TRUE, 1),
       (16, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/7c1b01b7224ccfd349145d886d9f366e/9fc90edb053eb43e646408b4beddbaebb93073cfb8aceaf88e46c6677771ebb6.jpg.webp', FALSE, 2);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (17, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/af046ee1e4194ea1bbd14442e068aacc/5c2219623c8ab687c70d07d12baa5bb1a280d08b43469d97805672fc606170e5.jpg.webp', TRUE, 1),
       (17, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/b534418f32be36c5c0ac111106aa2df6/c7b1844400699b0f3b500634eaf81100e777a7e862b53510d20bcd86cdabff39.jpg.webp', FALSE, 2);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (18, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/42ef8ab06dd84b6c0605a322a394f785/59f1a42b286d265956adbf757834314e9a5cb13685e3ba0a961819f2d337cf63.jpg.webp', TRUE, 1),
       (18, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/99628657794d5ecf45798426e336e9b2/40136e253e55cfcb8e8948aa61e6fa08f46db70e8b791d43e37baed1a5c1d9dc.jpg.webp', FALSE, 2);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (19, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/478e3b2903987c4f505ea2d86326f4be/4f34112e517ee0e6cdf57e056021ba09c37641cd66e7349f4ea80b2ea495636f.jpg.webp', TRUE, 1),
       (19, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/642b034e4713a239dd7028335dc7fe87/e0a27d7c6e1d25896c05a4352361e937227bc6207b954580579eb81e7adabbd5.jpg.webp', FALSE, 2);
INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (20, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/41edbfdd1b4ef4a38f3ac15b85e02902/2258685cc32bbd96de406852bd9b2d94916029658cd6fa120a9f97a4bc0af297.jpg.webp', TRUE, 1),
       (20, 'https://c.dns-shop.ru/thumb/st1/fit/0/0/43da8634f1206d6e21c727d2f4992f53/2a2217c04dc28db8403122239b91dc37b5da40828150349c06afa10ec99f1963.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (21, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/7932deeec2b65e0814d00c0d7b568cee/c6faee61c83b54e73d38a4bad8552d5d758d50b43c2d3f2f24bd2777bd387f3f.jpg.webp', TRUE, 1),
       (21, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/e9b03add100ae319d31f0a355b0936a4/04937f6f234439401b88ee3d36fbb07c610c68690dafccda99b0d9523665f477.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (22, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/9ea9e3c4289d3a0b844a9f6a63871ffb/597e8ebaf3543bbf29c7a493f0f950e3ef37c968d91ba06c9d0ec0ebbbd2af82.jpg.webp', TRUE, 1),
       (22, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/9ea9e3c4289d3a0b844a9f6a63871ffb/597e8ebaf3543bbf29c7a493f0f950e3ef37c968d91ba06c9d0ec0ebbbd2af82.jpg.webp', FALSE, 2);


INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (23, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/85c938794a680bfaf3716be67ea3ed78/05be389e7cbb8af87b37b1002b3b07223bfe1fe244c7f17cd5005fe908b1ae61.jpg.webp', TRUE, 1),
       (23, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/1873ad2b9604ad63849376c0d8911b0b/b78753467bf301cf97c01bc8d45bd8b362c8651bf7c9ef45177b4d4da6791cba.jpg.webp', FALSE, 2);


INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (24, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/168507a00846b9d76c27b7d8cf79ff6b/e6db8ad5ec0e21ac1441764187889c8b6e69911d8432bbdaf988abdda2757596.jpg.webp', TRUE, 1),
       (24, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/06cc7c07cc3d30ff14dbca3416c2115c/57dfac2d9411e4dc8c65b2e0fec85a83a345932cd213049151482492a9442859.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (25, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/445d08320c523c912965f907bc04407c/6c2b8c439c552bc097984e38f620496205defadf2549837e064aea9d84046ba5.jpg.webp', TRUE, 1),
       (25, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/aa74209f15a46b2efab14bdbe2425170/7b4a773a383624fc2ea076b14f3384b0b7e0872e882bb99cc34035e3b08610e6.jpg.webp', FALSE, 2);


INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (26, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/d2786990e255a69ac7c62e5dc1c3b821/1cecc506c1174f7a7a443f2d1c53bcf3a0e5a0c57e89227a92274dc00ada1c0a.jpg.webp', TRUE, 1),
       (26, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/2e4c5ec7b69ba946685150b801957c2b/5f87ee6dc3645d106d541369a03b172d1503c4be4fc651f6b9f37cc8f4217794.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (27, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/55cb51ff7d996ed498218ddd01f52d6d/b9372ed7db0f27c9f1a07274ed40301e03d8a98da41397ae52c5794cb8564f04.jpg.webp', TRUE, 1),
       (27, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/36e23325534d1820057a6554cb1c04e5/fc603305fb4fef515bd7e66eaeef23c7dae3f8f1bc48c9964c6bf49b5c5183b9.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (28, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/d13a1329c00ae80f830176820e4b9d7e/c9852772edd1f389590f5b957b41b5b67ffaf1b8d063c50c76e7635431c264da.jpg.webp', TRUE, 1),
       (28, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/0753a0afe5085bdba3f4ecb0f6871bf3/ac35a57948562f157ae5c6270ec87217a91d52a49ea24c2427497e85ee235e65.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (28, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/ede3ae867b8a27a02b4b3541fb265475/ab544a9ce8884b2def353d1bafc3b39f3a2b934c28647cde388cf5626a480fc9.jpg.webp', TRUE, 1),
       (28, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/1dabbc9b8c52a3197f1fd1265cfe230f/00726c6fd2f85d49818a71a016aac27cf329a1fb4f1aea5f4ee72650b3f73def.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (29, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/ede3ae867b8a27a02b4b3541fb265475/ab544a9ce8884b2def353d1bafc3b39f3a2b934c28647cde388cf5626a480fc9.jpg.webp', TRUE, 1),
       (29, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/c44050e00a90a3ee91910093484a1616/c5820aeb671190825f2c617b49c42b759120989ed70f24f2395ae0fc58edec43.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (30, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/e5b4e588b2476af8ffe7c5d7dbda3156/666676963552afeb5e7d91820de0df6e1780f91744ffa5e1df8d6c436f1aee62.jpg.webp', TRUE, 1),
       (30, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/396dbc33ac57a6e85ae063015a5d088e/e393cfbad0a1e5e6d56444c04ea0a9ebabf518a63d2fc16821ea64c9ab7c920e.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (31, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/889daf39b3bf662fa0e35ff863fc0ff7/ad8e35b2b6a5965a0cb49f0d054156fbc735a07c13522551301682c8ea080299.jpg.webp', TRUE, 1),
       (31, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/a94153652478b168f0bc8915c3f5e008/227d380ff57a3d3f4fb824737044d5682d69e846c3dbf77c4e19d37449b335ff.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (32, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/71786805bb261cfe2e8b005151e0c3b5/19ac4a14da38ea84b516599741a1f739b3bd8221c3e171a495be44c9226b2b22.jpg.webp', TRUE, 1),
       (32, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/aa496ff024c49ede14c6d5cb9617b231/8255acf7c252381da2b40c9afab06a8d578cab1c60c39ecd755095c1a92c6566.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (33, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/b0018e608d2896d3778511b9a28cb2b1/96e4f75cd820c8b34bae56ff4b73dc5459da8f0a843d6e7ecbf346eee59a5699.jpg.webp', TRUE, 1),
       (33, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/4f028fbb2ad6c509a6f7369a66df849e/dd9792d002458542bb15ed3b4b3daa772964e4aecf2d997860711cb4e1c6b6f2.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (34, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/aed3db0e438b48c1b97d3c4cc94f7818/20303071507c28a00722cbcb92228b0b062e4b80193552674cfb480e5b74a0c8.jpg.webp', TRUE, 1),
       (34, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/876a7fc5c4da005eac60e9871999f212/4c61a7f3772fd2a630b9b9027eaf37f6d73369c408c875319487a91a225411f2.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (35, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/692f60bf96852104adcff3c7814da272/38e8bdb9bc7d339c051af32b413882f34fa6807f4394e5aab8780b2dab1d9f37.jpg.webp', TRUE, 1),
       (35, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/397e22f657e1cbd8ff35d162e581dd89/ba4bcb01df76f5700c8d77ffeec85e1bd1902c5c1b8a2e49b1febbe937693798.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (36, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/7fc7ff1cc7ef82a182b09aee9ff14190/443fb1191af44497d84eeca905b739a1b12cedd8ab64d5deda0096a190593d42.jpg.webp', TRUE, 1),
       (36, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/22c9eb35fa7d0d1aa26bac92eeec4025/67fe95b97ce39db3205a4fbb6d897f399555ec7f18518510401028bfe1106bf1.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (37, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/178c8cb5bf34ae255ee7fd7512cdebfc/d407594daa7fffe7b6c77e4d41a20a1238616dff0317949d5b03a9cf3ee32d10.jpg.webp', TRUE, 1),
       (37, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/09ac134e6d4947721fa2f779b0a2c6cf/d217122b0ed0871aa3b75aa961ce49ea64a7096c26e8f42e55600e5c3b52680a.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (38, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/5bcdf25d769c8782133e97064101fa43/b3df416d7c398367c4bd20f8bc5b9dbc91768c2ca01d307e316a573c8ecbc955.jpg.webp', TRUE, 1),
       (38, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/4fa4f23ba83f6c1dad40a88ec581c1f2/4077eba5acbc236dbb86b198f9e0111af193a9b4a59a9baa3889badcc7c56f40.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (39, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/ff487d4a6bda12da4e884089ac58453c/02e2865e7c7618616b4a010ee0f9b7b7999188f2c084183d21c23644a35bd872.jpg.webp', TRUE, 1),
       (39, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/7176505a8840ca3283e8a96285a0ccaa/8e0e71916eb5ef561fb42db4297f5d6136a57ae8cab60bd80b8c96e136f633f2.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (40, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/e4f3d89041e28259d1260862080f1978/e29379b679b85c1097f704c4d04775ee3de6512a251e5529dbac67a555267ab1.jpg.webp', TRUE, 1),
       (40, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/2d53e56ca05ce87e0b7676a3dbc8db55/7235bd48c8728244ec970faf820b11c80986c966858a448107373872352f47c5.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (41, 'https://c.dns-shop.ru/thumb/st4/fit/0/0/00a226c6dd60f130c8d1857853cc66b7/ee9bcfce1ba356be8277f2abf4983e5b6f2458c49589ecbc719ba396b0c0172a.png.webp', TRUE, 1);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (42, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/a3828d4f17b3ef0477be5c3a044d25c8/dc852b0edee91b791e91585617eaf32718afdc15a847a5505b0d7d050b505344.jpg.webp', TRUE, 1),
       (42, 'https://c.dns-shop.ru/thumb/st4/fit/wm/0/0/21b751c77bc170194502df6dfa6599c5/f10e8a1a6c0d36ea61b62b239b2753389e53e5c51944ffa327e3fcc88d677183.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (43, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/613e2f6c87599231a801adf41e47e028/eacc8263a11f1ab9b26432135e19fe1baac1e0a91d9ac6444578b513d7f231ee.jpg.webp', TRUE, 1),
       (43, 'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/06ead23dd650742a591dcca498d48a06/21a755c414456b842edcd54f66d094c7fb58055d044614b11dae32bad65c0a01.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (44, 'https://c.dns-shop.ru/thumb/st1/fit/0/0/1b2c8d2124dceee46fb0d99392bd9f5f/94a6b1e7d22ca98d3a38089df0a0fac2e946ff8e26183ad16d5488fbea94a691.jpg.webp', TRUE, 1);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (45, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/40d2c6693d874f01d5c278a178cf8024/e8b53eabae7966a407e718233f065f8b1519cbac20096e321b7617378301153e.jpg.webp', TRUE, 1),
       (45, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/c8f54cd3cf1c3760233fc758a467dbb6/85a7221de723a988ea608ea3b98260998170c31d6d99502bae0016087dd0ba67.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (46, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/760b11a9f20a86c2c6e8a409df9becb0/d63dfd783b979057dd3c19dd86a1bcea32c0b0e30d6211ce46b5808c21f05e09.jpg.webp', TRUE, 1),
       (46, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/b940d9fa93744ce93130205534412057/973f659bd968b763ec1259ac3d46b68eba9e435711c2a6cffc1ccfaf3eaef22c.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (47, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/6510c2ba6fd38968bb4d9c87f7ea9c62/24ea6f51570ac2367064668e48e2060781a16eb565369c9932d2b51dc8d7cd0e.jpg.webp', TRUE, 1),
       (47, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/6510c2ba6fd38968bb4d9c87f7ea9c62/24ea6f51570ac2367064668e48e2060781a16eb565369c9932d2b51dc8d7cd0e.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (48, 'https://c.dns-shop.ru/thumb/st1/fit/500/500/a2d6f18f27fe877964d436ffba07269d/3cf338bf4b01203858353349ef0a661ed58dc5a6df6d3e9cbf75051dfbd7fe5f.jpg.webp', TRUE, 1),
       (48, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/41cb707a5b279e2a0d6430595bbb7167/6d0fbd9ea3dce98300a4fc95d076a5dbfc768249130db66f5874ccfd2e4d7232.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (49, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/8c0e1998496b28f71d13434e0a8f8596/61f2f00b69d22a2e00cd11cadfc79342e8fd21a04f7fa87ee6106541007854a5.jpg.webp', TRUE, 1),
       (49, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/1ef42e26785a31b466b72a3c60d9a9f0/90e93ff304d4498f8b573173edbabf6653dc8d30df6a7aa403517befc05981e2.jpg.webp', FALSE, 2);

INSERT INTO product_images (product_id, image_url, is_primary, display_order)
VALUES (50, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/8abe678b9204cce362b7c3c7111e8b89/c8a92732e2c3123a108bbba477ef64d6a8378ef62b6d0b07086a8a1aa9cbd014.jpg.webp', TRUE, 1),
       (50, 'https://c.dns-shop.ru/thumb/st4/fit/500/500/8abe678b9204cce362b7c3c7111e8b89/c8a92732e2c3123a108bbba477ef64d6a8378ef62b6d0b07086a8a1aa9cbd014.jpg.webp', FALSE, 2);


-- 7. ЗАКАЗЫ (DATEADD)
INSERT INTO orders (user_id, order_date, status, total_price, address, delivery_method, payment_method)
VALUES (1, DATEADD('DAY', -20, CURRENT_TIMESTAMP), 'COMPLETED', 330000.00, 'Москва', 'Курьер', 'Карта'),
       (1, DATEADD('DAY', -5, CURRENT_TIMESTAMP), 'PROCESSING', 78000.00, 'Москва', 'Самовывоз', 'Наличные');

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (1, 1, 1, 185000.00),
       (1, 11, 1, 145000.00),
       (2, 41, 1, 42000.00),
       (2, 21, 1, 36000.00);

-- 8. ПЛАТЕЖИ И ОТЗЫВЫ (DATEADD)
INSERT INTO payments (order_id, user_id, amount, payment_date, status)
VALUES (1, 1, 330000.00, DATEADD('DAY', -19, CURRENT_TIMESTAMP), 'COMPLETED');

INSERT INTO reviews (user_id, product_id, rating, comment, review_date)
VALUES (1, 1, 5, 'Шикарно!', DATEADD('DAY', -3, CURRENT_TIMESTAMP)),
       (1, 11, 5, 'Топ камера.', DATEADD('DAY', -1, CURRENT_TIMESTAMP)),
       (2, 21, 5, 'Лучший звук.', DATEADD('DAY', -5, CURRENT_TIMESTAMP));

-- 9. СТАТЬИ (DATEADD)
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('Обзор iPhone 15 Pro', 'iphone-15-review', 'Текст обзора...', 'Титановый флагман.',
        'https://www.idolstore.ru/upload/medialibrary/b70/1xlfmx8x696xw9cowiy2ome2ci1ddwnq.jpg', 'REVIEW', 'PUBLISHED',
        2, DATEADD('DAY', -10, CURRENT_TIMESTAMP)),
       ('Выбор ноутбука 2025', 'laptop-guide', 'Текст гида...', 'Советы.',
        'https://images.unsplash.com/photo-1496181133206-80ce9b88a853', 'GUIDE', 'PUBLISHED', 2,
        DATEADD('DAY', -9, CURRENT_TIMESTAMP));

-- 10. РЕАКЦИИ И СЧЕТЧИКИ (RAND)
INSERT INTO article_reactions (article_id, user_id, reaction_type)
VALUES (1, 1, 'LIKE'),
       (2, 1, 'LIKE');



-- =====================================================
-- ПОЛНЫЕ СТАТЬИ ДЛЯ БЛОГА (10 ШТУК)
-- =====================================================

-- Статья 1: iPhone 15 Pro - полный обзор
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('iPhone 15 Pro: полный обзор флагмана 2024',
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
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('Как выбрать ноутбук для работы и игр: полное руководство 2025',
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
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('Топ-10 аксессуаров для смартфона, которые реально нужны',
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
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('Будущее технологий: как ИИ меняет носимые устройства',
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
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('OLED против QLED: что лучше для дома? Полное сравнение',
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
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('Sony WH-1000XM5: лучшие наушники с шумоподавлением – обзор',
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
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('Как выбрать смарт-часы: полный гид 2025',
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
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('Xiaomi 14 Ultra – король камеры? Полный обзор',
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
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('Samsung Galaxy S24 Ultra: что нового? Обзор всех инноваций',
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
INSERT INTO articles (title, slug, content, excerpt, image_url, article_type, status, author_id, published_at)
VALUES ('Как продлить жизнь батарее ноутбука: 5 простых советов',
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

UPDATE articles a
SET a.likes = (SELECT COUNT(*) FROM article_reactions r WHERE r.article_id = a.id AND r.reaction_type = 'LIKE');
UPDATE articles
SET views = CAST(RAND() * 1000 AS INT) + 100;

