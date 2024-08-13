
USE NorthwindOrdersDWStage
----- Staging bảng Products -----
GO
SELECT s.[CompanyName] as [CompanyName],
    [ProductID],
    [ProductName],
    [CategoryName],
    [QuantityPerUnit],
    [UnitPrice],
    [UnitsInStock],
    [UnitsOnOrder],
    [ReorderLevel],
    [Discontinued]
into [NorthwindOrdersDWStage].[dbo].[NorthwindStageProducts]
from [NORTHWND].[dbo].[Products] p
	join [NORTHWND].[dbo].[Suppliers] s
		on p.[SupplierID] = s.[SupplierID]
	join [NORTHWND].[dbo].[Categories] c
		on c.[CategoryID] = p.[CategoryID]
----- Staging bảng Employees -----
go
SELECT
    [EmployeeID],
    [LastName],
    [FirstName],
    [Title],
    [City],
    [Region],
    [Country]
INTO [NorthwindOrdersDWStage].[dbo].[NorthwindStageEmployees] 
FROM [NORTHWND].[dbo].[Employees]
go
----- Staging bảng Customers -----
--go
--SELECT
--    [CustomerID],
--    [CompanyName],
--    [ContactName],
--    [ContactTitle],
--    [City],
--    [Region],
--    [Country],
--    [PostalCode]
--INTO [NorthwindOrdersDWStage].[dbo].[NorthwindStageCustomers] 
--FROM [NORTHWND].[dbo].[Customers]
--go
----- Staging shippers -----
go
SELECT
    [ShipperID],
    [CompanyName],
    [Phone]
INTO [NorthwindOrdersDWStage].[dbo].[NorthwindStageShippers]
FROM [NORTHWND].[dbo].[Shippers]
go
----- Staging bảng Date -----
select min(OrderDate) As StartOrderDate
	, max(OrderDate) As EndOrderDate
	, min(ShippedDate) As StartShippedDate
	, min(ShippedDate) As EndShippedDate
from [NORTHWND].[dbo].[Orders]

select *
into [NorthwindOrdersDWStage].[dbo].[NorthwindStageDate]
from [Temp].[dbo].[DimDate]
where year between 1996 and 1998

----- Staging fact table -----
go
SELECT
    s.ShipperID AS ShipperKey,
    e.EmployeeID AS EmployeeKey,
    ds.date_key AS ShippedDateKey,
    do.date_key AS OrderDateKey,
    p.ProductID AS ProductKey,
    o.OrderID AS OrderID,
    DATEDIFF(day, do.full_date, ds.full_date) AS OrderCount, -- Calculate OrderCount as the difference in days
    od.Quantity AS Quantity,
    o.Freight AS Freight
INTO [NorthwindOrdersDWStage].[dbo].[NorthwindStageFactOrders]
FROM [NORTHWND].dbo.Orders o
JOIN [NORTHWND].dbo.Employees e ON o.EmployeeID = e.EmployeeID
JOIN [NORTHWND].dbo.Shippers s ON o.ShipVia = s.ShipperID
JOIN [NORTHWND].dbo.[Order Details] od ON o.OrderID = od.OrderID
JOIN [NORTHWND].dbo.Products p ON od.ProductID = p.ProductID
JOIN [Temp].dbo.DimDate ds ON CONVERT(date, o.ShippedDate) = ds.full_date
JOIN [Temp].dbo.DimDate do ON CONVERT(date, o.OrderDate) = do.full_date
GROUP BY
    s.ShipperID,
    e.EmployeeID,
    ds.full_date, 
	ds.date_key,
    do.full_date,
	do.date_key,
    p.ProductID,
    o.OrderID,
    od.Quantity,
    o.Freight;
go

----------------------------------------------------------------------------------
----- Load bảng Products -----
go
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
----- Load bảng Employees -----
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
----- Load bảng Customers -----
--go
--INSERT INTO [NorthwindOrdersDW].[dbo].[DimCustomers] (
--    [CustomerID],
--    [CompanyName],
--    [ContactName],
--    [ContactTitle],
--    [CustomerCity],
--    [CustomerRegion],
--    [CustomerCountry],
--    [CustomerPostalCode]
--)
--SELECT
--    [CustomerID],
--    [CompanyName],
--    [ContactName],
--    [ContactTitle],  -- Sửa thành [ContactTitle] để phù hợp với tên cột trong bảng NorthwindStageCustomers
--    [City],
--    ISNULL([Region], 'N/A') AS [CustomerRegion],  -- Sử dụng ISNULL để đặt giá trị mặc định là 'N/A' cho [CustomerRegion] nếu [Region] là NULL
--    [Country],
--    'N/A' AS [PostalCode]
--FROM [NorthwindOrdersDWStage].[dbo].[NorthwindStageCustomers]
--go
----- Load bảng Shippers -----
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
----- Load bảng DimDate -----
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
INSERT INTO [NorthwindOrdersDW].[dbo].[FactOrder] (
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

----- Customer không có ID sẵn nên lỗi -----
--INSERT INTO [NorthwindOrdersDW].[dbo].[FactOrder] (
--    ShipperKey,
--    CustomerKey,
--    EmployeeKey,
--    ShippedDateKey,
--    OrderDateKey,
--    ProductKey,
--    OrderID,
--    OrderCount,
--    Quantity,
--    Freight
--)
--SELECT
--    ShipperKey,
--    CustomerKey,
--    EmployeeKey,
--    CONVERT(smalldatetime, ShippedDateKey) AS ShippedDateKey,
--    CONVERT(smalldatetime, OrderDateKey) AS OrderDateKey,
--    ProductKey,
--    OrderID,
--    OrderCount,
--    Quantity,
--    Freight
--FROM [NorthwindOrdersDWStage].[dbo].[NorthwindStageFactOrders];


