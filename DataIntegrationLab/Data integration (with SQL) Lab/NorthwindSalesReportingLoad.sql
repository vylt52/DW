USE NorthwindSalesDW
GO

----- Load bảng dimCustomers -----
use NorthwindSalesDW
select * from dbo.dimCustomers
select * from  NorthwindSalesDWStage.dbo.NorthwindStageCustomers

insert into NorthwindSalesDW.dbo.DimCustomers (CustomerID, CompanyName, ContactName, ContactTitle, CustomerCity, CustomerRegion, CustomerCountry, CustomerPostalCode)
select  CustomerID, CompanyName, ContactName, ContactTitle, City, 
		case when Region is null then 'N/A' else Region end, Country,
		case when PostalCode is null then 'N/A' else PostalCode end
from NorthwindSalesDWStage.dbo.NorthwindStageCustomers


----- Load bảng dimEmployee -----
select * from NorthwindSalesDW.dbo.dimEmployees
select * from  NorthwindSalesDWStage.dbo.NorthwindStageEmployees
insert into NorthwindSalesDW.dbo.DimEmployees (EmployeeID, LastName, FirstName, Title, City, Region, Country)
select EmployeeID, LastName, FirstName, Title, City, Region, Country
from NorthwindSalesDWStage.dbo.NorthwindStageEmployees



----- Load bảng dimProduct -----
select * from NorthwindSalesDW.dbo.dimProducts
select * from  NorthwindSalesDWStage.dbo.NorthwindStageProducts
insert into NorthwindSalesDW.dbo.dimProducts(SupplierName, ProductID, ProductName, CategoryName, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
select CompanyName, ProductID, ProductName, CategoryName, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel,
		case when Discontinued = 1 then 'Y' else 'N' end
from NorthwindSalesDWStage.dbo.NorthwindStageProducts


----- Load bảng dimDate -----
select * from NorthwindSalesDW.dbo.dimDate
select * from  NorthwindSalesDWStage.dbo.NorthwindStageDate
insert into NorthwindSalesDW.dbo.dimDate(DateKey, Date, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, Year, IsWeekDay)
select date_key, full_date, day_of_week, day_name, day_num_in_month, day_num_overall, week_num_in_year, month_name, month, quarter, year, weekday_flag
from NorthwindSalesDWStage.dbo.NorthwindStageDate



----- Load bảng DimSuppliers -----
select * from NorthwindSalesDW.dbo.dimSuppliers
select * from  NorthwindSalesDWStage.dbo.NorthwindStageSuppliers
insert into NorthwindSalesDW.dbo.dimSuppliers(SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, Country, Phone)
select SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, Country, Phone
from NorthwindSalesDWStage.dbo.NorthwindStageSuppliers


----- Load bảng Fact Sales Reporting -----
select * from NorthwindSalesDW.dbo.FactSaleReporting
select * from NorthwindSalesDWStage.dbo.NorthwindStageSales
insert into NorthwindSalesDW.dbo.FactSaleReporting(CustomerKey, EmployeeKey, SupplierKey, ProductKey, OrderID, 
OrderDateKey, ShippedDateKey, Quantity, ExtendedPriceAmount, DiscountAmount, SoldAmount)
SELECT  c.CustomerKey, e.EmployeeKey, sup.SupplierKey, p.ProductKey, s.OrderID,
		Day(s.OrderDate) + MONTH(s.OrderDate) * 100 + YEAR(s.OrderDate) * 10000 As OrderDateKey,
		case when s.ShippedDate is null then '19960704'
		else Day(s.ShippedDate) + MONTH(s.ShippedDate) * 100 + YEAR(s.ShippedDate) * 10000 end as ShippedDateKey,
		s.Quantity,
		s.Quantity * s.UnitPrice as ExtendedPriceAmount,
		s.Quantity * s.UnitPrice * s.Discount as DiscountAmount,
		s.Quantity * s.UnitPrice * (1 - s.Discount) as SoldAmount
from NorthwindSalesDWStage.dbo.NorthwindStageSales s 
	join NorthwindSalesDW.dbo.DimCustomers c on s.CustomerID = c.CustomerID
	join NorthwindSalesDW.dbo.DimEmployees e on s.EmployeeID = e.EmployeeID
	join NorthwindSalesDW.dbo.DimProducts p on s.ProductID = p.ProductID
	join NorthwindSalesDW.dbo.dimSuppliers sup on s.SupplierID = sup.SupplierID

