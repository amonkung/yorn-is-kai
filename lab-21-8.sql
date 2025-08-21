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

