-- View 1: everything, plus per-kg price
CREATE OR REPLACE VIEW v_prices_kg AS
SELECT *,
       ROUND(Modal_Price / 100, 2) AS Price_Per_Kg
FROM agri_prices;

-- View 2: monthly summary per commodity (ready for trend charts)
CREATE OR REPLACE VIEW v_monthly_prices AS
SELECT
    Commodity,
    Month_dt,
    Year,
    Month_num,
    ROUND(AVG(Modal_Price), 2)          AS Avg_Monthly_Price_Quintal,
    ROUND(AVG(Modal_Price) / 100, 2)    AS Avg_Monthly_Price_Kg,
    ROUND(SUM(Arrival_Quantity), 1)     AS Total_Arrivals
FROM agri_prices
GROUP BY Commodity, Month_dt, Year, Month_num;

-- 1-kg price of Onion over time (this IS your monthly per-kg trend!)
SELECT Commodity, Month_dt, Avg_Monthly_Price_Kg
FROM v_monthly_prices
WHERE Commodity = 'Onion'
ORDER BY Month_dt;
