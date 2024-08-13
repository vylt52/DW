CREATE DATABASE NorthwindSalesDWStage
use NorthwindSalesDWStage
go


----- Staging bảng Customers -----
Select CustomerID, CompanyName, ContactName, ContactTitle, City, Region, Country, PostalCode
into [dbo].[NorthwindStageCustomers]
from [NORTHWND].[dbo].[Customers]

----- Staging bảng Employees -----
Select EmployeeID, LastName, FirstName, Title, City, Region, Country
into [dbo].[NorthwindStageEmployees]
from [NORTHWND].[dbo].[Employees]

----- Staging bảng Products -----
Select ProductID, ProductName, CategoryName, CompanyName,  QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
into [dbo].[NorthwindStageProducts]
from [NORTHWND].[dbo].[Products] p
	join [NORTHWND].[dbo].[Suppliers] s on p.[SupplierID] = s.[SupplierID] 
	join [NORTHWND].[dbo].[Categories] c on p.[CategoryID] = c.[CategoryID]

----- Staging bảng Date -----
/*Phải sử dụng thêm excel của Date + tạo Database Temp*/
select min(OrderDate) As StartOrderDate
, max(OrderDate) As EndOrderDate
, min(ShippedDate) As StartShippedDate
, min(ShippedDate) As EndShippedDate
from [NORTHWND].[dbo].[Orders]

/*Bắt đầu từ 1996-07-04 => vào file excel chỉnh => insert dữ liệu vào database Temp*/
Select *
into [dbo].[NorthwindStageDate]
from [ExternalSources].[dbo].[DateStage]
where year between 1996 and 1998

-----Staging bảng Supplier -----
select SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, Country, Phone
into [dbo].[NorthwindStageSuppliers]
from [NORTHWND].[dbo].[Suppliers]


----- Staging fact table -----
select CustomerID, EmployeeID,  SupplierID, s.ProductID, od.OrderID, OrderDate, ShippedDate, od.UnitPrice, Quantity, Discount
into [dbo].[NorthwindStageSales]
from [NORTHWND].[dbo].[Order Details] od 
										join [NORTHWND].[dbo].[Products] s on od.ProductID = s.ProductID
										join [NORTHWND].[dbo].[Orders] o on od.OrderID = o.OrderID

