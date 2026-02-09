-- Changing all columns to snakecase (snake_case), quickly done with AI (ChatGPT) -- 

-- Alter pharmacy_data --

ALTER TABLE pharmacy_data RENAME COLUMN "SalesID" TO sales_id;
ALTER TABLE pharmacy_data RENAME COLUMN "DateKey" TO date_key;
ALTER TABLE pharmacy_data RENAME COLUMN "PharmacyID" TO pharmacy_id;
ALTER TABLE pharmacy_data RENAME COLUMN "ProductID" TO product_id;
ALTER TABLE pharmacy_data RENAME COLUMN "UnitsSold" TO units_sold;
ALTER TABLE pharmacy_data RENAME COLUMN "RevenueEUR" TO revenue_eur;
ALTER TABLE pharmacy_data RENAME COLUMN "CostEUR" TO cost_eur;
ALTER TABLE pharmacy_data RENAME COLUMN "MarginEUR" TO margin_eur;
ALTER TABLE pharmacy_data RENAME COLUMN "PromoFlag" TO promo_flag;

-- Alter dim_date -- 

ALTER TABLE dim_date RENAME COLUMN "DateKey" TO date_key;
ALTER TABLE dim_date RENAME COLUMN "Date" TO date;
ALTER TABLE dim_date RENAME COLUMN "Year" TO year;
ALTER TABLE dim_date RENAME COLUMN "Quarter" TO quarter;
ALTER TABLE dim_date RENAME COLUMN "MonthNumber" TO month_number;
ALTER TABLE dim_date RENAME COLUMN "MonthName" TO month_name;
ALTER TABLE dim_date RENAME COLUMN "YearMonth" TO year_month;

-- Drop non dim_date columns (error in import) --

ALTER TABLE dim_date
DROP COLUMN "pharmacyid",
DROP COLUMN "pharmacyname",
DROP COLUMN "country",
DROP COLUMN "region",
DROP COLUMN "city",
DROP COLUMN "pharmacytype",
DROP COLUMN "opendate",
DROP COLUMN "storesizeband",
DROP COLUMN "latitude",
DROP COLUMN "longitude",
DROP COLUMN "productid",
DROP COLUMN "productname",
DROP COLUMN "category",
DROP COLUMN "brand",
DROP COLUMN "isgeneric",
DROP COLUMN "packsize",
DROP COLUMN "listpriceeur",
DROP COLUMN "standardcosteur",
DROP COLUMN "launchdate",
DROP COLUMN "isdiscontinued",
DROP COLUMN "discontinueddate";

-- Alter dim_pharmacy --

ALTER TABLE dim_pharmacy RENAME COLUMN "PharmacyID" TO pharmacy_id;
ALTER TABLE dim_pharmacy RENAME COLUMN "PharmacyName" TO pharmacy_name;
ALTER TABLE dim_pharmacy RENAME COLUMN "Country" TO country;
ALTER TABLE dim_pharmacy RENAME COLUMN "Region" TO region;
ALTER TABLE dim_pharmacy RENAME COLUMN "City" TO city;
ALTER TABLE dim_pharmacy RENAME COLUMN "PharmacyType" TO pharmacy_type;
ALTER TABLE dim_pharmacy RENAME COLUMN "OpenDate" TO open_date;
ALTER TABLE dim_pharmacy RENAME COLUMN "StoreSizeBand" TO store_size_band;
ALTER TABLE dim_pharmacy RENAME COLUMN "Latitude" TO latitude;
ALTER TABLE dim_pharmacy RENAME COLUMN "Longitude" TO longitude;

-- Alter dim_product -- 

ALTER TABLE dim_product RENAME COLUMN "ProductID" TO product_id;
ALTER TABLE dim_product RENAME COLUMN "ProductName" TO product_name;
ALTER TABLE dim_product RENAME COLUMN "Category" TO category;
ALTER TABLE dim_product RENAME COLUMN "Brand" TO brand;
ALTER TABLE dim_product RENAME COLUMN "IsGeneric" TO is_generic;
ALTER TABLE dim_product RENAME COLUMN "PackSize" TO pack_size;
ALTER TABLE dim_product RENAME COLUMN "ListPriceEUR" TO list_price_eur;
ALTER TABLE dim_product RENAME COLUMN "StandardCostEUR" TO standard_cost_eur;
ALTER TABLE dim_product RENAME COLUMN "LaunchDate" TO launch_date;
ALTER TABLE dim_product RENAME COLUMN "IsDiscontinued" TO is_discontinued;
ALTER TABLE dim_product RENAME COLUMN "DiscontinuedDate" TO discontinued_date;

-- Fix schema of units_sold, revenue_eur, margin_eur -- 

-- Revenue --
ALTER TABLE pharmacy_data
ALTER COLUMN revenue_eur TYPE NUMERIC
USING REGEXP_REPLACE(revenue_eur, '[^0-9.]', '', 'g')::NUMERIC;

-- Cost -- 
ALTER TABLE pharmacy_data
ALTER COLUMN cost_eur TYPE NUMERIC
USING REGEXP_REPLACE(cost_eur, '[^0-9.]', '', 'g')::NUMERIC;

-- Margin --
ALTER TABLE pharmacy_data
ALTER COLUMN margin_eur TYPE NUMERIC
USING REGEXP_REPLACE(margin_eur, '[^0-9.]', '', 'g')::NUMERIC;

-- Units sold --
ALTER TABLE pharmacy_data
ALTER COLUMN units_sold TYPE INT
USING units_sold::INT;

-- Promo Flag --
ALTER TABLE pharmacy_data
ALTER COLUMN promo_flag TYPE BOOLEAN
USING promo_flag = 'Yes';

-- Verify data -- 
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'pharmacy_data';










