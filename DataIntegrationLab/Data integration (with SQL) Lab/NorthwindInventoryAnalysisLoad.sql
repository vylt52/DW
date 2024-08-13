use NorthwindInventoryDW
go

----- Load bảng dimProduct -----
select * from NorthwindInventoryDW.dbo.DimProducts
select * from NorthwindInventoryDWStage.dbo.NorthwindStageProducts
insert into NorthwindInventoryDW.dbo.DimProducts(SupplierName, ProductID, ProductName, CategoryName, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
select CompanyName, ProductID, ProductName, CategoryName, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel,
		case when Discontinued = 1 then 'Y' else 'N' end
from NorthwindInventoryDWStage.dbo.NorthwindStageProducts

----- Load bảng dimDate -----
select * from NorthwindInventoryDW.dbo.dimDate
select * from NorthwindInventoryDWStage.dbo.NorthwindStageDate
insert into NorthwindInventoryDW.dbo.dimDate(DateKey, Date, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekDay)
select date_key, full_date, day_of_week, day_name, day_num_in_month, day_num_overall, week_num_in_year, month_name, month, quarter,
		case when quarter >= 1 and quarter <= 3 then 'First'
		when quarter >= 4 and quarter <= 6 then 'Second'
		when quarter >= 7 and quarter <= 9 then 'Third'
		when quarter >= 10 and quarter <= 12 then 'Fourth' end,	
		year, weekday_flag
from NorthwindSalesDWStage.dbo.NorthwindStageDate

----- Load bảng dimSuppliers -----
select * from NorthwindInventoryDW.dbo.DimSuppliers
select * from NorthwindInventoryDWStage.dbo.NorthwindStageSuppliers
insert into NorthwindInventoryDW.dbo.DimSuppliers(SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, Country, Phone)
select SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, Country, Phone
from NorthwindInventoryDWStage.dbo.NorthwindStageSuppliers

----- Load bảng FactInventory -----
select * from NorthwindInventoryDW.dbo.FactInventory
select * from NorthwindInventoryDWStage.dbo.NorthwindStageInventory
select * from NorthwindInventoryDW.dbo.DimDate
insert into NorthwindInventoryDW.dbo.FactInventory (ProductKey, SupplierKey, OrderDateKey, OrderID, CategoryName, UnitsOnOrder, UnitsInStock)
select p.ProductKey, s.SupplierKey,
		Day(i.OrderDate) + MONTH(i.OrderDate) * 100 + YEAR(i.OrderDate) * 10000 As OrderDateKey,
		i.OrderID,i.CategoryName, i.UnitsOnOrder, i.UnitsInStock
from NorthwindInventoryDWStage.dbo.NorthwindStageInventory i
	join NorthwindInventoryDW.dbo.DimProducts p on i.ProductID = p.ProductID
	join NorthwindInventoryDW.dbo.DimSuppliers s on i.SupplierID = s.SupplierID