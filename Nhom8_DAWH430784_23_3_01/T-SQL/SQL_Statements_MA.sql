-- CREATE DATABASE
CREATE DATABASE DataLake_MarketingAnalytics;
CREATE DATABASE DataWarehouse_MarketingAnalytics;

-- OPERATIONS ON Datalake_MarketingAnalytics
USE Datalake_MarketingAnalytics;

SELECT * FROM dbo.Original_Data;
SELECT * FROM dbo.Clean_Data;
SELECT * FROM dbo.Null_Data;

-- OPERATIONS ON DataWarehouse_MarketingAnalytics
USE DataWarehouse_MarketingAnalytics;

SELECT * FROM dbo.Fact_MarketingAnalytic;
SELECT * FROM dbo.Dim_Customer;
SELECT * FROM dbo.Dim_Date;

DELETE FROM dbo.Fact_MarketingAnalytic;
DELETE FROM dbo.Dim_Customer;
DELETE FROM dbo.Dim_Date;