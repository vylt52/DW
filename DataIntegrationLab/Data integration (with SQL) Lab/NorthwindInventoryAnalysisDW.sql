USE NorthwindInventoryDW
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
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  smallint   NOT NULL
,  [IsWeekDay]  varchar(20)  DEFAULT 'N' NOT NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
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

CREATE TABLE dbo.FactInventory (
   [ProductKey]  int   NOT NULL
,  [SupplierKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [OrderID]  int   NOT NULL
,  [CategoryName]  nvarchar(15)   NOT NULL
,  [UnitsOnOrder]  smallint   NOT NULL
,  [UnitsInStock]  smallint   NOT NULL
,  [InsertAuditKey]  int  DEFAULT -1 NOT NULL
,  [UpdateAuditKey]  int  DEFAULT -1 NOT NULL
,  [BKFactTable]  int   NULL
, CONSTRAINT [PK_dbo.FactInventory] PRIMARY KEY NONCLUSTERED ([ProductKey], [OrderID] )
, CONSTRAINT FK_dbo_FactInventory_ProductKey FOREIGN KEY (ProductKey) REFERENCES DimProducts (ProductKey)
, CONSTRAINT FK_dbo_FactInventory_SupplierKey FOREIGN KEY (SupplierKey) REFERENCES DimSuppliers (SupplierKey)
, CONSTRAINT FK_dbo_FactInventory_OrderDateKey FOREIGN KEY (OrderDateKey) REFERENCES DimDate (DateKey)
) ON [PRIMARY]
;


DROP TABLE dbo.FactInventory
DROP TABLE dbo.DimProducts
DROP TABLE dbo.DimSuppliers
DROP TABLE dbo.DimDate


