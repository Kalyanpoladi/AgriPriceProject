CREATE DATABASE IF NOT EXISTS agriprice;
USE agriprice;
CREATE TABLE agri_prices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    State_UT VARCHAR(100),
    Commodity_Group VARCHAR(100),
    Commodity VARCHAR(100),
    Month VARCHAR(20),
    Arrival_Quantity DOUBLE,
    Arrival_Unit VARCHAR(50),
    Modal_Price DOUBLE,
    Price_Unit VARCHAR(50),
    Month_dt DATE,
    Month_num INT,
    Year INT
);
SHOW TABLES;
DESCRIBE agri_prices;


