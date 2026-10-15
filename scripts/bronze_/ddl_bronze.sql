/*
====================================================================================================
WARNING: DESTRUCTIVE SCRIPT - DATA LOSS HAZARD
====================================================================================================
This script is designed for initial setup and environment resets (Bronze Layer DDL). 
- It explicitly CHECKS for and DROPS existing tables (`bronze.crm_*` and `bronze.erp_*`).
- Running this script will PERMANENTLY DELETE all existing data in these tables.
- DO NOT run this script on a Production database unless you intend to wipe and recreate 
  the schema from scratch.
====================================================================================================
*/

USE DataWarehouse;
GO

-- =============================================================================
-- Create / Reset CRM Source Tables
-- =============================================================================

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(1),
    cst_gndr VARCHAR(1),
    cst_create_date DATE 
);
GO

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);
GO

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);
GO

-- =============================================================================
-- Create / Reset ERP Source Tables
-- =============================================================================

IF OBJECT_ID('bronze.erp_CUST_AZ12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_CUST_AZ12;
GO

CREATE TABLE bronze.erp_CUST_AZ12 (
    CID NVARCHAR(50),
    BDATE DATE,
    GEN VARCHAR(20)
);
GO

IF OBJECT_ID('bronze.erp_LOC_A101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_LOC_A101;
GO

CREATE TABLE bronze.erp_LOC_A101 (
    CID NVARCHAR(50),
    CNTRY VARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_PX_CAT_G1V2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_PX_CAT_G1V2;
GO

CREATE TABLE bronze.erp_PX_CAT_G1V2 (
    ID NVARCHAR(50),
    CAT VARCHAR(50),
    SUBCAT VARCHAR(50),
    MAINTENANCE VARCHAR(10)
);
GO
