--Sub Query
--��ͧ����Ң����ŷ���յ��˹����ǡѺ Nancy
--1.1�ҵ��˹觨ͧ Nancy ��͹
select title from Employees where FirstName = 'nancy'
--1.2 �Ң����Ť�����յ��˹����ǡѺ��� 1
select * from Employees 
where title = (Select title from Employees where firstname = 'Nancy')
--2.��ͧ��ê��͹��ʡ�ž�ѡ�ҹ����������ҡ����ش
Select FirstName, LastName from Employees
where BirthDate = (Select min(Birthdate) from Employees)
--2.1��ͧ��ê����Թ��ҷ�����Ҥ��ҡ�����Թ��Ҫ��� Ikura
select ProductName from Products
where UnitPrice > (Select UnitPrice from Products where ProductName =  'Ikura')
--2.2��ͧ��ê��ͺ���ѷ�١��ҷ���������ͧ���ǡѹ�Ѻ����ѷ���� Around the Horn
select CompanyName from Customers
where City = (select city from Customers where CompanyName = 'Around the Horn')
--2.3��ͧ��ê��͹��ʡ�ž�ѡ�ҹ�ѹ�����ҧҹ�ҡ����ش
select FirstName,LastName from Employees
where HireDate = (select max(hiredate) from Employees)
--2.4���������觫��ͷ��١��任���ȷ������ռ���Ե�Թ��ҵ������
select * from Orders
where ShipCountry not in (select distinct country from Suppliers)

--���������Ţ�ӴѺ
--��ͧ��â������Թ��ҷ�����Ҥҹ��¡��� 50$
select ROW_NUMBER() over (order by unitprice desc) as RowNum,
ProductName, UnitPrice 
from Products 
where UnitPrice < 50

select * from Shippers
--���ҧ����� pk �� AutoIncrement (Autonumber)
Insert into Shippers
values('����ѷ�����ШӡѴ', '081-12345678')
insert into Shippers(CompanyName)
values('����ѷ�������ŨӡѴ')
insert into Shippers(CompanyName)
values('����ѷ�������ШӡѴ')

select * from Customers
--���ҧ����� PK �� Char,nChar
insert into Customers(CustomerID,CompanyName)
values('A0001','����ѷ�������ШӡѴ')

--�����������ž�ѡ�ҹ 1 �� (����������ҷ����)
select * from Employees
insert into Employees(FirstName,LastName)
values('����ѵ�','�ͧ��������')

--�������Թ��� ���ᴡ�ͧ �Ҥ�1.5$ �ӹǹ 12
select * from Products
insert into Products(ProductName, UnitPrice,UnitsInStock)
values('���ᴡ�ͧ',1.5,12)

--��Ѻ��ا�������Ѿ�� �ͧ����ѷ���� ���� 6
update Shippers
set Phone = '085-9999998'
where ShipperID = 5

--��Ѻ��ا�ӹǹ�Թ��Ҥ�������Թ������� 1 �����ӹǹ���� 100 ���
update Products
set UnitsInStock = UnitsInStock+100
where ProductID = 1

--��Ѻ��ا ���ͧ ��л�����١��� ���� A0001 ����� �شøҹ�, Thailand
select * from Customers
update Customers
set City = '�شøҹ�', Country='Thailand'
where CustomerID = 'A0001'

--����� delete
delete from Products
where ProductID=78

delete from Shippers
where ShipperID = 78