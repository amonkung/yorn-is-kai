//ชลรวัตร ทองอยู่เลิศ 67040233126
select c.CategoryName, p.ProductName, p.UnitPrice  
from Products as p,Categories  as c
where p.CategoryID=c.CategoryID
and CategoryName = 'seafood'

select c.CategoryName, p.ProductName, p.UnitPrice  
from Products as p join Categories  as c
on p.CategoryID=c.CategoryID
where CategoryName = 'seafood'

select* from Orders where OrderID = 10250
select* from [Order Details] where OrderID = 10250

select p.ProductID,p.ProductName,s.CompanyName,s.Country
from Products p join Suppliers s
on p.SupplierID = s.SupplierID
where Country in ('usa', 'uk')

select e.EmployeeID,FirstName, o.OrderID
from Employees e join Orders o on e.EmployeeID = o.EmployeeID
order by EmployeeID

SELECT O.OrderID , C.CompanyName ,
E.FirstName , O.ShipAddress 
FROM Orders O, Customers C, Employees E
WHERE O.CustomerID=C.CustomerID
AND O.EmployeeID=E.EmployeeID

SELECT O.OrderID , C.CompanyName ,
E.FirstName , O.ShipAddress 
FROM Orders O
join Customers C on O.CustomerID=C.CustomerID
join Employees E on O.EmployeeID=E.EmployeeID

select e.EmployeeID,FirstName, count(*) as [order]
from Employees e join Orders o on e.EmployeeID = o.EmployeeID
where year(OrderDate) = 1998
group by e.EmployeeID, FirstName

select s.CompanyName, count(*) จำนวนorders
from Shippers s join Orders o on s.ShipperID = o.ShipVia
group by s.CompanyName
order by 2 desc

select p.ProductID, p.ProductName, sum(Quantity) จำนวนที่ชายได้
from products p join [Order Details] od on p.ProductID = od.ProductID
group by p.ProductID, p.ProductName
