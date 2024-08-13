CREATE DATABASE NorthwindSalesDW

USE NorthwindSalesDW
GO

CREATE TABLE dbo.DimAudit (
   [AuditKey]  int IDENTITY  NOT NULL
,  [ParentAuditKey]  int   NOT NULL
,  [TableName]  nvarchar(50)  DEFAULT 'Unknown' NOT NULL
,  [PkgName]  nvarchar(50)  DEFAULT 'Unknown' NOT NULL
,  [PkgGUID]  uniqueidentifier   NULL
,  [PkgVersionGUID]  uniqueidentifier   NULL
,  [PkgVersionMajor]  smallint   NULL
,  [PkgVersionMinor]  smallint   NULL
,  [ExecStartDT]  datetime  DEFAULT getdate() NOT NULL
,  [ExecStopDT]  datetime   NULL
,  [ExecutionInstanceGUID]  uniqueidentifier   NULL
,  [ExtractRowCnt]  bigint   NULL
,  [InsertRowCnt]  bigint   NULL
,  [UpdateRowCnt]  bigint   NULL
,  [ErrorRowCnt]  bigint   NULL
,  [TableInitialRowCnt]  bigint   NULL
,  [TableFinalRowCnt]  bigint   NULL
,  [TableMaxSurrogateKey]  bigint   NULL
,  [SuccessfulProcessingInd]  nchar(1)  DEFAULT 'N' NOT NULL
, CONSTRAINT [PK_dbo.DimAudit] PRIMARY KEY CLUSTERED 
( [AuditKey] )
) ON [PRIMARY]
;

CREATE TABLE dbo.DimCustomers (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  nvarchar(5)   NOT NULL
,  [CompanyName]  nvarchar(40)   NOT NULL
,  [ContactName]  nvarchar(30)   NOT NULL
,  [ContactTitle]  nvarchar(30)   NOT NULL
,  [CustomerCity]  nvarchar(15)   NOT NULL
,  [CustomerRegion]  nvarchar(15)  DEFAULT 'N/A' NOT NULL
,  [CustomerCountry]  nvarchar(15)   NOT NULL
,  [CustomerPostalCode]  nvarchar(10)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  date  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  date  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int  DEFAULT -1 NOT NULL
,  [UpdateAuditKey]  int  DEFAULT -1 NOT NULL
, CONSTRAINT [PK_dbo.DimCustomers] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;



CREATE TABLE dbo.DimEmployees (
   [EmployeeKey]  int IDENTITY  NOT NULL
,  [EmployeeID]  int   NOT NULL
,  [LastName]  nvarchar(20)   NOT NULL
,  [FirstName]  nvarchar(10)   NOT NULL
,  [Title]  nvarchar(30)   NULL
,  [City]  nvarchar(15)   NULL
,  [Region]  nvarchar(15)   NULL
,  [Country]  nvarchar(15)   NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  date  DEFAULT '12/30/9999' NOT NULL
,  [RowEndDate]  date  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int  DEFAULT -1 NOT NULL
,  [UpdateAuditKey]  int  DEFAULT -1 NOT NULL
, CONSTRAINT [PK_dbo.DimEmployees] PRIMARY KEY CLUSTERED 
( [EmployeeKey] )
) ON [PRIMARY]
;

CREATE TABLE dbo.DimProducts (
   [ProductKey]  int IDENTITY  NOT NULL
,  [SupplierName]  nvarchar(40)   NOT NULL
,  [ProductID]  int   NOT NULL
,  [ProductName]  nvarchar(40)   NOT NULL
,  [CategoryName]  nvarchar(15)   NOT NULL
,  [QuantityPerUnit]  nvarchar(20)   NULL
,  [UnitPrice]  money   NULL
,  [UnitsInStock]  smallint   NULL
,  [UnitsOnOrder]  smallint   NULL
,  [ReorderLevel]  smallint   NULL
,  [Discontinued]  nchar(1)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  date  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  date  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int  DEFAULT -1 NOT NULL
,  [UpdateAuditKey]  int  DEFAULT -1 NOT NULL
, CONSTRAINT [PK_dbo.DimProducts] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;



CREATE TABLE dbo.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  datetime   NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  smallint   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [Year]  smallint   NOT NULL
,  [IsWeekDay]  nvarchar(50)  DEFAULT 'N' NOT NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;



CREATE TABLE dbo.DimSuppliers (
   [SupplierKey]  int IDENTITY  NOT NULL
,  [SupplierID]  int   NOT NULL
,  [CompanyName]  nvarchar(40)   NOT NULL
,  [ContactName]  nvarchar(30)   NULL
,  [ContactTitle]  nvarchar(30)   NULL
,  [Address]  nvarchar(60)   NULL
,  [City]  nvarchar(15)   NULL
,  [Region]  nvarchar(15)   NULL
,  [Country]  nvarchar(15)   NULL
,  [Phone]  nvarchar(20)   NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  date  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  date  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int  DEFAULT -1 NOT NULL
,  [UpdateAuditKey]  int  DEFAULT -1 NOT NULL
, CONSTRAINT [PK_dbo.DimSuppliers] PRIMARY KEY CLUSTERED 
( [SupplierKey] )
) ON [PRIMARY]
;

CREATE TABLE dbo.FactSaleReporting (
   [CustomerKey]  int   NOT NULL
,  [EmployeeKey]  int   NOT NULL
,  [SupplierKey]  int   NOT NULL
,  [ProductKey]  int   NOT NULL
,  [OrderID]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [ShippedDateKey]  int   NOT NULL
--measures
,  [Quantity]  smallint   NULL
,  [ExtendedPriceAmount]  decimal(25,4)   NOT NULL
,  [DiscountAmount]  decimal(25,4)  DEFAULT 0 NOT NULL
,  [SoldAmount]  decimal(25,4)   NOT NULL
-- meta data
,  [InsertAuditKey]  int DEFAULT -1  NOT NULL
,  [UpdateAuditKey]  int DEFAULT -1  NOT NULL
,  [BKFactTable]  int   NULL
-- constraints
, CONSTRAINT [PK_dbo.FactSaleReporting] PRIMARY KEY CLUSTERED ( [ProductKey], [OrderID] )
, CONSTRAINT FK_dbo_FactSaleReporting_CustomerKey FOREIGN KEY (CustomerKey) REFERENCES DimCustomers(CustomerKey)
, CONSTRAINT FK_dbo_FactSaleReporting_EmployeeKey FOREIGN KEY (EmployeeKey) REFERENCES DimEmployees(EmployeeKey)
, CONSTRAINT FK_dbo_FactSaleReporting_ProductKey FOREIGN KEY (ProductKey) REFERENCES DimProducts(ProductKey)
, CONSTRAINT FK_dbo_FactSaleReporting_SupplierKey FOREIGN KEY (SupplierKey) REFERENCES DimSuppliers(SupplierKey)
, CONSTRAINT FK_dbo_FactSaleReporting_OrderDateKey FOREIGN KEY (OrderDateKey) REFERENCES DimDate(DateKey)
, CONSTRAINT FK_dbo_FactSaleReporting_ShippedDateKey FOREIGN KEY (ShippedDateKey) REFERENCES DimDate(DateKey)
) ON [PRIMARY]
;



--- DROP BẢNG KHI SAI --
DROP TABLE dbo.DimDate
DROP TABLE dbo.DimSuppliers
DROP TABLE dbo.DimCustomers
DROP TABLE dbo.DimEmployees
DROP TABLE dbo.DimProducts
DROP TABLE dbo.FactSaleReporting