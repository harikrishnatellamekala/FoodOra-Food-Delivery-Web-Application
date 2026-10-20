CREATE DATABASE foodora;
USE foodora;

CREATE TABLE user (
    userId INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255),
    role VARCHAR(50) NOT NULL
);


CREATE TABLE restaurant (
    restaurantId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    cuisineType VARCHAR(100),
    deliveryTime INT,
    address VARCHAR(255),
    adminUserId INT,
    rating DOUBLE,
    isActive BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255),

    CONSTRAINT fk_restaurant_admin
        FOREIGN KEY (adminUserId)
        REFERENCES user(userId)
);





CREATE TABLE menu (
    menuId INT PRIMARY KEY AUTO_INCREMENT,
    restaurantId INT NOT NULL,
    itemName VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    price DOUBLE NOT NULL,
    isAvailable BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255),

    CONSTRAINT fk_menu_restaurant
        FOREIGN KEY (restaurantId)
        REFERENCES restaurant(restaurantId)
);


CREATE TABLE orders (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    restaurantId INT NOT NULL,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalAmount DOUBLE NOT NULL,
    status VARCHAR(50) NOT NULL,
    paymentMode VARCHAR(50) NOT NULL,

    CONSTRAINT fk_order_user
        FOREIGN KEY (userId)
        REFERENCES user(userId),

    CONSTRAINT fk_order_restaurant
        FOREIGN KEY (restaurantId)
        REFERENCES restaurant(restaurantId)
);


CREATE TABLE orderItem (
    orderItemId INT PRIMARY KEY AUTO_INCREMENT,
    orderId INT NOT NULL,
    menuId INT NOT NULL,
    totalAmount DOUBLE NOT NULL,

    CONSTRAINT fk_orderItem_order
        FOREIGN KEY (orderId)
        REFERENCES orders(orderId),

    CONSTRAINT fk_orderItem_menu
        FOREIGN KEY (menuId)
        REFERENCES menu(menuId)
);

-- ===================================================================================================================================
-- insering the query
-- ======================================================================================================================================
-- inserting the user data

USE foodora;

INSERT INTO `user`
(username, password, email, phone, address, role)
VALUES

-- ADMIN USER
('foodora_admin', 'Admin@123', 'admin@foodora.in', '9876543210',
 'Indiranagar, Bengaluru, Karnataka', 'ADMIN'),

-- CUSTOMER USERS
('Rahul Sharma', 'Rahul@123', 'rahul.sharma@gmail.com', '9876543211',
 'Koramangala, Bengaluru, Karnataka', 'CUSTOMER'),

('Priya Reddy', 'Priya@123', 'priya.reddy@gmail.com', '9876543212',
 'HSR Layout, Bengaluru, Karnataka', 'CUSTOMER'),

('Arjun Kumar', 'Arjun@123', 'arjun.kumar@gmail.com', '9876543213',
 'Whitefield, Bengaluru, Karnataka', 'CUSTOMER'),

('Sneha Rao', 'Sneha@123', 'sneha.rao@gmail.com', '9876543214',
 'Jayanagar, Bengaluru, Karnataka', 'CUSTOMER'),

('Vikram Singh', 'Vikram@123', 'vikram.singh@gmail.com', '9876543215',
 'Electronic City, Bengaluru, Karnataka', 'CUSTOMER'),

('Ananya Iyer', 'Ananya@123', 'ananya.iyer@gmail.com', '9876543216',
 'Malleshwaram, Bengaluru, Karnataka', 'CUSTOMER'),

('Karthik Reddy', 'Karthik@123', 'karthik.reddy@gmail.com', '9876543217',
 'Marathahalli, Bengaluru, Karnataka', 'CUSTOMER'),

('Divya Nair', 'Divya@123', 'divya.nair@gmail.com', '9876543218',
 'BTM Layout, Bengaluru, Karnataka', 'CUSTOMER'),

('Rohit Verma', 'Rohit@123', 'rohit.verma@gmail.com', '9876543219',
 'Rajajinagar, Bengaluru, Karnataka', 'CUSTOMER'),

('Pooja Menon', 'Pooja@123', 'pooja.menon@gmail.com', '9876543220',
 'JP Nagar, Bengaluru, Karnataka', 'CUSTOMER'),

('Akhil Gowda', 'Akhil@123', 'akhil.gowda@gmail.com', '9876543221',
 'Banashankari, Bengaluru, Karnataka', 'CUSTOMER'),

('Meera Krishnan', 'Meera@123', 'meera.krishnan@gmail.com', '9876543222',
 'Basavanagudi, Bengaluru, Karnataka', 'CUSTOMER'),

('Suresh Babu', 'Suresh@123', 'suresh.babu@gmail.com', '9876543223',
 'Yelahanka, Bengaluru, Karnataka', 'CUSTOMER'),

('Kavya Shetty', 'Kavya@123', 'kavya.shetty@gmail.com', '9876543224',
 'Bellandur, Bengaluru, Karnataka', 'CUSTOMER'),

('Naveen Kumar', 'Naveen@123', 'naveen.kumar@gmail.com', '9876543225',
 'Kalyan Nagar, Bengaluru, Karnataka', 'CUSTOMER'),

('Aishwarya Rao', 'Aishwarya@123', 'aishwarya.rao@gmail.com', '9876543226',
 'Hebbal, Bengaluru, Karnataka', 'CUSTOMER'),

('Manoj Patil', 'Manoj@123', 'manoj.patil@gmail.com', '9876543227',
 'Vijayanagar, Bengaluru, Karnataka', 'CUSTOMER'),

('Lakshmi Devi', 'Lakshmi@123', 'lakshmi.devi@gmail.com', '9876543228',
 'RT Nagar, Bengaluru, Karnataka', 'CUSTOMER'),

('Aditya Joshi', 'Aditya@123', 'aditya.joshi@gmail.com', '9876543229',
 'Sarjapur Road, Bengaluru, Karnataka', 'CUSTOMER'),

('Shreya Kapoor', 'Shreya@123', 'shreya.kapoor@gmail.com', '9876543230',
 'Indiranagar, Bengaluru, Karnataka', 'CUSTOMER'),

('Harish Kumar', 'Harish@123', 'harish.kumar@gmail.com', '9876543231',
 'Kengeri, Bengaluru, Karnataka', 'CUSTOMER'),

('Nandini Rao', 'Nandini@123', 'nandini.rao@gmail.com', '9876543232',
 'Frazer Town, Bengaluru, Karnataka', 'CUSTOMER'),

('Rakesh Gowda', 'Rakesh@123', 'rakesh.gowda@gmail.com', '9876543233',
 'Varthur, Bengaluru, Karnataka', 'CUSTOMER'),

('Swathi Reddy', 'Swathi@123', 'swathi.reddy@gmail.com', '9876543234',
 'Hoodi, Bengaluru, Karnataka', 'CUSTOMER'),

('Prakash Shetty', 'Prakash@123', 'prakash.shetty@gmail.com', '9876543235',
 'Basaveshwaranagar, Bengaluru, Karnataka', 'CUSTOMER'),

('Neha Sharma', 'Neha@123', 'neha.sharma@gmail.com', '9876543236',
 'Cox Town, Bengaluru, Karnataka', 'CUSTOMER'),

('Varun Raj', 'Varun@123', 'varun.raj@gmail.com', '9876543237',
 'Domlur, Bengaluru, Karnataka', 'CUSTOMER'),

('Keerthi Anand', 'Keerthi@123', 'keerthi.anand@gmail.com', '9876543238',
 'Kumaraswamy Layout, Bengaluru, Karnataka', 'CUSTOMER'),

('Ravi Teja', 'Ravi@123', 'ravi.teja@gmail.com', '9876543239',
 'Peenya, Bengaluru, Karnataka', 'CUSTOMER'),

('Deepika Rao', 'Deepika@123', 'deepika.rao@gmail.com', '9876543240',
 'Shivajinagar, Bengaluru, Karnataka', 'CUSTOMER');


-- ================================================================================================================================
-- inserting the restaurant query
-- =================================================================================================================================


USE foodora;

INSERT INTO restaurant
(name, cuisineType, deliveryTime, address, adminUserId, rating, isActive, imagePath)
VALUES

('The Rameshwaram Cafe',
 'South Indian, Tiffins', 33,
 'Indiranagar, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.6, TRUE, 'images/restaurants/coffe.jfif'),

('Vidyarthi Bhavan',
 'South Indian, Dosa', 28,
 '32, Gandhi Bazaar Main Road, Basavanagudi, Bengaluru, Karnataka 560004',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.5, TRUE, 'images/restaurants/vidya_dosa.jfif'),

('MTR',
 'South Indian, Breakfast', 33,
 '14, Lalbagh Road, Mavalli, Bengaluru, Karnataka 560004',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.5, TRUE, 'images/restaurants/mtr_rava_dosa.jfif'),

('CTR',
 'South Indian, Dosa', 28,
 '7th Cross, Margosa Road, Malleshwaram, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.5, TRUE, 'images/restaurants/benne_dosa.jfif'),

('Brahmins Coffee Bar',
 'South Indian, Coffee', 23,
 '3, Ranga Rao Road, Basavanagudi, Bengaluru, Karnataka 560004',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.4, TRUE, 'images/restaurants/Brahmins_Coffee .jfif'),

('Veena Stores',
 'South Indian, Tiffins', 28,
 '187, 15th Cross, Margosa Road, Malleshwaram, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.4, TRUE, 'images/restaurants/veena_stores.jfif'),

('Meghana Foods',
 'Andhra, Biryani, Non-Veg', 33,
 '90/4, Outer Ring Road, Marathahalli, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.5, TRUE, 'images/restaurants/Meghana.jfif'),

('Nagarjuna',
 'Andhra, Biryani, South Indian', 35,
 '44/1, Residency Road, Bengaluru, Karnataka 560025',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.4, TRUE, 'images/restaurants/Nagarjuna.jfif'),

('Nandhana Palace',
 'Andhra, Biryani, Kebabs', 33,
 '4034, HAL 2nd Stage, 100 Feet Road, Indiranagar, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.3, TRUE, 'images/restaurants/nandana_palace.jfif'),

('Shivaji Military Hotel',
 'Karnataka, Non-Veg', 35,
 '718, 1C Main Road, 45th Cross, 8th Block, Jayanagar, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.4, TRUE, 'images/restaurants/Shivaji Millitary.jfif'),

('Empire Restaurant',
 'Indian, Kebabs, Biryani', 30,
 '78, Center Street, Shivajinagar, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.2, TRUE, 'images/restaurants/Empire.jfif'),

('Truffles',
 'Burgers, Italian, Desserts', 35,
 '22, St. Marks Road, Bengaluru, Karnataka 560001',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.9, TRUE, 'images/restaurants/Truffles, Bangalore_.jfif'),

('Toit',
 'Italian, Pizza, Continental', 40,
 '298, Namma Metro Pillar 62, 100 Feet Road, Indiranagar, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.9, TRUE, 'images/restaurants/toit bangalore.jfif'),

('Karavalli',
 'Coastal, Seafood, Karnataka', 45,
 'Vivanta Bengaluru, 66, Residency Road, Bengaluru, Karnataka 560025',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.8, TRUE, 'images/restaurants/Karavalli.jfif'),

('Halli Mane',
 'Karnataka, Traditional', 30,
 '3rd Cross, Sampige Road, Malleshwaram, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.3, TRUE, 'images/restaurants/halli.jfif'),

('Taaza Thindi',
 'South Indian, Tiffins', 23,
 '1004, 26th Main, 4th T Block, Jayanagar, Bengaluru, Karnataka 560041',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.4, TRUE, 'images/restaurants/taza.jfif'),

('Koshy''s',
 'Indian, Continental, Cafe', 35,
 '39, St. Marks Road, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.2, TRUE, 'images/restaurants/Koshy''s, Bangalore.jfif'),

('Maiyas',
 'South Indian, Vegetarian', 30,
 '459/30, 30th Cross, 4th Block, Jayanagar, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.3, TRUE, 'images/restaurants/masala_dosa.jfif'),

('Oota',
 'Karnataka, Mangalorean', 40,
 '331, 5B, EPIP Zone, Whitefield, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.9, TRUE, 'images/restaurants/oota.jfif'),

('Windmills Craftworks',
 'Continental, North Indian', 45,
 '6th Floor, Craftworks, 331, 5B Road, EPIP Zone, Whitefield, Bengaluru, Karnataka 560066',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.8, TRUE, 'images/restaurants/Windmills.jfif'),

('Burma Burma',
 'Burmese, Asian', 35,
 '607, Ground Floor, 12th Main, HAL 2nd Stage, Indiranagar, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.8, TRUE, 'images/restaurants/Burma Burma restaurant.jfif'),

('Toscano',
 'Italian, Pizza, Pasta, Continental', 40,
 '2nd Floor, UB City, Vittal Mallya Road, Bengaluru, Karnataka',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.4, TRUE, 'images/restaurants/Toscano restaurant.jfif'),

('Punjab Grill',
 'North Indian, Mughlai, Kebab', 40,
 '3rd Floor, Food Court, Orion Mall, Dr Rajkumar Road, Bengaluru, Karnataka 560055',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.3, TRUE, 'images/restaurants/punjab_grill.jfif'),

('Smoke House Deli',
 'Continental, Italian, BBQ', 40,
 'Shop 52, Ground Floor, Shanthala Nagar, Ashok Nagar, Lavelle Road, Bengaluru, Karnataka 560001',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.6, TRUE, 'images/restaurants/Smoke House Deli.jfif'),

('Be LURU',
 'Modern Indian, Asian, Bar', 40,
 '8th Floor, 10, Sankey Road, Kumarapark West, Bengaluru, Karnataka 560020',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.2, TRUE, 'images/restaurants/be luru.avif'),

('JW Kitchen',
 'Indian, International, Asian', 40,
 '24, Vittal Mallya Road, Bengaluru, Karnataka 560001',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.6, TRUE, 'images/restaurants/JW Kitchen.jfif'),

('Nazaara',
 'Indian', 45,
 'Courtyard by Marriott Bengaluru Hebbal, 2/55 Outer Ring Road, Bengaluru, Karnataka 560045',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 4.3, TRUE, 'images/restaurants/Nazaara restaurant.webp'),

('Dash and Coop',
 'Gourmet Burgers', 35,
 'Jayalakshmi Chambers, 57/1, 2nd Cross, Residency Road, Ashok Nagar, Bengaluru, Karnataka 560025',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 3.8, TRUE, 'images/restaurants/Dash and Coop.png'),

('AL-DAAZ',
 'North Indian, Chinese, Mughlai, BBQ, Biryani', 35,
 '64 & 65, Sector 1, 27th Main Road, HSR, Bengaluru, Karnataka 560102',
 (SELECT userId FROM user WHERE email = 'admin@foodora.in' AND role = 'ADMIN' LIMIT 1),
 3.9, TRUE, 'images/restaurants/AL-DAAZ Bangalore food.jfif');
 
 
 
 
 -- -----------------------------------------------------------------------------------------------------

-- menu insert code

use foodora;


INSERT INTO menu
(restaurantId, itemName, description, price, isAvailable, imagePath)
VALUES

-- 1. THE RAMESHWARAM CAFE
(1,'Ghee Podi Idli','Soft idlis topped with ghee and podi',90,TRUE,'images/menu/morning/idly.jfif'),
(1,'Masala Dosa','Crispy dosa with potato masala',120,TRUE,'images/menu/morning/masala_dosa.jfif'),
(1,'Pesarattu','Green gram dosa with chutney',110,TRUE,'images/menu/morning/Pesarattu.jfif'),
(1,'Thatte Idli','Soft Karnataka-style flat idli',80,TRUE,'images/menu/morning/Thatte_idli.jfif'),
(1,'Rava Dosa','Thin crispy semolina dosa',115,TRUE,'images/menu/morning/rava_dosa.jfif'),
(1,'Medu Vada','Crispy South Indian lentil fritters',75,TRUE,'images/menu/morning/vada.jfif'),
(1,'Kesar Pongal','Soft rice and lentil pongal',95,TRUE,'images/menu/morning/pongal.jfif'),
(1,'Poori Masala','Fluffy pooris with potato masala',100,TRUE,'images/menu/morning/poori.jfif'),
(1,'Plain Dosa','Crispy traditional plain dosa',90,TRUE,'images/menu/morning/plane_dosa.jfif'),
(1,'Upma','Savory semolina breakfast',70,TRUE,'images/menu/morning/upma.jfif'),

-- 2. VIDYARTHI BHAVAN
(2,'Benne Masala Dosa','Butter dosa with potato filling',110,TRUE,'images/menu/morning/masala_dosa.jfif'),
(2,'Benne Plain Dosa','Crispy butter dosa with chutney',100,TRUE,'images/menu/morning/plane_dosa.jfif'),
(2,'Special Idli','Soft steamed idlis with chutney',70,TRUE,'images/menu/morning/idly.jfif'),
(2,'Karnataka Thatte Idli','Traditional flat idli',75,TRUE,'images/menu/morning/Thatte_idli.jfif'),
(2,'Khara Bath','Savory semolina breakfast',75,TRUE,'images/menu/morning/upma.jfif'),
(2,'Vada Sambar','Crispy vada with sambar',70,TRUE,'images/menu/morning/vada.jfif'),
(2,'Kesari Bath','Sweet semolina preparation',70,TRUE,'images/menu/morning/pongal.jfif'),
(2,'Poori Saagu','Poori with vegetable saagu',90,TRUE,'images/menu/morning/poori.jfif'),
(2,'Rava Dosa Special','Crispy rava dosa',105,TRUE,'images/menu/morning/rava_dosa.jfif'),
(2,'Green Gram Dosa','Protein-rich green gram dosa',100,TRUE,'images/menu/morning/Pesarattu.jfif'),

-- 3. MTR
(3,'MTR Rava Dosa','Crispy semolina dosa',125,TRUE,'images/menu/morning/rava_dosa.jfif'),
(3,'MTR Idli','Soft steamed idli',90,TRUE,'images/menu/morning/idly.jfif'),
(3,'MTR Masala Dosa','Traditional masala dosa',130,TRUE,'images/menu/morning/masala_dosa.jfif'),
(3,'MTR Pesarattu','Green gram dosa with chutney',120,TRUE,'images/menu/morning/Pesarattu.jfif'),
(3,'MTR Poori','Poori with vegetable accompaniment',105,TRUE,'images/menu/morning/poori.jfif'),
(3,'MTR Vada','Traditional crispy vada',85,TRUE,'images/menu/morning/vada.jfif'),
(3,'MTR Pongal','Classic rice and lentil pongal',100,TRUE,'images/menu/morning/pongal.jfif'),
(3,'MTR Upma','Freshly prepared vegetable upma',90,TRUE,'images/menu/morning/upma.jfif'),
(3,'MTR Thatte Idli','Soft traditional Karnataka idli',85,TRUE,'images/menu/morning/Thatte_idli.jfif'),
(3,'MTR Plain Dosa','Crispy plain dosa',110,TRUE,'images/menu/morning/plane_dosa.jfif'),

-- 4. CTR
(4,'CTR Benne Dosa','Crispy dosa prepared with butter',110,TRUE,'images/menu/morning/masala_dosa.jfif'),
(4,'CTR Plain Dosa','Traditional crispy dosa',95,TRUE,'images/menu/morning/plane_dosa.jfif'),
(4,'CTR Idli','Soft steamed idli',70,TRUE,'images/menu/morning/idly.jfif'),
(4,'CTR Vada','Crispy lentil vada',65,TRUE,'images/menu/morning/vada.jfif'),
(4,'CTR Rava Dosa','Thin crispy rava dosa',105,TRUE,'images/menu/morning/rava_dosa.jfif'),
(4,'CTR Pesarattu','Green gram dosa',100,TRUE,'images/menu/morning/Pesarattu.jfif'),
(4,'CTR Pongal','Traditional rice and lentil pongal',85,TRUE,'images/menu/morning/pongal.jfif'),
(4,'CTR Poori','Fluffy pooris with potato side',90,TRUE,'images/menu/morning/poori.jfif'),
(4,'CTR Upma','Savory South Indian upma',70,TRUE,'images/menu/morning/upma.jfif'),
(4,'CTR Thatte Idli','Soft flat Karnataka idli',75,TRUE,'images/menu/morning/Thatte_idli.jfif'),

-- 5. BRAHMINS COFFEE BAR
(5,'Brahmins Idli Vada','Soft idli with crispy vada',75,TRUE,'images/menu/morning/idly.jfif'),
(5,'Brahmins Vada','Crispy traditional vada',60,TRUE,'images/menu/morning/vada.jfif'),
(5,'Brahmins Masala Dosa','Crispy dosa with potato masala',95,TRUE,'images/menu/morning/masala_dosa.jfif'),
(5,'Brahmins Plain Dosa','Classic crispy dosa',85,TRUE,'images/menu/morning/plane_dosa.jfif'),
(5,'Brahmins Rava Dosa','Crispy semolina dosa',90,TRUE,'images/menu/morning/rava_dosa.jfif'),
(5,'Brahmins Poori','Poori with potato accompaniment',80,TRUE,'images/menu/morning/poori.jfif'),
(5,'Brahmins Upma','Savory semolina breakfast',65,TRUE,'images/menu/morning/upma.jfif'),
(5,'Brahmins Pongal','Soft traditional pongal',75,TRUE,'images/menu/morning/pongal.jfif'),
(5,'Brahmins Pesarattu','Green gram dosa',90,TRUE,'images/menu/morning/Pesarattu.jfif'),
(5,'Brahmins Thatte Idli','Karnataka-style flat idli',70,TRUE,'images/menu/morning/Thatte_idli.jfif'),

-- 6. VEENA STORES
(6,'Veena Special Idli','Soft idli served with chutney',70,TRUE,'images/menu/morning/idly.jfif'),
(6,'Veena Masala Dosa','Crispy dosa with potato filling',100,TRUE,'images/menu/morning/masala_dosa.jfif'),
(6,'Veena Plain Dosa','Classic crispy dosa',90,TRUE,'images/menu/morning/plane_dosa.jfif'),
(6,'Veena Rava Dosa','Thin crispy rava dosa',95,TRUE,'images/menu/morning/rava_dosa.jfif'),
(6,'Veena Vada','Crispy South Indian vada',65,TRUE,'images/menu/morning/vada.jfif'),
(6,'Veena Poori','Fresh pooris with potato side',85,TRUE,'images/menu/morning/poori.jfif'),
(6,'Veena Pongal','Traditional rice and lentil dish',80,TRUE,'images/menu/morning/pongal.jfif'),
(6,'Veena Upma','Savory semolina breakfast',65,TRUE,'images/menu/morning/upma.jfif'),
(6,'Veena Pesarattu','Green gram dosa',90,TRUE,'images/menu/morning/Pesarattu.jfif'),
(6,'Veena Thatte Idli','Soft flat Karnataka idli',70,TRUE,'images/menu/morning/Thatte_idli.jfif'),

-- 7. MEGHANA FOODS
(7,'Chicken Dum Biryani','Aromatic chicken biryani',280,TRUE,'images/menu/afternoon/biryani.jfif'),
(7,'Andhra Chicken Curry','Spicy Andhra-style chicken curry',260,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(7,'Chicken Fried Rice','Indo-Chinese chicken fried rice',230,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(7,'Mutton Biryani','Rich mutton biryani',330,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(7,'Fish Curry','South Indian fish curry',270,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(7,'Paneer Curry','Spiced paneer curry',220,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(7,'Veg Biryani','Fragrant vegetable biryani',190,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(7,'Veg Fried Rice','Vegetable fried rice',180,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(7,'Andhra Meals','Complete South Indian thali meal',210,TRUE,'images/menu/afternoon/thali.jfif'),
(7,'Chicken Biryani Meal','Chicken biryani with traditional sides',300,TRUE,'images/menu/night/hyd_biryani.jfif'),

-- 8. NAGARJUNA
(8,'Nagarjuna Chicken Biryani','Spicy Andhra chicken biryani',290,TRUE,'images/menu/afternoon/biryani.jfif'),
(8,'Nagarjuna Chicken Curry','Traditional Andhra chicken curry',250,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(8,'Nagarjuna Mutton Biryani','Aromatic mutton biryani',340,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(8,'Nagarjuna Fish Curry','Spicy coastal fish curry',280,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(8,'Nagarjuna Paneer Curry','Indian cottage cheese curry',220,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(8,'Nagarjuna Veg Biryani','Aromatic vegetable biryani',190,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(8,'Nagarjuna Fried Rice','Vegetable fried rice',180,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(8,'Nagarjuna Special Thali','Traditional Andhra vegetarian meal',230,TRUE,'images/menu/afternoon/thali.jfif'),
(8,'Nagarjuna Chicken Rice','Spiced chicken fried rice',240,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(8,'Hyderabadi Chicken Biryani','Fragrant chicken biryani',300,TRUE,'images/menu/night/hyd_biryani.jfif'),

-- 9. NANDHANA PALACE
(9,'Nandhana Chicken Biryani','Andhra-style chicken biryani',280,TRUE,'images/menu/afternoon/biryani.jfif'),
(9,'Nandhana Mutton Biryani','Rich mutton biryani',330,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(9,'Chicken 65','Crispy spicy chicken appetizer',220,TRUE,'images/menu/evening/chicken65.jfif'),
(9,'Chicken Tikka','Grilled marinated chicken',240,TRUE,'images/menu/evening/tikka.jfif'),
(9,'Seekh Kebab','Spiced grilled minced meat kebab',250,TRUE,'images/menu/night/kabab.jfif'),
(9,'Hyderabadi Biryani','Aromatic Hyderabad-style biryani',290,TRUE,'images/menu/night/hyd_biryani.jfif'),
(9,'Chicken Curry','Traditional spicy chicken curry',250,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(9,'Fish Curry','Spiced fish curry',270,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(9,'Paneer Masala','Rich paneer gravy',210,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(9,'Tandoori Chicken','Clay-oven roasted chicken',300,TRUE,'images/menu/night/tandoori.jfif'),

-- 10. SHIVAJI MILITARY HOTEL
(10,'Donne Chicken Biryani','Karnataka-style chicken biryani',250,TRUE,'images/menu/afternoon/biryani.jfif'),
(10,'Mutton Biryani Special','Spiced mutton biryani',320,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(10,'Chicken Kabab','Crispy spiced chicken kabab',220,TRUE,'images/menu/night/kabab.jfif'),
(10,'Chicken Tikka','Char-grilled chicken tikka',230,TRUE,'images/menu/evening/tikka.jfif'),
(10,'Chicken Curry','Traditional Karnataka chicken curry',240,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(10,'Fish Curry','Spiced fish curry',260,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(10,'Mutton Curry','Slow-cooked mutton curry',290,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(10,'Chicken 65','Crispy South Indian chicken starter',210,TRUE,'images/menu/evening/chicken65.jfif'),
(10,'Tandoori Chicken','Roasted chicken with Indian spices',280,TRUE,'images/menu/night/tandoori.jfif'),
(10,'Special Non Veg Meal','Traditional Karnataka non-vegetarian meal',300,TRUE,'images/menu/afternoon/thali.jfif'),

-- 11. EMPIRE RESTAURANT
(11,'Empire Chicken Biryani','Fragrant chicken biryani',250,TRUE,'images/menu/afternoon/biryani.jfif'),
(11,'Empire Chicken Kabab','Spiced fried chicken kabab',220,TRUE,'images/menu/night/kabab.jfif'),
(11,'Empire Chicken 65','Crispy spicy chicken',210,TRUE,'images/menu/evening/chicken65.jfif'),
(11,'Empire Tandoori Chicken','Tandoori roasted chicken',280,TRUE,'images/menu/night/tandoori.jfif'),
(11,'Empire Chicken Curry','Rich Indian chicken curry',240,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(11,'Empire Fish Curry','Spiced fish curry',260,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(11,'Empire Paneer Curry','Creamy paneer curry',200,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(11,'Empire Veg Biryani','Aromatic vegetable biryani',180,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(11,'Empire Fried Rice','Vegetable fried rice',170,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(11,'Empire Special Thali','Complete Indian meal platter',220,TRUE,'images/menu/afternoon/thali.jfif'),

-- 12. TRUFFLES
(12,'Classic Chicken Burger','Juicy chicken burger with fresh toppings',220,TRUE,'images/menu/evening/chiken_burger.jfif'),
(12,'Crispy Chicken Sandwich','Crispy chicken sandwich with sauces',210,TRUE,'images/menu/evening/chicken_sand.jfif'),
(12,'Loaded French Fries','Crispy fries with seasoning',150,TRUE,'images/menu/evening/french fries.jfif'),
(12,'Cheese Pizza','Cheesy baked pizza',240,TRUE,'images/menu/night/pizza.jfif'),
(12,'Veg Sandwich','Fresh vegetable sandwich',160,TRUE,'images/menu/evening/Sandwich.jfif'),
(12,'Chicken Fried Rice','Indo-Chinese chicken fried rice',230,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(12,'Chicken 65','Crispy spicy chicken bites',200,TRUE,'images/menu/evening/chicken65.jfif'),
(12,'Chicken Tikka','Grilled chicken tikka',230,TRUE,'images/menu/evening/tikka.jfif'),
(12,'Garlic Noodles','Stir-fried noodles with vegetables',190,TRUE,'images/menu/night/Noodles.jfif'),
(12,'Chicken Shawarma','Chicken shawarma roll with sauces',210,TRUE,'images/menu/night/Shawarma.jfif'),

-- 13. TOIT
(13,'Margherita Pizza','Classic tomato and cheese pizza',280,TRUE,'images/menu/night/pizza.jfif'),
(13,'Chicken Burger','Grilled chicken burger',260,TRUE,'images/menu/evening/chiken_burger.jfif'),
(13,'Chicken Sandwich','Grilled chicken sandwich',240,TRUE,'images/menu/evening/chicken_sand.jfif'),
(13,'French Fries','Crispy seasoned fries',160,TRUE,'images/menu/evening/french fries.jfif'),
(13,'Veg Sandwich','Fresh vegetable sandwich',180,TRUE,'images/menu/evening/Sandwich.jfif'),
(13,'Paneer Curry','Indian-style paneer curry',220,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(13,'Veg Fried Rice','Seasoned vegetable fried rice',200,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(13,'Chicken Fried Rice','Wok-fried chicken rice',240,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(13,'Vegetable Noodles','Stir-fried vegetable noodles',190,TRUE,'images/menu/night/Noodles.jfif'),
(13,'Chicken Tikka','Grilled Indian chicken tikka',250,TRUE,'images/menu/evening/tikka.jfif'),

-- 14. KARAVALLI
(14,'Coastal Fish Curry','Traditional coastal fish curry',320,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(14,'Mangalorean Chicken Curry','Traditional coastal chicken curry',300,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(14,'Mutton Biryani','Aromatic coastal-style mutton biryani',360,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(14,'Vegetable Thali','Traditional Karnataka vegetarian meal',280,TRUE,'images/menu/afternoon/thali.jfif'),
(14,'Paneer Curry','Indian cottage cheese curry',260,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(14,'Veg Biryani','Fragrant vegetable rice preparation',230,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(14,'Fish Fry','Spiced fried fish',330,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(14,'Chicken Tikka','Char-grilled chicken pieces',280,TRUE,'images/menu/evening/tikka.jfif'),
(14,'Tandoori Chicken','Traditional clay-oven chicken',320,TRUE,'images/menu/night/tandoori.jfif'),
(14,'Special Coastal Biryani','Aromatic coastal rice preparation',350,TRUE,'images/menu/night/hyd_biryani.jfif'),

-- 15. HALLI MANE
(15,'Halli Mane Idli','Traditional Karnataka steamed idli',70,TRUE,'images/menu/morning/idly.jfif'),
(15,'Halli Mane Dosa','Crispy traditional dosa',90,TRUE,'images/menu/morning/plane_dosa.jfif'),
(15,'Halli Mane Masala Dosa','Dosa filled with potato masala',105,TRUE,'images/menu/morning/masala_dosa.jfif'),
(15,'Halli Mane Vada','Crispy lentil fritter',65,TRUE,'images/menu/morning/vada.jfif'),
(15,'Halli Mane Pongal','Traditional rice and lentil pongal',80,TRUE,'images/menu/morning/pongal.jfif'),
(15,'Halli Mane Poori','Poori with vegetable side',90,TRUE,'images/menu/morning/poori.jfif'),
(15,'Halli Mane Upma','Fresh Karnataka-style upma',70,TRUE,'images/menu/morning/upma.jfif'),
(15,'Halli Mane Rava Dosa','Crispy semolina dosa',100,TRUE,'images/menu/morning/rava_dosa.jfif'),
(15,'Halli Mane Pesarattu','Green gram dosa',95,TRUE,'images/menu/morning/Pesarattu.jfif'),
(15,'Halli Mane Thatte Idli','Soft flat Karnataka idli',75,TRUE,'images/menu/morning/Thatte_idli.jfif'),

-- 16. TAAZA THINDI
(16,'Taaza Masala Dosa','Crispy dosa with potato masala',80,TRUE,'images/menu/morning/masala_dosa.jfif'),
(16,'Taaza Idli','Soft steamed idli',55,TRUE,'images/menu/morning/idly.jfif'),
(16,'Taaza Vada','Crispy vada',50,TRUE,'images/menu/morning/vada.jfif'),
(16,'Taaza Rava Dosa','Thin crispy rava dosa',75,TRUE,'images/menu/morning/rava_dosa.jfif'),
(16,'Taaza Poori','Fluffy poori with potato side',70,TRUE,'images/menu/morning/poori.jfif'),
(16,'Taaza Pongal','Soft traditional pongal',65,TRUE,'images/menu/morning/pongal.jfif'),
(16,'Taaza Upma','Savory semolina breakfast',55,TRUE,'images/menu/morning/upma.jfif'),
(16,'Taaza Pesarattu','Green gram dosa',80,TRUE,'images/menu/morning/Pesarattu.jfif'),
(16,'Taaza Plain Dosa','Traditional crispy dosa',70,TRUE,'images/menu/morning/plane_dosa.jfif'),
(16,'Taaza Thatte Idli','Soft Karnataka-style idli',60,TRUE,'images/menu/morning/Thatte_idli.jfif'),

-- 17. KOSHY'S
(17,'Koshys Chicken Sandwich','Classic chicken sandwich',220,TRUE,'images/menu/evening/chicken_sand.jfif'),
(17,'Koshys Veg Sandwich','Fresh vegetable sandwich',180,TRUE,'images/menu/evening/Sandwich.jfif'),
(17,'Koshys Chicken Burger','Classic chicken burger',230,TRUE,'images/menu/evening/chiken_burger.jfif'),
(17,'Koshys French Fries','Crispy golden fries',150,TRUE,'images/menu/evening/french fries.jfif'),
(17,'Koshys Chicken Tikka','Grilled chicken tikka',240,TRUE,'images/menu/evening/tikka.jfif'),
(17,'Koshys Vegetable Fried Rice','Seasoned vegetable fried rice',190,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(17,'Koshys Chicken Fried Rice','Chicken fried rice',220,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(17,'Koshys Paneer Curry','Indian paneer curry',210,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(17,'Koshys Chicken Curry','Traditional chicken curry',240,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(17,'Koshys Pizza','Classic cheese pizza',250,TRUE,'images/menu/night/pizza.jfif'),

-- 18. MAIYAS
(18,'Maiyas Masala Dosa','Crispy masala dosa',100,TRUE,'images/menu/morning/masala_dosa.jfif'),
(18,'Maiyas Idli','Soft steamed idlis',75,TRUE,'images/menu/morning/idly.jfif'),
(18,'Maiyas Vada','Crispy South Indian vada',65,TRUE,'images/menu/morning/vada.jfif'),
(18,'Maiyas Rava Dosa','Crispy semolina dosa',105,TRUE,'images/menu/morning/rava_dosa.jfif'),
(18,'Maiyas Poori','Fluffy poori with potato masala',90,TRUE,'images/menu/morning/poori.jfif'),
(18,'Maiyas Pongal','Traditional South Indian pongal',85,TRUE,'images/menu/morning/pongal.jfif'),
(18,'Maiyas Upma','Savory semolina breakfast',70,TRUE,'images/menu/morning/upma.jfif'),
(18,'Maiyas Pesarattu','Green gram dosa',100,TRUE,'images/menu/morning/Pesarattu.jfif'),
(18,'Maiyas Plain Dosa','Traditional plain dosa',90,TRUE,'images/menu/morning/plane_dosa.jfif'),
(18,'Maiyas Thatte Idli','Traditional flat idli',80,TRUE,'images/menu/morning/Thatte_idli.jfif'),

-- 19. OOTA
(19,'Oota Karnataka Thali','Traditional Karnataka vegetarian meal',280,TRUE,'images/menu/afternoon/thali.jfif'),
(19,'Oota Veg Biryani','Aromatic vegetable biryani',230,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(19,'Oota Chicken Biryani','Spiced chicken biryani',290,TRUE,'images/menu/afternoon/biryani.jfif'),
(19,'Oota Fish Curry','Traditional fish curry',320,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(19,'Oota Chicken Curry','Karnataka-style chicken curry',280,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(19,'Oota Paneer Curry','Spiced paneer gravy',240,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(19,'Oota Mutton Biryani','Rich mutton biryani',360,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(19,'Oota Tandoori Chicken','Roasted tandoori chicken',320,TRUE,'images/menu/night/tandoori.jfif'),
(19,'Oota Chicken Tikka','Grilled chicken tikka',280,TRUE,'images/menu/evening/tikka.jfif'),
(19,'Oota Special Biryani','Special aromatic rice preparation',320,TRUE,'images/menu/night/hyd_biryani.jfif'),

-- 20. WINDMILLS CRAFTWORKS
(20,'Windmills Pizza','Wood-fired style cheese pizza',320,TRUE,'images/menu/night/pizza.jfif'),
(20,'Windmills Chicken Burger','Gourmet chicken burger',300,TRUE,'images/menu/evening/chiken_burger.jfif'),
(20,'Windmills Chicken Sandwich','Gourmet chicken sandwich',280,TRUE,'images/menu/evening/chicken_sand.jfif'),
(20,'Windmills French Fries','Seasoned crispy fries',180,TRUE,'images/menu/evening/french fries.jfif'),
(20,'Windmills Veg Sandwich','Fresh gourmet vegetable sandwich',220,TRUE,'images/menu/evening/Sandwich.jfif'),
(20,'Windmills Chicken Tikka','Grilled chicken starter',300,TRUE,'images/menu/evening/tikka.jfif'),
(20,'Windmills Chicken Fried Rice','Wok-fried chicken rice',280,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(20,'Windmills Veg Fried Rice','Wok-fried vegetable rice',240,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(20,'Windmills Noodles','Stir-fried noodles',230,TRUE,'images/menu/night/Noodles.jfif'),
(20,'Windmills Tandoori','Indian-style roasted chicken',320,TRUE,'images/menu/night/tandoori.jfif'),

-- 21. BURMA BURMA
(21,'Burmese Khao Suey','Burmese noodle bowl with coconut broth',290,TRUE,'images/menu/night/Noodles.jfif'),
(21,'Burmese Veg Fried Rice','Asian-style vegetable fried rice',230,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(21,'Burmese Chicken Noodles','Burmese-inspired chicken noodles',260,TRUE,'images/menu/night/Noodles.jfif'),
(21,'Burmese Vegetable Curry','Fragrant vegetable curry',220,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(21,'Asian Chicken Curry','Mild aromatic chicken curry',270,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(21,'Burmese Paneer Curry','Creamy vegetarian curry',230,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(21,'Burmese Veg Rice','Fragrant vegetable rice',210,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(21,'Asian Chicken Fried Rice','Wok-fried chicken rice',250,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(21,'Burmese Tofu Curry','Spiced vegetarian curry',220,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(21,'Burmese Special Meal','Assorted Asian-inspired meal',300,TRUE,'images/menu/afternoon/thali.jfif'),

-- 22. TOSCANO
(22,'Toscano Margherita','Classic Italian tomato and cheese pizza',320,TRUE,'images/menu/night/pizza.jfif'),
(22,'Toscano Chicken Pizza','Italian pizza topped with chicken',360,TRUE,'images/menu/night/pizza.jfif'),
(22,'Toscano Chicken Pasta','Creamy Italian-style chicken pasta',340,TRUE,'images/menu/night/Noodles.jfif'),
(22,'Toscano Veg Pasta','Italian vegetable pasta',300,TRUE,'images/menu/night/Noodles.jfif'),
(22,'Toscano Chicken Burger','Italian-inspired gourmet burger',290,TRUE,'images/menu/evening/chiken_burger.jfif'),
(22,'Toscano Chicken Sandwich','Grilled chicken sandwich',270,TRUE,'images/menu/evening/chicken_sand.jfif'),
(22,'Toscano French Fries','Crispy seasoned fries',170,TRUE,'images/menu/evening/french fries.jfif'),
(22,'Toscano Vegetable Rice','Italian-inspired vegetable rice',240,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(22,'Toscano Chicken Rice','Chicken rice preparation',280,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(22,'Toscano Grilled Chicken','Seasoned grilled chicken',350,TRUE,'images/menu/night/tandoori.jfif'),

-- 23. PUNJAB GRILL
(23,'Amritsari Chicken','Punjabi-style spiced chicken',320,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(23,'Murgh Tikka','Char-grilled Punjabi chicken tikka',340,TRUE,'images/menu/evening/tikka.jfif'),
(23,'Tandoori Chicken','Classic Punjabi tandoori chicken',360,TRUE,'images/menu/night/tandoori.jfif'),
(23,'Seekh Kebab','Traditional minced meat kebab',350,TRUE,'images/menu/night/kabab.jfif'),
(23,'Mughlai Chicken Biryani','Rich Mughlai-style chicken biryani',340,TRUE,'images/menu/night/hyd_biryani.jfif'),
(23,'Paneer Tikka Masala','Paneer in rich tomato gravy',280,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(23,'Punjabi Veg Thali','Traditional North Indian meal platter',300,TRUE,'images/menu/afternoon/thali.jfif'),
(23,'Veg Biryani','Fragrant vegetable biryani',240,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(23,'Chicken Fried Rice','Indian-style chicken fried rice',260,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(23,'Mutton Biryani','Rich Punjabi-style mutton biryani',380,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),

-- 24. SMOKE HOUSE DELI
(24,'Smoked Chicken Burger','Smoked chicken gourmet burger',280,TRUE,'images/menu/evening/chiken_burger.jfif'),
(24,'Smoked Chicken Sandwich','Smoked chicken sandwich',270,TRUE,'images/menu/evening/chicken_sand.jfif'),
(24,'Deli French Fries','Crispy seasoned fries',180,TRUE,'images/menu/evening/french fries.jfif'),
(24,'Chicken Tikka','Grilled chicken starter',280,TRUE,'images/menu/evening/tikka.jfif'),
(24,'Smoked Chicken Rice','Smoked chicken with seasoned rice',300,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(24,'Vegetable Fried Rice','Seasoned vegetable fried rice',230,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(24,'Chicken Curry','Rich smoked chicken curry',290,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(24,'Paneer Curry','Creamy paneer curry',250,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(24,'Deli Pizza','Gourmet cheese pizza',310,TRUE,'images/menu/night/pizza.jfif'),
(24,'Smoked Chicken Biryani','Aromatic smoked chicken biryani',320,TRUE,'images/menu/night/hyd_biryani.jfif'),

-- 25. BE LURU
(25,'Be LURU Chicken Biryani','Modern Indian chicken biryani',300,TRUE,'images/menu/afternoon/biryani.jfif'),
(25,'Be LURU Chicken Tikka','Modern Indian grilled chicken',280,TRUE,'images/menu/evening/tikka.jfif'),
(25,'Be LURU Tandoori','Indian-style roasted chicken',320,TRUE,'images/menu/night/tandoori.jfif'),
(25,'Be LURU Chicken Curry','Modern Indian chicken curry',270,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(25,'Be LURU Paneer Curry','Modern Indian paneer preparation',240,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(25,'Be LURU Veg Biryani','Aromatic vegetable biryani',220,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(25,'Be LURU Chicken Fried Rice','Asian-inspired chicken rice',260,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(25,'Be LURU Veg Fried Rice','Asian-style vegetable rice',220,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(25,'Be LURU Special Meal','Modern Indian meal platter',280,TRUE,'images/menu/afternoon/thali.jfif'),
(25,'Be LURU Seekh Kebab','Spiced grilled kebab',290,TRUE,'images/menu/night/kabab.jfif'),

-- 26. JW KITCHEN
(26,'JW Chicken Biryani','Aromatic Indian chicken biryani',340,TRUE,'images/menu/afternoon/biryani.jfif'),
(26,'JW Mutton Biryani','Rich mutton biryani',390,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(26,'JW Chicken Curry','Classic Indian chicken curry',310,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(26,'JW Fish Curry','Indian-style fish curry',330,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(26,'JW Paneer Curry','Rich paneer preparation',280,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(26,'JW Veg Biryani','Fragrant vegetable biryani',250,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(26,'JW Chicken Tikka','Grilled Indian chicken',320,TRUE,'images/menu/evening/tikka.jfif'),
(26,'JW Tandoori Chicken','Tandoori roasted chicken',350,TRUE,'images/menu/night/tandoori.jfif'),
(26,'JW Special Meal','Complete Indian meal',360,TRUE,'images/menu/afternoon/thali.jfif'),
(26,'JW Hyderabadi Biryani','Aromatic Hyderabad-style biryani',350,TRUE,'images/menu/night/hyd_biryani.jfif'),

-- 27. NAZAARA
(27,'Nazaara Chicken Biryani','Aromatic Indian chicken biryani',320,TRUE,'images/menu/afternoon/biryani.jfif'),
(27,'Nazaara Mutton Biryani','Rich mutton biryani',380,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(27,'Nazaara Chicken Curry','Indian spiced chicken curry',300,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(27,'Nazaara Fish Curry','Traditional Indian fish curry',320,TRUE,'images/menu/afternoon/fish_curry.jfif'),
(27,'Nazaara Paneer Curry','Rich paneer gravy',270,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(27,'Nazaara Veg Biryani','Aromatic vegetable biryani',240,TRUE,'images/menu/afternoon/veg_biryani.jfif'),
(27,'Nazaara Chicken Tikka','Grilled chicken tikka',300,TRUE,'images/menu/evening/tikka.jfif'),
(27,'Nazaara Tandoori Chicken','Roasted tandoori chicken',340,TRUE,'images/menu/night/tandoori.jfif'),
(27,'Nazaara Special Meal','Indian meal platter',330,TRUE,'images/menu/afternoon/thali.jfif'),
(27,'Nazaara Seekh Kebab','Grilled minced meat kebab',310,TRUE,'images/menu/night/kabab.jfif'),

-- 28. DASH AND COOP
(28,'Classic Coop Burger','Signature gourmet chicken burger',240,TRUE,'images/menu/evening/chiken_burger.jfif'),
(28,'Crispy Chicken Coop','Crispy chicken sandwich',230,TRUE,'images/menu/evening/chicken_sand.jfif'),
(28,'Coop French Fries','Crispy seasoned fries',160,TRUE,'images/menu/evening/french fries.jfif'),
(28,'Spicy Chicken Tikka','Spiced grilled chicken',230,TRUE,'images/menu/evening/tikka.jfif'),
(28,'Coop Chicken Fried Rice','Indo-Chinese chicken fried rice',220,TRUE,'images/menu/afternoon/chicken_fried_rice.jfif'),
(28,'Coop Vegetable Fried Rice','Seasoned vegetable rice',190,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(28,'Coop Chicken Curry','Spiced chicken curry',240,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(28,'Coop Paneer Curry','Indian paneer curry',210,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(28,'Coop Pizza','Cheesy gourmet pizza',260,TRUE,'images/menu/night/pizza.jfif'),
(28,'Coop Chicken Shawarma','Chicken shawarma roll',220,TRUE,'images/menu/night/Shawarma.jfif'),

-- 29. AL-DAAZ
(29,'AL-DAAZ Chicken Biryani','Aromatic chicken biryani',240,TRUE,'images/menu/afternoon/biryani.jfif'),
(29,'AL-DAAZ Mutton Biryani','Rich mutton biryani',300,TRUE,'images/menu/afternoon/Mutton Biryani.jfif'),
(29,'AL-DAAZ Chicken Curry','Spicy Indian chicken curry',220,TRUE,'images/menu/afternoon/chicken_curry.jfif'),
(29,'AL-DAAZ Paneer Curry','Rich paneer curry',190,TRUE,'images/menu/afternoon/panner_curry.jfif'),
(29,'AL-DAAZ Chicken 65','Crispy spicy chicken',180,TRUE,'images/menu/evening/chicken65.jfif'),
(29,'AL-DAAZ Chicken Tikka','Grilled chicken tikka',200,TRUE,'images/menu/evening/tikka.jfif'),
(29,'AL-DAAZ Seekh Kebab','Spiced grilled kebab',210,TRUE,'images/menu/night/kabab.jfif'),
(29,'AL-DAAZ Tandoori Chicken','Tandoori roasted chicken',250,TRUE,'images/menu/night/tandoori.jfif'),
(29,'AL-DAAZ Veg Fried Rice','Vegetable fried rice',170,TRUE,'images/menu/afternoon/veg_fried_rice.jfif'),
(29,'AL-DAAZ Chicken Noodles','Spicy chicken noodles',190,TRUE,'images/menu/night/Noodles.jfif');







