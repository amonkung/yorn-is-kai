//ชลรวัตร ทองอยู่เลิศ 67040233126
--Sub Query
--µéÍ§¡ÒÃËÒ¢éÍÁÙÅ·ÕèÁÕµÓáË¹è§à´ÕÂÇ¡Ñº Nancy
--1.1ËÒµÓáË¹è§¨Í§ Nancy ¡èÍ¹
select title from Employees where FirstName = 'nancy'
--1.2 ËÒ¢éÍÁÙÅ¤¹·ÕèÁÕµÓáË¹è§à´ÕÂÇ¡Ñº¢éÍ 1
select * from Employees 
where title = (Select title from Employees where firstname = 'Nancy')
--2.µéÍ§¡ÒÃª×èÍ¹ÒÁÊ¡ØÅ¾¹Ñ¡§Ò¹·ÕèÁÕÍÒÂØÁÒ¡·ÕèÊØ´
Select FirstName, LastName from Employees
where BirthDate = (Select min(Birthdate) from Employees)
--2.1µéÍ§¡ÒÃª×èÍÊÔ¹¤éÒ·ÕèÁÕÃÒ¤ÒÁÒ¡¡ÇèÒÊÔ¹¤éÒª×èÍ Ikura
select ProductName from Products
where UnitPrice > (Select UnitPrice from Products where ProductName =  'Ikura')
--2.2µéÍ§¡ÒÃª×èÍºÃÔÉÑ·ÅÙ¡¤éÒ·ÕèÍÂÙèàÁ×Í§à´ÕÂÇ¡Ñ¹¡ÑººÃÔÉÑ·ª×èÍ Around the Horn
select CompanyName from Customers
where City = (select city from Customers where CompanyName = 'Around the Horn')
--2.3µéÍ§¡ÒÃª×èÍ¹ÒÁÊ¡ØÅ¾¹Ñ¡§Ò¹ÇÑ¹·Õèà¢éÒ§Ò¹ÁÒ¡·ÕèÊØ´
select FirstName,LastName from Employees
where HireDate = (select max(hiredate) from Employees)
--2.4¢éÍÁÙÅãºÊÑè§«×éÍ·Õè¶Ù¡Êè§ä»»ÃÐà·È·ÕèäÁèÁÕ¼Ùé¼ÅÔµÊÔ¹¤éÒµÑé§ÍÂÙè
select * from Orders
where ShipCountry not in (select distinct country from Suppliers)

--¡ÒÃãÊèµÑÇàÅ¢ÅÓ´Ñº
--µéÍ§¡ÒÃ¢éÍÁÙÅÊÔ¹¤éÒ·ÕèÁÕÃÒ¤Ò¹éÍÂ¡ÇèÒ 50$
select ROW_NUMBER() over (order by unitprice desc) as RowNum,
ProductName, UnitPrice 
from Products 
where UnitPrice < 50

select * from Shippers
--µÒÃÒ§·ÕèÁÕ pk à»ç¹ AutoIncrement (Autonumber)
Insert into Shippers
values('ºÃÔÉÑ·¢¹àÂÍÐ¨Ó¡Ñ´', '081-12345678')
insert into Shippers(CompanyName)
values('ºÃÔÉÑ·¢¹ÁËÒÈÒÅ¨Ó¡Ñ´')
insert into Shippers(CompanyName)
values('ºÃÔÉÑ·«×éÍàÂÍÐ¨Ó¡Ñ´')

select * from Customers
--µÒÃÒ§·ÕèÁÕ PK à»ç¹ Char,nChar
insert into Customers(CustomerID,CompanyName)
values('A0001','ºÃÔÉÑ·«×éÍàÂÍÐ¨Ó¡Ñ´')

--¨§à¾ÔèÁ¢éÍÁÙÅ¾¹Ñ¡§Ò¹ 1 ¤¹ (ãÊè¢éÍÁÙÅà·èÒ·ÕèÁÕ)
select * from Employees
insert into Employees(FirstName,LastName)
values('ªÅÃÇÑµÃ','·Í§ÍÂÙèàÅÔÈ')

--¨§à¾ÔèÁÊÔ¹¤éÒ »ÅÒá´¡ºÍ§ ÃÒ¤Ò1.5$ ¨Ó¹Ç¹ 12
select * from Products
insert into Products(ProductName, UnitPrice,UnitsInStock)
values('»ÅÒá´¡ºÍ§',1.5,12)

--»ÃÑº»ÃØ§àºÍÃìâ·ÃÈÑ¾·ì ¢Í§ºÃÔÉÑ·¢¹Êè§ ÃËÑÊ 6
update Shippers
set Phone = '085-9999998'
where ShipperID = 5

--»ÃÑº»ÃØ§¨Ó¹Ç¹ÊÔ¹¤éÒ¤§àËÅ×ÍÊÔ¹¤éÒÃËÑÊ 1 à¾ÔèÁ¨Ó¹Ç¹à¢éÒä» 100 ªÔé¹
update Products
set UnitsInStock = UnitsInStock+100
where ProductID = 1

--»ÃÑº»ÃØ§ àÁ×Í§ áÅÐ»ÃÐà·ÈÅÙ¡¤éÒ ÃËÑÊ A0001 ãËéà»ç¹ ÍØ´Ã¸Ò¹Õ, Thailand
select * from Customers
update Customers
set City = 'ÍØ´Ã¸Ò¹Õ', Country='Thailand'
where CustomerID = 'A0001'

--¤ÓÊÑè§ delete
delete from Products
where ProductID=78

delete from Shippers

where ShipperID = 78
