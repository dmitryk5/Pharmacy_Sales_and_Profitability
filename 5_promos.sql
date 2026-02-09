-- Effects from Promotions --
-- Q1. Which categories respond most to promotions? --
-- Q2. Which pharmacies get the most lift from promotions? --
-- Q3. Are top products promo-driven or organic? -- 

-- Promo effect by category --
-- Note: Promo sales represent only ~10–12% of volume --
-- Note: Core profitability is driven by non-promo sales --

SELECT
    dp.category,
    p.promo_flag,
    SUM(p.units_sold) AS units,
    SUM(p.revenue_eur) AS revenue,
    ROUND(SUM(p.revenue_eur)/NULLIF(SUM(p.units_sold),0),2) AS revenue_per_unit,
    ROUND(SUM(p.margin_eur)/NULLIF(SUM(p.revenue_eur),0)*100,2) AS margin_pct
FROM pharmacy_data p
JOIN dim_product dp
    ON p.product_id = dp.product_id
GROUP BY dp.category, p.promo_flag
ORDER BY dp.category, p.promo_flag;

-- Promo effect by pharmacy -- 
-- Note: Price discounts rarely translate into meaningful volume uplift. --
-- Note: Promotions reduce margins far more than they increase volume. --

SELECT
    ph.pharmacy_id,
    ph.pharmacy_name,
    p.promo_flag,
    SUM(p.units_sold) AS units,
    SUM(p.revenue_eur) AS revenue,
    ROUND(SUM(p.revenue_eur)/NULLIF(SUM(p.units_sold),0),2) AS revenue_per_unit,
    ROUND(SUM(p.margin_eur)/NULLIF(SUM(p.revenue_eur),0)*100,2) AS margin_pct
FROM pharmacy_data p
JOIN dim_pharmacy ph
    ON p.pharmacy_id = ph.pharmacy_id
GROUP BY ph.pharmacy_id, ph.pharmacy_name, p.promo_flag
ORDER BY ph.pharmacy_name, p.promo_flag;

-- Promo effect by product --
-- Note: Promotions consistently reduce both price and profitability --


SELECT
    dp.product_id,
    dp.product_name,
    p.promo_flag,
    SUM(p.units_sold) AS units,
    SUM(p.revenue_eur) AS revenue,
    ROUND(SUM(p.revenue_eur)/NULLIF(SUM(p.units_sold),0),2) AS revenue_per_unit,
    ROUND(SUM(p.margin_eur)/NULLIF(SUM(p.revenue_eur),0)*100,2) AS margin_pct
FROM pharmacy_data p
JOIN dim_product dp
    ON p.product_id = dp.product_id
GROUP BY dp.product_id, dp.product_name, p.promo_flag
ORDER BY dp.product_name, p.promo_flag;






