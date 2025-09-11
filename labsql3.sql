--ชลรวัตร ทองอยู่เลิศ 67040233126
Select ProductID, ProductName,
UnitPrice,UnitsInStock,UnitPrice*UnitsInStock as StockValue
From Products

Select ProductID as ÃËÑÊ, ProductName as ÊÔ¹¤éÒ,
¨Ó¹Ç¹ÊÔ¹¤éÒ·Ñé§ËÁ´ =UnitsInStock + UnitsOnOrder,
¨Ø´ÊÑè§«×éÍ = ReorderLevel
from Products
where (UnitsInStock+UnitsOnOrder) < ReorderLevel

Select ProductID,ProductName,
UnitPrice,ROUND(UnitPrice * 0.07,2) AS Vat7
from Products

Select EmployeeID,TitleOfCourtesy+FirstName+space(1)+LastName as [Employee Name]
From Employees
Select EmployeeID,TitleOfCourtesy+FirstName+' '+LastName as [Employee Name]
From Employees

select OrderID, ProductID,UnitPrice,Quantity,Discount,
	(UnitPrice*Quantity) as TotalPrice,
	(UnitPrice*Discount) as DiscountPrice,
	UnitPrice* Quantity*(1-Discount) as Netprice
from [Order Details]
select(42.40*35)-(42.40*35*0.15)

Select EmployeeID,FirstName,BirthDate,DATEDIFF(YEAR,BirthDate,'2024-12-31') Age,
	HireDate, DATEDIFF(YEAR,HireDate,GETDATE()) YearInOffice
from Employees

select count(*)As ¨Ó¹Ç¹ÊÔ¹¤éÒ,count(ProductID), count(productName),count(UnitPrice)
from Products where UnitsInStock<15

select *
from Products where UnitsInStock<15

SELECT count(*) from Customers where Country = 'USA'

select count(*) from Employees where City= 'London'

select count(*) from Orders where year(OrderDate)=1997

select count(*) from [Order Details] where ProductID=1

Select SUM(Quantity) from [Order Details] where ProductID =2

select sum(UnitPrice * UnitsInStock) from Products

select sum(UnitsOnOrder) 
from Products where CategoryID=8

select max(UnitPrice), min(UnitPrice)
from [Order Details] where ProductID=71

select avg(UnitPrice),max(UnitPrice), min(UnitPrice)
from [Order Details] where ProductID=5

select Country, Count(*) as [Num of Country]
from Customers group by Country

Select CategoryID,avg(UnitPrice),min(UnitPrice), max(UnitPrice)
from Products group by CategoryID

select orderID, count(*) 
from [Order Details] group by OrderID having count(*)>3

select ShipCountry,count(*) numOfOders
from Orders group by ShipCountry having count(*)>=100

select Country,count(*) as "Num of Country"
from Customers group by Country having count(*)<5

select OrderID, sum(UnitPrice*Quantity*(1-Discount))
from [Order Details] group by OrderID having sum(UnitPrice*Quantity*(1-Discount))<100

select shipcountry, count(*) as numOfOrders from Orders
where YEAR(OrderDate)=1997 group by ShipCountry having count(*)<20
order by count(*) desc

select top 1 orderID, sum(UnitPrice*Quantity*(1-Discount)) as total
from [Order Details] group by OrderID Order by total desc

select top 5 orderID, sum(UnitPrice*Quantity*(1-Discount)) as total

from [Order Details] group by OrderID Order by total asc

