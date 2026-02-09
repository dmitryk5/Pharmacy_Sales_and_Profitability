-- Explore main dataset --

SELECT *
FROM pharmacy_data;

-- Explore date set -- 

SELECT * 
FROM dim_date;

-- Checking duration of dataset --
-- Note: dataset runs from 2024-01-01 to 2025-12-31 -- 

SELECT
    MIN("Date") AS first_date,
    MAX("Date") AS final_date
FROM dim_date;

-- Explore pharmacy dataset --

SELECT *
FROM dim_pharmacy;

-- Checking count of pharmacy's --
-- Note: 120 total pharmacy's in dataset --

SELECT
    "Country",
    COUNT(*) AS country_count
FROM dim_pharmacy
GROUP BY "Country"
ORDER BY country_count DESC;

-- Explore dim_product dataset --

SELECT *
FROM dim_product;

-- Check products discontinued --
-- Note: 35 products discontinued, 220 total --  

SELECT
    COUNT(*) AS total_products,
    SUM(CASE WHEN is_discontinued = 'Yes' THEN 1 ELSE 0 END) AS discontinued_products
FROM dim_product;



