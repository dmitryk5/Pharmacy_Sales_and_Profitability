# 💊 Pharmacy Sales, Margin & Promotion Performance Analysis
**SQL + Tableau Analytics Project**

This project analyzes **pharmacy sales performance, profitability, and promotional effectiveness** across products, pharmacies, and time.  
The goal is to identify growth trends, margin drivers, revenue concentration, and whether promotions meaningfully impact performance.

![Dashboard Preview](pharmacy_dashboard.png)

🔗 **Interactive Tableau Dashboard:**  
[https://public.tableau.com/app/profile/dmitry.kuvyrdin](https://public.tableau.com/app/profile/dmitry.kuvyrdin/viz/PharmacySalesandProfitability/DBMain)

---

## 📌 Project Overview

This analysis evaluates **two years of pharmacy transaction data (2024–2025)** to understand how revenue, margin, and units sold evolve over time and across different business dimensions.

The project mirrors a **real-world analytics workflow**, moving from executive KPIs to deeper diagnostic analysis that supports pricing, promotion, and operational decisions.

### Core Objectives
- Track revenue and margin growth over time
- Identify seasonality patterns
- Compare branded vs. generic performance
- Analyze pharmacy-level scale vs. efficiency
- Evaluate promotion effectiveness

---

## 🗂 Dataset Description

The dataset consists of transactional pharmacy sales joined to product, pharmacy, and date dimensions.

### Fact Table
- `pharmacy_data`
  - Units sold
  - Revenue (€)
  - Margin (€)
  - Promotion flag
  - Transaction date
  - Product ID
  - Pharmacy ID

### Dimension Tables
- `dim_date` – calendar attributes (year, month, month name)
- `dim_product` – product name, category, branded vs. generic
- `dim_pharmacy` – pharmacy name and geographic attributes

### Dataset Scope
- Date range: **January 2024 – December 2025**
- ~120 pharmacies
- ~220 products
- Promo and non-promo transactions

---

## ❓ Business Questions Answered

### Time-Based Analysis
- How do revenue, margin, and units trend over time?
- Is there seasonality in pharmacy sales?
- What is the month-over-month (MoM) growth pattern?

### Product Performance
- Which products and categories drive revenue?
- Is revenue concentrated in a small number of products?
- How do branded and generic products differ in scale and efficiency?

### Pharmacy Performance
- Which pharmacies generate the most revenue?
- Are top pharmacies more profitable or simply larger?
- How evenly is performance distributed across locations?

### Promotion Effectiveness
- What share of revenue comes from promotions?
- Do promotions meaningfully increase unit volume?
- What is the margin tradeoff of discounting?

---

## 🧠 SQL Techniques Used

- Common Table Expressions (CTEs)
- Window functions (`LAG`, `NTILE`)
- Conditional aggregation
- Time-based calculations
- Multi-table joins
- Promo vs non-promo segmentation

---

## 📊 Tableau Dashboard Structure

The Tableau dashboard translates SQL outputs into **interactive, executive-ready visuals**.

### Page 1: Executive Overview & Trends
- KPI Cards:
  - Total Revenue
  - Margin
  - Margin %
  - Units Sold
  - Promo Revenue Share
  - MoM Growth %
- Monthly Revenue & Margin trend (dual axis)
- Seasonality heatmap (Month × Year)

### Page 2: Product Performance
- Top products by revenue
- Category-level revenue and margin
- Revenue concentration (Pareto-style analysis)
- Branded vs. generic comparison

### Page 3: Pharmacy Performance
- Revenue and margin by pharmacy
- Top vs. bottom pharmacy comparison
- Scale vs. efficiency analysis
- Geographic performance map

### Page 4: Promotion Analysis
- Promo vs non-promo revenue share
- Margin impact of promotions
- Category and pharmacy promo dependency

---

## 🔍 Key Insights

### Time Trends
- Revenue and margin grow steadily across the two-year period
- Clear seasonality with peaks between **May and October**
- Strongest MoM growth typically occurs in late spring and summer

### Product Insights
- Revenue is not overly concentrated in a small number of products
- Wellness and personal care categories have the strongest margins
- Branded products drive revenue primarily through **scale**, not higher margins

### Pharmacy Insights
- A small group of pharmacies generates a disproportionate share of revenue
- Margin % is relatively consistent across pharmacies
- Performance differences are driven more by **volume than efficiency**

### Promotion Insights
- Promotions account for a limited share of total revenue
- Promotional sales consistently reduce margin %
- Discounting rarely produces meaningful volume uplift

---

## 📈 Recommendations & Next Steps

### Business Recommendations
- Reevaluate broad discounting strategies
- Focus promotions on targeted products or locations
- Prioritize high-margin categories for growth

### Future Analysis
- Customer-level basket analysis
- Price elasticity modeling
- Forecasting revenue and margin trends

---

## 👤 Author

**Dmitry Kuvyrdin**  
🔗 LinkedIn: https://www.linkedin.com/in/dmitry-kuvyrdin/
