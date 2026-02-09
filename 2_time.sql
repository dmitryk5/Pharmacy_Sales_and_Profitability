-- Time based analytics --
-- Q1. How do sales and profitability evolve over time? --
-- Q2. Is there seasonality? --
-- Q3. Is there growth or decline? -- 
-- Q4. How do promotions behave across time? --

-- Monthly revenue, units, and margin --
-- Note: Steady margin growth --
-- Note: Revenue and Margin peak 2025-05 (why?) --

SELECT
    d.year_month,
    SUM(p.units_sold) AS total_units,
    SUM(p.revenue_eur) AS total_revenue,
    SUM(p.margin_eur) AS total_margin
FROM pharmacy_data p
JOIN dim_date d
    ON p.date_key = d.date_key
GROUP BY d.year_month
ORDER BY d.year_month;

-- Seasonality --
-- Note: Revenue highest between May-October (why?) --

SELECT
    d.month_number,
    d.month_name,
    SUM(f.revenue_eur) AS total_revenue,
    ROUND(AVG(f.revenue_eur),2) AS avg_revenue
FROM pharmacy_data f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.month_number, d.month_name
ORDER BY d.month_number;

-- Growth over time --
-- Note: Steady revenue growth MoM, May-July tends to be strongest period -- 

SELECT
    d.year_month,
    SUM(f.revenue_eur) AS revenue,
    LAG(SUM(f.revenue_eur)) OVER (ORDER BY d.year_month) AS prev_month_revenue,
    ROUND(
        (SUM(f.revenue_eur) - LAG(SUM(f.revenue_eur)) OVER (ORDER BY d.year_month))
        / NULLIF(LAG(SUM(f.revenue_eur)) OVER (ORDER BY d.year_month), 0) * 100,
        2
    ) AS mom_growth_pct
FROM pharmacy_data f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year_month
ORDER BY d.year_month;

-- Growth by quarter --

SELECT
    d.year,
    d.quarter,
    SUM(f.revenue_eur) AS revenue,
    SUM(f.margin_eur) AS margin
FROM pharmacy_data f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year, d.quarter
ORDER BY d.year, d.quarter;

-- Promotions over time -- 
-- Note: Promotions cover a small share of total revenue -- 
-- Note: Promotions do not affect seasonality, promotions may not be being leveraged strategically -- 

SELECT
    d.year_month,
    f.promo_flag,
    SUM(f.units_sold) AS units,
    SUM(f.revenue_eur) AS revenue
FROM pharmacy_data f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year_month, f.promo_flag
ORDER BY d.year_month, f.promo_flag;




