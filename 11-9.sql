--ชลรวัตร ทองอยู่เลิศ 67040233126
-- 1.   จงแสดงให้เห็นว่าพนักงานแต่ละคนขายสินค้าประเภท Beverage ได้เป็นจำนวนเท่าใด และเป็นจำนวนกี่ชิ้น เฉพาะครึ่งปีแรกของ 2540(ทศนิยม 4 ตำแหน่ง)
SELECT 
e.EmployeeID,
e.FirstName + ' ' + e.LastName AS EmployeeName,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSales,
CAST(SUM(od.Quantity) AS DECIMAL(18,4)) AS TotalUnits
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE c.CategoryName = 'Beverages'
AND o.OrderDate >= '1997-01-01' AND o.OrderDate < '1997-07-01'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY e.EmployeeID;
-- 2.   จงแสดงชื่อบริษัทตัวแทนจำหน่าย  เบอร์โทร เบอร์แฟกซ์ ชื่อผู้ติดต่อ จำนวนชนิดสินค้าประเภท Beverage ที่จำหน่าย โดยแสดงจำนวนสินค้า จากมากไปน้อย 3 อันดับแรก
SELECT TOP 3
sup.SupplierID,
sup.CompanyName,
sup.Phone,
sup.Fax,
sup.ContactName,
COUNT(DISTINCT p.ProductID) AS BeverageProductCount
FROM Suppliers sup
JOIN Products p ON sup.SupplierID = p.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Beverages'
GROUP BY sup.SupplierID, sup.CompanyName, sup.Phone, sup.Fax, sup.ContactName
ORDER BY COUNT(DISTINCT p.ProductID) DESC;
-- 3.   จงแสดงข้อมูลชื่อลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ ของลูกค้าที่ซื้อของในเดือน สิงหาคม 2539 ยอดรวมของการซื้อโดยแสดงเฉพาะ ลูกค้าที่ไม่มีเบอร์แฟกซ์
SELECT
c.CustomerID,
c.CompanyName,
c.ContactName,
c.Phone,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalPurchase
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.OrderDate >= '1996-08-01' AND o.OrderDate < '1996-09-01'
AND c.Fax IS NULL
GROUP BY c.CustomerID, c.CompanyName, c.ContactName, c.Phone
ORDER BY c.CompanyName;
-- 4.   แสดงรหัสสินค้า ชื่อสินค้า จำนวนที่ขายได้ทั้งหมดในปี 2541 ยอดเงินรวมที่ขายได้ทั้งหมดโดยเรียงลำดับตาม จำนวนที่ขายได้เรียงจากน้อยไปมาก พรอ้มทั้งใส่ลำดับที่ ให้กับรายการแต่ละรายการด้วย
SELECT
ROW_NUMBER() OVER (ORDER BY SUM(od.Quantity) ASC) AS Rank,
p.ProductID,
p.ProductName,
SUM(od.Quantity) AS TotalUnitsSold,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSales
FROM [Order Details] od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate >= '1998-01-01' AND o.OrderDate < '1999-01-01'
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalUnitsSold ASC;
-- 5.   จงแสดงข้อมูลของสินค้าที่ขายในเดือนมกราคม 2540 เรียงตามลำดับจากมากไปน้อย 5 อันดับใส่ลำดับด้วย รวมถึงราคาเฉลี่ยที่ขายให้ลูกค้าทั้งหมดด้วย
SELECT TOP 5
ROW_NUMBER() OVER (ORDER BY SUM(od.Quantity) * SUM(od.UnitPrice * (1 - od.Discount)) DESC) AS Rank,
p.ProductID,
p.ProductName,
SUM(od.Quantity) AS TotalUnitsSold,
CAST(AVG(od.UnitPrice * (1 - od.Discount)) AS DECIMAL(18,4)) AS AvgPriceSold
FROM [Order Details] od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate >= '1997-01-01' AND o.OrderDate < '1997-02-01'
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalUnitsSold DESC;
-- 6.   จงแสดงชื่อพนักงาน จำนวนใบสั่งซื้อ ยอดเงินรวมทั้งหมด ที่พนักงานแต่ละคนขายได้ ในเดือน ธันวาคม 2539 โดยแสดงเพียง 5 อันดับที่มากที่สุด
SELECT TOP 5
e.EmployeeID,
e.FirstName + ' ' + e.LastName AS EmployeeName,
COUNT(DISTINCT o.OrderID) AS OrderCount,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE o.OrderDate >= '1996-12-01' AND o.OrderDate < '1997-01-01'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC;
-- 7.   จงแสดงรหัสสินค้า ชื่อสินค้า ชื่อประเภทสินค้า ที่มียอดขาย สูงสุด 10 อันดับแรก ในเดือน ธันวาคม 2539 โดยแสดงยอดขาย และจำนวนที่ขายด้วย
SELECT TOP 10
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    SUM(od.Quantity) AS TotalUnits,
    CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE o.OrderDate >= '1996-12-01' AND o.OrderDate < '1997-01-01'
GROUP BY p.ProductID, p.ProductName, c.CategoryName
ORDER BY TotalSales DESC;
-- 8.   จงแสดงหมายเลขใบสั่งซื้อ ชื่อบริษัทลูกค้า ที่อยู่ เมืองประเทศของลูกค้า ชื่อเต็มพนักงานผู้รับผิดชอบ ยอดรวมในแต่ละใบสั่งซื้อ จำนวนรายการสินค้าในใบสั่งซื้อ และเลือกแสดงเฉพาะที่จำนวนรายการในใบสั่งซื้อมากกว่า 2 รายการ
SELECT
o.OrderID,
c.CompanyName AS CustomerCompany,
c.Address,
c.City,
c.Country,
e.FirstName + ' ' + e.LastName AS EmployeeName,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS OrderTotal,
COUNT(od.ProductID) AS ItemCount
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY o.OrderID, c.CompanyName, c.Address, c.City, c.Country, e.FirstName, e.LastName
HAVING COUNT(od.ProductID) > 2
ORDER BY o.OrderID;
-- 9.   จงแสดง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร เบอร์แฟกซ์ ยอดที่สั่งซื้อทั้งหมดในเดือน ธันวาคม 2539 แสดงผลเฉพาะลูกค้าที่มีเบอร์แฟกซ์
SELECT
c.CustomerID,
c.CompanyName,
c.ContactName,
c.Phone,
c.Fax,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalPurchase
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= '1996-12-01' AND o.OrderDate < '1997-01-01'
AND c.Fax IS NOT NULL
GROUP BY c.CustomerID, c.CompanyName, c.ContactName, c.Phone, c.Fax
ORDER BY TotalPurchase DESC;
-- 10.  จงแสดงชื่อเต็มพนักงาน จำนวนใบสั่งซื้อที่รับผิดชอบ ยอดขายรวมทั้งหมด เฉพาะในไตรมาสสุดท้ายของปี 2539 เรียงตามลำดับ มากไปน้อยและแสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT
e.EmployeeID,
e.FirstName + ' ' + e.LastName AS EmployeeName,
COUNT(DISTINCT o.OrderID) AS OrderCount,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE o.OrderDate >= '1996-10-01' AND o.OrderDate < '1997-01-01'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC;
-- 11.  จงแสดงชื่อพนักงาน และแสดงยอดขายรวมทั้งหมด ของสินค้าที่เป็นประเภท Beverage ที่ส่งไปยังประเทศ ญี่ปุ่น
SELECT
e.EmployeeID,
e.FirstName + ' ' + e.LastName AS EmployeeName,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSalesJapanBeverages
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE c.CategoryName = 'Beverages'
  AND o.ShipCountry = 'Japan'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSalesJapanBeverages DESC;
-- 12.  แสดงรหัสบริษัทตัวแทนจำหน่าย ชื่อบริษัทตัวแทนจำหน่าย ชื่อผู้ติดต่อ เบอร์โทร ชื่อสินค้าที่ขาย เฉพาะประเภท Seafood ยอดรวมที่ขายได้แต่ละชนิด แสดงผลเป็นทศนิยม 4 ตำแหน่ง เรียงจาก มากไปน้อย 10 อันดับแรก
SELECT TOP 10
sup.SupplierID,
sup.CompanyName AS SupplierCompany,
sup.ContactName,
sup.Phone,
p.ProductID,
p.ProductName,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSalesSeafood
FROM Suppliers sup
JOIN Products p ON sup.SupplierID = p.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE c.CategoryName = 'Seafood'
GROUP BY sup.SupplierID, sup.CompanyName, sup.ContactName, sup.Phone, p.ProductID, p.ProductName
ORDER BY TotalSalesSeafood DESC;
-- 13.  จงแสดงชื่อเต็มพนักงานทุกคน วันเกิด อายุเป็นปีและเดือน พร้อมด้วยชื่อหัวหน้า
SELECT
e.EmployeeID,
e.FirstName + ' ' + e.LastName AS EmployeeName,
e.BirthDate,
DATEDIFF(year, e.BirthDate, GETDATE())- CASE 
WHEN MONTH(e.BirthDate) > MONTH(GETDATE())
OR (MONTH(e.BirthDate) = MONTH(GETDATE()) AND DAY(e.BirthDate) > DAY(GETDATE()))
THEN 1 ELSE 0 END AS AgeYears,
(DATEDIFF(month, e.BirthDate, GETDATE())
- (DATEDIFF(year, e.BirthDate, GETDATE())* 12+ CASE 
WHEN MONTH(e.BirthDate) > MONTH(GETDATE())
OR (MONTH(e.BirthDate) = MONTH(GETDATE()) AND DAY(e.BirthDate) > DAY(GETDATE()))
THEN -12 ELSE 0 END)) AS AgeMonths,m.FirstName + ' ' + m.LastName AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID
ORDER BY e.EmployeeID;
-- 14.  จงแสดงชื่อบริษัทลูกค้าที่อยู่ในประเทศ USA และแสดงยอดเงินการซื้อสินค้าแต่ละประเภทสินค้า
SELECT
c.CustomerID,
c.CompanyName,
cat.CategoryName,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalByCategory
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE c.Country = 'USA'
GROUP BY c.CustomerID, c.CompanyName, cat.CategoryName
ORDER BY c.CompanyName, cat.CategoryName;
-- 15.  แสดงข้อมูลบริษัทผู้จำหน่าย ชื่อบริษัท ชื่อสินค้าที่บริษัทนั้นจำหน่าย จำนวนสินค้าทั้งหมดที่ขายได้และราคาเฉลี่ยของสินค้าที่ขายไปแต่ละรายการ แสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT
sup.SupplierID,
sup.CompanyName,
p.ProductID,
p.ProductName,
CAST(SUM(od.Quantity) AS DECIMAL(18,4)) AS TotalUnitsSold,
CAST(AVG(od.UnitPrice * (1 - od.Discount)) AS DECIMAL(18,4)) AS AvgUnitPriceSold
FROM Suppliers sup
JOIN Products p ON sup.SupplierID = p.SupplierID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY sup.SupplierID, sup.CompanyName, p.ProductID, p.ProductName
ORDER BY sup.CompanyName, p.ProductName;
-- 16.  ต้องการชื่อบริษัทผู้ผลิต ชื่อผู้ต่อต่อ เบอร์โทร เบอร์แฟกซ์ เฉพาะผู้ผลิตที่อยู่ประเทศ ญี่ปุ่น พร้อมทั้งชื่อสินค้า และจำนวนที่ขายได้ทั้งหมด หลังจาก 1 มกราคม 2541
SELECT
sup.SupplierID,
sup.CompanyName,
sup.ContactName,
sup.Phone,
sup.Fax,
p.ProductID,
p.ProductName,
CAST(SUM(od.Quantity) AS DECIMAL(18,4)) AS TotalUnitsAfter1998
FROM Suppliers sup
JOIN Products p ON sup.SupplierID = p.SupplierID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE sup.Country = 'Japan'
AND o.OrderDate > '1998-01-01'
GROUP BY sup.SupplierID, sup.CompanyName, sup.ContactName, sup.Phone, sup.Fax, p.ProductID, p.ProductName
ORDER BY TotalUnitsAfter1998 DESC;
-- 17.  แสดงชื่อบริษัทขนส่งสินค้า เบอร์โทรศัพท์ จำนวนรายการสั่งซื้อที่ส่งของไปเฉพาะรายการที่ส่งไปให้ลูกค้า ประเทศ USA และ Canada แสดงค่าขนส่งโดยรวมด้วย
SELECT
sh.ShipperID,
sh.CompanyName AS ShipperCompany,
sh.Phone,
COUNT(DISTINCT o.OrderID) AS OrdersSent,
CAST(SUM(o.Freight) AS DECIMAL(18,4)) AS TotalFreight
FROM Orders o
JOIN Shippers sh ON o.ShipVia = sh.ShipperID
WHERE o.ShipCountry IN ('USA', 'Canada')
GROUP BY sh.ShipperID, sh.CompanyName, sh.Phone
ORDER BY OrdersSent DESC;
-- 18.  ต้องการข้อมูลรายชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ เบอร์แฟกซ์ ของลูกค้าที่ซื้อสินค้าประเภท Seafood แสดงเฉพาะลูกค้าที่มีเบอร์แฟกซ์เท่านั้น
SELECT DISTINCT
c.CustomerID,
c.CompanyName,
c.ContactName,
c.Phone,
c.Fax
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE cat.CategoryName = 'Seafood'
AND c.Fax IS NOT NULL
ORDER BY c.CompanyName;
-- 19.  จงแสดงชื่อเต็มของพนักงาน  วันเริ่มงาน (รูปแบบ 105) อายุงานเป็นปี เป็นเดือน ยอดขายรวม เฉพาะสินค้าประเภท Condiment ในปี 2540
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS EmployeeName,
CONVERT(varchar(10), e.HireDate, 105) AS HireDateFormatted,
DATEDIFF(year, e.HireDate, '1997-12-31')- CASE 
WHEN MONTH(e.HireDate) > MONTH('1997-12-31')
OR (MONTH(e.HireDate) = MONTH('1997-12-31') AND DAY(e.HireDate) > DAY('1997-12-31'))
THEN 1 ELSE 0 END AS YearsOfService,
(DATEDIFF(month, e.HireDate, '1997-12-31')- (DATEDIFF(year, e.HireDate, '1997-12-31') * 12+ CASE 
WHEN MONTH(e.HireDate) > MONTH('1997-12-31')
OR (MONTH(e.HireDate) = MONTH('1997-12-31') AND DAY(e.HireDate) > DAY('1997-12-31'))
THEN -12 ELSE 0 END)) AS MonthsOfService,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS TotalSalesCondiment1997
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE cat.CategoryName = 'Condiments'
AND o.OrderDate >= '1997-01-01' AND o.OrderDate < '1998-01-01'
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.HireDate
ORDER BY TotalSalesCondiment1997 DESC;
-- 20.  จงแสดงหมายเลขใบสั่งซื้อ  วันที่สั่งซื้อ(รูปแบบ 105) ยอดขายรวมทั้งหมด ในแต่ละใบสั่งซื้อ โดยแสดงเฉพาะ ใบสั่งซื้อที่มียอดจำหน่ายสูงสุด 10 อันดับแรก
SELECT TOP 10
o.OrderID,
CONVERT(varchar(10), o.OrderDate, 105) AS OrderDateFormatted,
CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS DECIMAL(18,4)) AS OrderTotal
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.OrderDate
ORDER BY OrderTotal DESC;
