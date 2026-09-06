-- ============================================
-- AgriPrice Project - Analysis Queries
-- Database: agriprice | Table: agri_prices
-- ============================================

-- Q1: Top 10 most demanded commodities (by total arrival quantity)
SELECT Commodity, ROUND(SUM(Arrival_Quantity), 1) AS Total_Arrivals
FROM agri_prices
GROUP BY Commodity
ORDER BY Total_Arrivals DESC
LIMIT 10;

-- Q2: Price change per commodity (Feb-2023 vs Sep-2026)
SELECT
    Commodity,
    ROUND(MAX(CASE WHEN Year = 2023 AND Month_num = 2 THEN Modal_Price END), 2) AS First_Price,
    ROUND(MAX(CASE WHEN Year = 2026 AND Month_num = 9 THEN Modal_Price END), 2) AS Last_Price,
    ROUND(
      (MAX(CASE WHEN Year = 2026 AND Month_num = 9 THEN Modal_Price END) -
       MAX(CASE WHEN Year = 2023 AND Month_num = 2 THEN Modal_Price END)) /
       MAX(CASE WHEN Year = 2023 AND Month_num = 2 THEN Modal_Price END) * 100
    , 1) AS Pct_Change
FROM agri_prices
GROUP BY Commodity
ORDER BY Pct_Change DESC;

-- Q3: Seasonal price pattern (average price by calendar month)
SELECT Month_num, ROUND(AVG(Modal_Price), 2) AS Avg_Price
FROM agri_prices
GROUP BY Month_num
ORDER BY Month_num;
