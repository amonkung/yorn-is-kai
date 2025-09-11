--Sub Query
--ต้องการหาข้อมูลที่มีตำแหน่งเดียวกับ Nancy
--1.1หาตำแหน่งจอง Nancy ก่อน
select title from Employees where FirstName = 'nancy'
--1.2 หาข้อมูลคนที่มีตำแหน่งเดียวกับข้อ 1
select * from Employees 
where title = (Select title from Employees where firstname = 'Nancy')
--2.ต้องการชื่อนามสกุลพนักงานที่มีอายุมากที่สุด
Select FirstName, LastName from Employees
where BirthDate = (Select min(Birthdate) from Employees)
--2.1ต้องการชื่อสินค้าที่มีราคามากกว่าสินค้าชื่อ Ikura
select ProductName from Products
where UnitPrice > (Select UnitPrice from Products where ProductName =  'Ikura')
--2.2ต้องการชื่อบริษัทลูกค้าที่อยู่เมืองเดียวกันกับบริษัทชื่อ Around the Horn
select CompanyName from Customers
where City = (select city from Customers where CompanyName = 'Around the Horn')
--2.3ต้องการชื่อนามสกุลพนักงานวันที่เข้างานมากที่สุด
select FirstName,LastName from Employees
where HireDate = (select max(hiredate) from Employees)
--2.4ข้อมูลใบสั่งซื้อที่ถูกส่งไปประเทศที่ไม่มีผู้ผลิตสินค้าตั้งอยู่
select * from Orders
where ShipCountry not in (select distinct country from Suppliers)

--การใส่ตัวเลขลำดับ
--ต้องการข้อมูลสินค้าที่มีราคาน้อยกว่า 50$
select ROW_NUMBER() over (order by unitprice desc) as RowNum,
ProductName, UnitPrice 
from Products 
where UnitPrice < 50

select * from Shippers
--ตารางที่มี pk เป็น AutoIncrement (Autonumber)
Insert into Shippers
values('บริษัทขนเยอะจำกัด', '081-12345678')
insert into Shippers(CompanyName)
values('บริษัทขนมหาศาลจำกัด')
insert into Shippers(CompanyName)
values('บริษัทซื้อเยอะจำกัด')

select * from Customers
--ตารางที่มี PK เป็น Char,nChar
insert into Customers(CustomerID,CompanyName)
values('A0001','บริษัทซื้อเยอะจำกัด')

--จงเพิ่มข้อมูลพนักงาน 1 คน (ใส่ข้อมูลเท่าที่มี)
select * from Employees
insert into Employees(FirstName,LastName)
values('ชลรวัตร','ทองอยู่เลิศ')

--จงเพิ่มสินค้า ปลาแดกบอง ราคา1.5$ จำนวน 12
select * from Products
insert into Products(ProductName, UnitPrice,UnitsInStock)
values('ปลาแดกบอง',1.5,12)

--ปรับปรุงเบอร์โทรศัพท์ ของบริษัทขนส่ง รหัส 6
update Shippers
set Phone = '085-9999998'
where ShipperID = 5

--ปรับปรุงจำนวนสินค้าคงเหลือสินค้ารหัส 1 เพิ่มจำนวนเข้าไป 100 ชิ้น
update Products
set UnitsInStock = UnitsInStock+100
where ProductID = 1

--ปรับปรุง เมือง และประเทศลูกค้า รหัส A0001 ให้เป็น อุดรธานี, Thailand
select * from Customers
update Customers
set City = 'อุดรธานี', Country='Thailand'
where CustomerID = 'A0001'

--คำสั่ง delete
delete from Products
where ProductID=78

delete from Shippers
where ShipperID = 78