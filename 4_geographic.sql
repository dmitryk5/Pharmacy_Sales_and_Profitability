-- Pharmacy Performance Exploration --
-- Q1. Are all pharmacies performing similarly? --
-- Q2. Do a small number of pharmacies drive most revenue? --
-- Q3. Are low-performing pharmacies unprofitable or just low volume? --
-- Q4. Are promotions effective everywhere or only in certain locations? --

-- Revenue and Margin by Pharmacy --
-- Note: Munich HealthPoint #095 has the highest total revenue -- 

SELECT
    ph.pharmacy_id,
    ph.pharmacy_name,
    ph.country,
    ph.region,
    ph.city,
    SUM(p.revenue_eur) AS total_revenue,
    SUM(p.margin_eur) AS total_margin,
    ROUND(SUM(p.margin_eur) / NULLIF(SUM(p.revenue_eur),0) * 100, 2) AS margin_pct
FROM pharmacy_data p
JOIN dim_pharmacy ph
    ON p.pharmacy_id = ph.pharmacy_id
GROUP BY
    ph.pharmacy_id,
    ph.pharmacy_name,
    ph.country,
    ph.region,
    ph.city
ORDER BY total_revenue DESC;

-- Revenue Concentration (Pareto Test) --
-- Note: 80/20 distribution, meaning a small subset of pharmacies drive a disproportionate share of revenue --
-- Note: High dependency on 24 locations? -- 

WITH pharmacy_revenue AS (
    SELECT
        ph.pharmacy_id,
        SUM(p.revenue_eur) AS revenue
    FROM pharmacy_data p
    JOIN dim_pharmacy ph
        ON p.pharmacy_id = ph.pharmacy_id
    GROUP BY ph.pharmacy_id
)
SELECT
    COUNT(*) AS total_pharmacies,
    SUM(CASE WHEN revenue >= (
        SELECT PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY revenue)
        FROM pharmacy_revenue
    ) THEN 1 ELSE 0 END) AS top_20_pct_pharmacies
FROM pharmacy_revenue;

-- Compare top 20% against bottom 80% --
-- Note: Good distribution, no dependencies -- 

WITH pharmacy_revenue AS (
    SELECT
        ph.pharmacy_id,
        SUM(p.revenue_eur) AS revenue
    FROM pharmacy_data p
    JOIN dim_pharmacy ph
        ON p.pharmacy_id = ph.pharmacy_id
    GROUP BY ph.pharmacy_id
),
ranked_pharmacies AS (
    SELECT
        pharmacy_id,
        revenue,
        NTILE(5) OVER (ORDER BY revenue DESC) AS revenue_quintile
    FROM pharmacy_revenue
)
SELECT
    CASE 
        WHEN revenue_quintile = 1 THEN 'Top 20%'
        ELSE 'Bottom 80%'
    END AS pharmacy_group,
    COUNT(*) AS pharmacy_count,
    ROUND(SUM(pr.revenue),2) AS total_revenue
FROM ranked_pharmacies rp
JOIN pharmacy_revenue pr
    ON rp.pharmacy_id = pr.pharmacy_id
GROUP BY pharmacy_group;

-- Compare top and bottom performers on margin and efficiency -- 
-- Note: Top pharmacies are not more profitable — they are simply larger. --

WITH pharmacy_metrics AS (
    SELECT
        ph.pharmacy_id,
        SUM(p.revenue_eur) AS revenue,
        SUM(p.margin_eur) AS margin,
        ROUND(SUM(p.margin_eur) / NULLIF(SUM(p.revenue_eur),0) * 100, 2) AS margin_pct
    FROM pharmacy_data p
    JOIN dim_pharmacy ph
        ON p.pharmacy_id = ph.pharmacy_id
    GROUP BY ph.pharmacy_id
),
ranked AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY revenue DESC) AS revenue_quintile
    FROM pharmacy_metrics
)
SELECT
    CASE WHEN revenue_quintile = 1 THEN 'Top 20%' ELSE 'Bottom 80%' END AS group_name,
    ROUND(AVG(revenue),2) AS avg_revenue,
    ROUND(AVG(margin_pct),2) AS avg_margin_pct
FROM ranked
GROUP BY group_name;



-- Country/Region Comparison -- 
-- Note: Lombardy, Italy has highest revenue and margin -- 

SELECT
    ph.country,
    ph.region,
    SUM(p.revenue_eur) AS revenue,
    SUM(p.margin_eur) AS margin,
    ROUND(SUM(p.margin_eur) / NULLIF(SUM(p.revenue_eur),0) * 100, 2) AS margin_pct
FROM pharmacy_data p
JOIN dim_pharmacy ph
    ON p.pharmacy_id = ph.pharmacy_id
GROUP BY ph.country, ph.region
ORDER BY revenue DESC;

-- Promotion effectiveness by pharmacy -- 

SELECT
    ph.pharmacy_id,
    ph.pharmacy_name,
    p.promo_flag,
    SUM(p.units_sold) AS units,
    SUM(p.revenue_eur) AS revenue,
    ROUND(SUM(p.revenue_eur) / NULLIF(SUM(p.units_sold),0), 2) AS revenue_per_unit
FROM pharmacy_data p
JOIN dim_pharmacy ph
    ON p.pharmacy_id = ph.pharmacy_id
GROUP BY
    ph.pharmacy_id,
    ph.pharmacy_name,
    p.promo_flag;



