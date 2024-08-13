USE NorthwindInventoryDWStage
GO

----- Staging bảng Products -----
Select ProductID, ProductName, CategoryName, CompanyName,  QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
into [dbo].[NorthwindStageProducts]
from [NORTHWND].[dbo].[Products] p
	join [NORTHWND].[dbo].[Suppliers] s on p.[SupplierID] = s.[SupplierID] 
	join [NORTHWND].[dbo].[Categories] c on p.[CategoryID] = c.[CategoryID]

Select *
into [dbo].[NorthwindStageDate]
from [Temp].[dbo].[DimDate]
where year between 1996 and 1998


----- Staging bảng Supplier -----
select SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, Country, Phone
into [dbo].[NorthwindStageSuppliers]
from [NORTHWND].[dbo].[Suppliers]

----- Staging bảng FactInventory -----
select p.ProductID, p.SupplierID, OrderDate, o.OrderID ,CategoryName, UnitsOnOrder, UnitsInStock
into [dbo].[NorthwindStageInventory]
from [NORTHWND].[dbo].[Products] p 
join ([NORTHWND].[dbo].[Order Details] od join [NORTHWND].[dbo].[Orders] o on od.OrderID = o.OrderID) on p.ProductID = od.ProductID
	join [NORTHWND].[dbo].[Categories] c on p.CategoryID = c.CategoryID
	join [NORTHWND].[dbo].[Suppliers] s on p.SupplierID = s.SupplierID
	
