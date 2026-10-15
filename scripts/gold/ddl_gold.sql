-- Script: Create Gold Layer Views (Star Schema)
-- Description: Builds dimension and fact views for reporting and analytics.

-- =============================================================================
-- Create Customer Dimension: gold.dim_customers
-- =============================================================================
CREATE OR ALTER VIEW gold.dim_customers AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key, -- Surrogate key
    ci.cst_id                              AS customer_id,  -- Natural key
    ci.cst_key                             AS customer_number,
    ci.cst_firstname                       AS first_name,
    ci.cst_lastname                        AS last_name,
    cl.CNTRY                               AS country,
    ci.cst_marital_status                  AS marital_status,
    ci.cst_gndr                            AS gender,       -- Already cleaned in Silver
    ca.BDATE                               AS birthdate,
    ci.cst_create_date                     AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca
    ON ci.cst_key = ca.CID
LEFT JOIN silver.erp_LOC_A101 cl
    ON ci.cst_key = cl.CID;
GO


-- =============================================================================
-- Create Product Dimension: gold.dim_products
-- =============================================================================
CREATE OR ALTER VIEW gold.dim_products AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY pdi.prd_start_dt, pdi.prd_id) AS product_key, -- Surrogate key
    pdi.prd_id                                                AS product_id,    -- Natural key
    pdi.prd_key                                               AS product_number,
    pdi.prd_nm                                                AS product_name,
    pdi.cat_id                                                AS category_id,
    pc.CAT                                                    AS category,
    pc.SUBCAT                                                 AS sub_category,
    pc.MAINTENANCE                                            AS maintenance,
    pdi.prd_cost                                              AS product_cost,
    pdi.prd_line                                              AS product_line,
    pdi.prd_start_dt                                          AS product_start_date
FROM silver.crm_prd_info pdi
LEFT JOIN silver.erp_PX_CAT_G1V2 pc
    ON pdi.cat_id = pc.ID
WHERE pdi.prd_end_dt IS NULL; -- Get current active products only
GO


-- =============================================================================
-- Create Sales Fact Table: gold.fact_sales
-- =============================================================================
CREATE OR ALTER VIEW gold.fact_sales AS
SELECT 
    sd.sls_ord_num   AS order_number,
    dp.product_key   AS product_key,   -- Foreign key to dim_products
    dc.customer_key  AS customer_key,  -- Foreign key to dim_customers
    sd.sls_order_dt  AS order_date,
    sd.sls_ship_dt   AS shipping_date,
    sd.sls_due_dt    AS due_date,
    sd.sls_sales     AS sales_amount,
    sd.sls_quantity  AS quantity,
    sd.sls_price     AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products dp
    ON sd.sls_prd_key = dp.product_number
LEFT JOIN gold.dim_customers dc
    ON sd.sls_cust_id = dc.customer_id;
GO
