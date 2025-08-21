//ชลรวัตร ทองอยู่เลิศ 67040233126
select c.CategoryName, p.ProductName, p.UnitPrice  
from Products as p,Categories  as c
where p.CategoryID=c.CategoryID
and CategoryName = 'seafood'

select c.CategoryName, p.ProductName, p.UnitPrice  
from Products as p join Categories  as c
on p.CategoryID=c.CategoryID
where CategoryName = 'seafood'

select CompanyName,OrderID
from Orders, Shippers
where Shippers.ShipperID = Orders.ShipVia

select CompanyName,OrderID
from Orders join Shippers
on Shippers.ShipperID = Orders.ShipVia

SELECT O.OrderID , C.CompanyName ,
E.FirstName , O.ShipAddress 
FROM Orders O, Customers C, Employees E
WHERE O.CustomerID=C.CustomerID
AND O.EmployeeID=E.EmployeeID

SELECT O.OrderID , C.CompanyName ,
E.FirstName , O.ShipAddress
FROM Orders O join Customers C on O.CustomerID=C.CustomerID
join Employees E on O.EmployeeID=E.EmployeeID

select e.EmployeeID, FirstName , count(*) as [order]
, sum(freight) as [Sum of Freight]
from Employees e join Orders o on e.EmployeeID = o.EmployeeID
where year(orderdate) = 1998
group by e.EmployeeID, FirstName

Select Title From Employees
Where FirstName = 'Nancy'

Select *
From Employees
Where Title = (Select Title From Employees
Where FirstName = 'Nancy')
