/****** Object:  Database zzz    Script Date: 15/05/2024 3:28:37 CH ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/


CREATE DATABASE zzz
GO

USE zzz

IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;





-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA MDWT
GO






/* Drop table dbo.Fact_Martketing_Analytic */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.Fact_Martketing_Analytic') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.Fact_Martketing_Analytic 
;

/* Create table dbo.Fact_Martketing_Analytic */
CREATE TABLE dbo.Fact_Martketing_Analytic (
   [Date_ID]  int   NOT NULL
,  [User_ID]  int   NOT NULL
,  [NumWebPurchases]  int   NULL
,  [NumCatalog Purchases]  int   NULL
,  [NumStorePurchases]  int   NULL
,  [NumWebVisitMonth]  int   NULL
,  [MntWines]  int   NULL
,  [MntFruits]  int   NULL
,  [MntFishs]  int   NULL
,  [MntSweets]  int   NULL
,  [MntGolds]  int   NULL
,  [Total_Campaigns_Accepted]  int   NULL
,  [Total_Spent]  int   NULL
,  [Response]  int   NULL
,  [Complain]  int   NULL
,  [Recency]  int   NULL
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=Fact_Martketing_Analytic
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Fact_Martketing_Analytic', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=Fact_Martketing_Analytic
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Fact_Martketing_Analytic]'))
DROP VIEW [MDWT].[Fact_Martketing_Analytic]
GO
CREATE VIEW [MDWT].[Fact_Martketing_Analytic] AS 
SELECT [Date_ID] AS [Date_ID]
, [User_ID] AS [User_ID]
, [NumWebPurchases] AS [NumWebPurchases]
, [NumCatalog Purchases] AS [NumCatalog Purchases]
, [NumStorePurchases] AS [NumStorePurchases]
, [NumWebVisitMonth] AS [NumWebVisitMonth]
, [MntWines] AS [MntWines]
, [MntFruits] AS [MntFruits]
, [MntFishs] AS [MntFishs]
, [MntSweets] AS [MntSweets]
, [MntGolds] AS [MntGolds]
, [Total_Campaigns_Accepted] AS [Total_Campaigns_Accepted]
, [Total_Spent] AS [Total_Spent]
, [Response] AS [Response]
, [Complain] AS [Complain]
, [Recency] AS [Recency]
FROM dbo.Fact_Martketing_Analytic
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date_ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'Date_ID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'User_ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'User_ID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'NumWebPurchases', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'NumWebPurchases'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'NumCatalog Purchases', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'NumCatalog Purchases'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'NumStorePurchases', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'NumStorePurchases'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'NumWebVisitMonth', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'NumWebVisitMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MntWines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'MntWines'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MntFruits', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'MntFruits'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MntFishs', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'MntFishs'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MntSweets', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'MntSweets'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MntGolds', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'MntGolds'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Total_Campaigns_Accepted', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'Total_Campaigns_Accepted'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Total_Spent', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'Total_Spent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Response', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'Response'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Complain', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'Complain'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Recency', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'Recency'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'Date_ID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'User_ID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'Date_ID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Fact_Martketing_Analytic', @level2type=N'COLUMN', @level2name=N'User_ID'; 
;





/* Drop table dbo.Dim_Date */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.Dim_Date') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.Dim_Date 
;

/* Create table dbo.Dim_Date */
CREATE TABLE dbo.Dim_Date (
   [Date_ID]  int IDENTITY  NOT NULL
,  [Year_Enroll]  int   NOT NULL
,  [Month_Enroll]  int   NOT NULL
,  [Day_Enroll]  int   NOT NULL
, CONSTRAINT [PK_dbo.Dim_Date] PRIMARY KEY CLUSTERED 
( [Date_ID] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=Dim_Date
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Dim_Date', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=Dim_Date
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=Dim_Date
;

SET IDENTITY_INSERT dbo.Dim_Date ON
;
INSERT INTO dbo.Dim_Date (Date_ID, Year_Enroll, Month_Enroll, Day_Enroll)
VALUES (-1, 1, 1, 1)
;
SET IDENTITY_INSERT dbo.Dim_Date OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Dim_Date]'))
DROP VIEW [MDWT].[Dim_Date]
GO
CREATE VIEW [MDWT].[Dim_Date] AS 
SELECT [Date_ID] AS [Date_ID]
, [Year_Enroll] AS [Year_Enroll]
, [Month_Enroll] AS [Month_Enroll]
, [Day_Enroll] AS [Day_Enroll]
FROM dbo.Dim_Date
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date_ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Date_ID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year_Enroll', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Year_Enroll'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Month_Enroll', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Month_Enroll'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Day_Enroll', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Day_Enroll'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Date_ID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Date_ID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Date_ID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Year_Enroll'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Month_Enroll'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Day_Enroll'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Date_ID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Year_Enroll'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Month_Enroll'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Date', @level2type=N'COLUMN', @level2name=N'Day_Enroll'; 
;





/* Drop table dbo.Dim_Customer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.Dim_Customer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.Dim_Customer 
;

/* Create table dbo.Dim_Customer */
CREATE TABLE dbo.Dim_Customer (
   [User_ID]  int IDENTITY  NOT NULL
,  [Year_Birth]  int   NOT NULL
,  [Education]  varchar(255)   NOT NULL
,  [Marital_Status]  varchar(255)   NOT NULL
,  [Income]  varchar(255)   NOT NULL
,  [Kidhome]  varchar(255)   NOT NULL
,  [Teenhome]  varchar(255)   NOT NULL
,  [Country]  varchar(255)   NOT NULL
, CONSTRAINT [PK_dbo.Dim_Customer] PRIMARY KEY CLUSTERED 
( [User_ID] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=Dim_Customer
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Dim_Customer', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=Dim_Customer
;

SET IDENTITY_INSERT dbo.Dim_Customer ON
;
INSERT INTO dbo.Dim_Customer (User_ID, Year_Birth, Education, Marital_Status, Income, Kidhome, Teenhome, Country)
VALUES (-1, 1, 'x', 'x', 'x', 'x', 'x', 'x')
;
SET IDENTITY_INSERT dbo.Dim_Customer OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Dim_Customer]'))
DROP VIEW [MDWT].[Dim_Customer]
GO
CREATE VIEW [MDWT].[Dim_Customer] AS 
SELECT [User_ID] AS [User_ID]
, [Year_Birth] AS [Year_Birth]
, [Education] AS [Education]
, [Marital_Status] AS [Marital_Status]
, [Income] AS [Income]
, [Kidhome] AS [Kidhome]
, [Teenhome] AS [Teenhome]
, [Country] AS [Country]
FROM dbo.Dim_Customer
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'User_ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'User_ID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year_Birth', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Year_Birth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Education', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Education'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Marital_Status', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Marital_Status'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Income', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Income'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Kidhome', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Kidhome'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Teenhome', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Teenhome'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Country', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'User_ID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'User_ID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'User_ID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Year_Birth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Education'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Marital_Status'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Income'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Kidhome'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Teenhome'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'User_ID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Year_Birth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Education'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Marital_Status'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Income'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Kidhome'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Teenhome'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Dim_Customer', @level2type=N'COLUMN', @level2name=N'Country'; 
;
ALTER TABLE dbo.Fact_Martketing_Analytic ADD CONSTRAINT
   FK_dbo_Fact_Martketing_Analytic_Date_ID FOREIGN KEY
   (
   Date_ID
   ) REFERENCES Dim_date
   ( Date_ID )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.Fact_Martketing_Analytic ADD CONSTRAINT
   FK_dbo_Fact_Martketing_Analytic_User_ID FOREIGN KEY
   (
   User_ID
   ) REFERENCES Dim_Customer
   ( User_ID )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
