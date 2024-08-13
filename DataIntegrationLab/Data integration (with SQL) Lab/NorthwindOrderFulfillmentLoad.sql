-- Load bảng Products
GO
INSERT INTO [NorthwindOrdersDW].[dbo].[DimProducts] (
    [SupplierName],
    [ProductID],
    [ProductName],
    [CategoryName],
    [QuantityPerUnit],
    [UnitPrice],
    [UnitsInStock],
    [UnitsOnOrder],
    [ReorderLevel],
    [Discontinued]
)
SELECT
    [CompanyName],
    [ProductID],
    [ProductName],
    [CategoryName],
    [QuantityPerUnit],
    [UnitPrice],
    [UnitsInStock],
    [UnitsOnOrder],
    [ReorderLevel],
    [Discontinued]
FROM NorthwindOrdersDWStage.dbo.NorthwindStageProducts;
-- Load bảng Employees
go
INSERT INTO [NorthwindOrdersDW].[dbo].[DimEmployees] (
    [EmployeeID],
    [LastName],
    [FirstName],
    [Title],
    [City],
    [Region],
    [Country]
)
SELECT
    [EmployeeID],
    [LastName],
    [FirstName],
    [Title],
    [City],
    [Region],
    [Country]
FROM [NorthwindOrdersDWStage].[dbo].[NorthwindStageEmployees]

go
INSERT INTO [NorthwindOrdersDW].[dbo].[DimShippers] (
    [ShipperID],
    [CompanyName],
    [Phone]
)
SELECT
    [ShipperID],
    [CompanyName],
    [Phone]
FROM [NorthwindOrdersDWStage].[dbo].[NorthwindStageShippers]
go
-- Load bảng DimDate
insert into NorthwindOrdersDW.dbo.dimDate(DateKey, Date, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)
select date_key, full_date, day_of_week, day_name, day_num_in_month, day_num_overall, week_num_in_year, month_name, month, quarter,
		case 
			when quarter >= 1 and quarter <= 3 then 'First'
			when quarter >= 4 and quarter <= 6 then 'Second'
			when quarter >= 7 and quarter <= 9 then 'Third'
			when quarter >= 10 and quarter <= 12 then 'Fourth' end,	
		year, weekday_flag
from NorthwindOrdersDWStage.dbo.NorthwindStageDate

go
-- Load bảng Fact Order
-- Chèn dữ liệu từ bảng NorthwindStageFactOrders vào bảng DimFactOrder
/*INSERT INTO [NorthwindOrdersDW].[dbo].[FactOrder] (
    ShipperKey,
    EmployeeKey,
    ShippedDateKey,
    OrderDateKey,
    ProductKey,
    OrderID,
    OrderCount,
    Quantity,
    Freight
)
SELECT
    ShipperKey,
    EmployeeKey,
    ShippedDateKey,
    OrderDateKey,
    ProductKey,
    OrderID,
    OrderCount,
    Quantity,
    Freight
FROM [NorthwindOrdersDWStage].[dbo].[NorthwindStageFactOrders]
*/

