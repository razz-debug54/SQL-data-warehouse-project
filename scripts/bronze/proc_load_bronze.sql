/*
====================================================================================================
WARNING: DESTRUCTIVE SCRIPT - DATA TRUNCATION HAZARD
====================================================================================================
This stored procedure (`bronze.load_bronze`) is used to refresh the Bronze Layer of the Data Warehouse.
- It explicitly executes `TRUNCATE TABLE` on all target tables before performing a `BULK INSERT`.
- Running this stored procedure will PERMANENTLY DELETE all existing data in these tables and 
  replace it with data from the specified local file paths.
- PREREQUISITE: The file paths specified (`C:\Datasets\...`, etc.) must exist locally on the machine 
  where the SQL Server service is running, and the SQL Server service account must have read permissions.
====================================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN 
    BEGIN TRY     

        PRINT '============================================'
        PRINT 'Loading bronze layer'
        PRINT '============================================'

        PRINT '--------------------------------------------------------------'
        PRINT 'Source System CRM'
        PRINT '============================================'

        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Truncating Table : bronze.crm_cust_info '
        PRINT '>> Inserting Data into Table : bronze.crm_cust_info '

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Datasets\cust_info.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n', 
            TABLOCK
        );


        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '--------------------------------------------------------------'
        PRINT '>> Truncating Table : bronze.crm_prd_info'
        PRINT '>> Inserting Data into Table : bronze.crm_prd_info'

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Datasets\prd_info.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n', 
            TABLOCK
        );

        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '--------------------------------------------------------------'
        PRINT '>> Truncating Table : bronze.crm_sales_details'
        PRINT '>> Inserting Data into Table : bronze.crm_sales_details'

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Datasets\sales_details.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n', 
            TABLOCK
        );

        PRINT '============================================'
        PRINT 'Source System ERP'
        PRINT '============================================'

        TRUNCATE TABLE bronze.erp_LOC_A101;
        PRINT '--------------------------------------------------------------'
        PRINT '>> Truncating Table : bronze.erp_LOC_A101'
        PRINT '>> Inserting Data into Table : bronze.erp_LOC_A101'

        BULK INSERT bronze.erp_LOC_A101
        FROM 'C:\Razz Folder\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n', 
            TABLOCK
        );

        TRUNCATE TABLE bronze.erp_CUST_AZ12;
        PRINT '--------------------------------------------------------------'
        PRINT '>> Truncating Table : bronze.erp_CUST_AZ12'
        PRINT '>> Inserting Data into Table : bronze.erp_CUST_AZ12'

        BULK INSERT bronze.erp_CUST_AZ12
        FROM 'C:\Razz Folder\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n', 
            TABLOCK
        );

        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
        PRINT '--------------------------------------------------------------'
        PRINT '>> Truncating Table : bronze.erp_PX_CAT_G1V2'
        PRINT '>> Inserting Data into Table : bronze.erp_PX_CAT_G1V2'

        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM 'C:\Razz Folder\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n', 
            TABLOCK
        );
    
    END TRY
    
    BEGIN CATCH 
    
        PRINT '========================================================'
        PRINT 'An Error Occurred '
        PRINT 'Error Message: ' + CAST(ERROR_MESSAGE() AS NVARCHAR(MAX))
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR(MAX))
        PRINT '========================================================'
    
    END CATCH;
END;
