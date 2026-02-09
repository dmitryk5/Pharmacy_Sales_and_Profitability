-- Product Performance --
-- Q1. What products are driving revenue and growth? --
-- Q2. Which products are dragging performance down? --
-- Q3. How does product mix change over time? -- 
-- Q4. Are growth and seasonality concentrated in specific categories? --

-- Top products by revenue --

SELECT
    p.product_id,
    dp.product_name,
    SUM(p.revenue_eur) AS total_revenue,
    SUM(p.margin_eur) AS total_margin,
    SUM(p.units_sold) AS total_units
FROM pharmacy_data p
JOIN dim_product dp
    ON p.product_id = dp.product_id
GROUP BY p.product_id, dp.product_name
ORDER BY total_revenue DESC
LIMIT 20;

-- Revenue concentration (% of total) -> Dependency on top products --
-- Note: There is no large dependency on products -- 

WITH product_revenue AS (
    SELECT
        p.product_id,
        SUM(p.revenue_eur) AS revenue
    FROM pharmacy_data p
    GROUP BY p.product_id
),
total AS (
    SELECT SUM(revenue) AS total_revenue FROM product_revenue
)
SELECT
    pr.product_id,
    pr.revenue,
    ROUND(pr.revenue / t.total_revenue * 100, 2) AS revenue_pct
FROM product_revenue pr
CROSS JOIN total t
ORDER BY pr.revenue DESC
LIMIT 10;

-- Category level performance --
-- Note: Wellness and Personal Care have strongest margins (33%), Prescription has weakest margin (22%) -- 

SELECT
    dp.category,
    SUM(p.revenue_eur) AS total_revenue,
    SUM(p.margin_eur) AS total_margin,
    SUM(p.units_sold) AS total_units,
    ROUND(SUM(p.margin_eur) / NULLIF(SUM(p.revenue_eur), 0) * 100, 2) AS margin_pct
FROM pharmacy_data p
JOIN dim_product dp
    ON p.product_id = dp.product_id
GROUP BY dp.category
ORDER BY total_revenue DESC;

-- Product performance over time --

SELECT
    d.year_month,
    dp.category,
    SUM(p.revenue_eur) AS revenue
FROM pharmacy_data p
JOIN dim_date d
    ON p.date_key = d.date_key
JOIN dim_product dp
    ON p.product_id = dp.product_id
GROUP BY d.year_month, dp.category
ORDER BY d.year_month, revenue DESC;

-- Generic vs. Branded comparison --
-- Note: Branded products dominate revenue (85% branded/15% generic) -- 

SELECT
    dp.is_generic,
    SUM(p.revenue_eur) AS revenue,
    SUM(p.units_sold) AS units,
    ROUND(SUM(p.revenue_eur) / NULLIF(SUM(p.units_sold), 0), 2) AS revenue_per_unit
FROM pharmacy_data p
JOIN dim_product dp
    ON p.product_id = dp.product_id
GROUP BY dp.is_generic;

-- Generic vs. Branded Margin comparison --
-- Note: Branded products drive profit through scale, not efficiency -- 

SELECT
    dp.is_generic,
    SUM(p.revenue_eur) AS revenue,
    SUM(p.margin_eur) AS margin,
    ROUND(SUM(p.margin_eur) / NULLIF(SUM(p.revenue_eur),0) * 100, 2) AS margin_pct
FROM pharmacy_data p
JOIN dim_product dp
    ON p.product_id = dp.product_id
GROUP BY dp.is_generic;




