/*
=============================================================
Create Database and Schemas
=============================================================

Script Purpose:
    This script creates a new database named 'DataWarehouse' after
    checking if it already exists.

    If the database exists, it is dropped and recreated.

    Additionally, this script creates three schemas within the
    database:

        1. bronze - Raw/source data
        2. silver - Cleaned and transformed data
        3. gold   - Business-ready analytical data

Architecture:
    Source Systems
          |
          v
       BRONZE
    Raw Data Layer
          |
          v
       SILVER
   Cleaned Data Layer
          |
          v
        GOLD
 Business / Analytics Layer

WARNING:
    Running this script will drop the entire 'DataWarehouse'
    database if it exists.

    All data in the database will be permanently deleted.

    Proceed with caution and ensure you have proper backups
    before running this script.

=============================================================
*/


-- ============================================================
-- Switch to the master database
-- ============================================================

USE master;
GO


-- ============================================================
-- Drop and recreate the 'DataWarehouse' database
-- ============================================================

IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN

    -- Force all existing users/connections out of the database
    ALTER DATABASE DataWarehouse
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    -- Permanently delete the existing database
    DROP DATABASE DataWarehouse;

END;
GO


-- ============================================================
-- Create the 'DataWarehouse' database
-- ============================================================

CREATE DATABASE DataWarehouse;
GO


-- ============================================================
-- Switch to the newly created database
-- ============================================================

USE DataWarehouse;
GO


-- ============================================================
-- Create the Bronze schema
-- ============================================================

CREATE SCHEMA bronze;
GO


-- ============================================================
-- Create the Silver schema
-- ============================================================

CREATE SCHEMA silver;
GO


-- ============================================================
-- Create the Gold schema
-- ============================================================

CREATE SCHEMA gold;
GO
