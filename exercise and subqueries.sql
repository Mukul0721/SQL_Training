SELECT * FROM Sales.Orders

--Query for Order placed in June 2007

SELECT orderid,orderdate,custid,empid 
FROM Sales.Orders
WHERE orderdate BETWEEN'2007-06-01' AND '2007-06-30'

--Query to return order placed on the last day of the month.

SELECT orderid,EOMONTH(orderdate) AS orderdate,custid,empid 
FROM Sales.Orders

--Query for returning employees having last name containing letter a twice.

SELECT empid,firstname,lastname FROM HR.Employees
WHERE  lastname like '%a%a%'

SELECT * FROM Sales.OrderDetails
--Query to returns orders with totalvalue(qty*unitprice) greater then 10000.
SELECT orderid,SUM(qty*unitprice) as totalvalue
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty*unitprice)  > 10000
ORDER BY totalvalue desc

--Query to return 3 shipped to countries with highest avgfreight in 2007
SELECT * FROM Sales.Orders
SELECT TOP (3) shipcountry, AVG(freight) AS avgfreight
FROM Sales.Orders
WHERE orderdate >='2007-01-01' AND orderdate < '2008-01-01'
GROUP BY shipcountry
ORDER BY avgfreight DESC;

--=======================================
--Query to generate five copies of each employee row.
 --SELECT * FROM HR.Employees
 --SELECT * FROM dbo.Nums
 SELECT E.empid,E.lastname,E.firstname,N.n
 FROM HR.Employees AS E
 CROSS APPLY dbo.Nums AS N
 ORDER BY n,empid

--Return US Customers and for each Customer return total number of orders and total number of quantaties.
SELECT * FROM Sales.Customers
SELECT * FROM Sales.Orders
SELECT * FROM Sales.OrderDetails

SELECT C.custid,COUNT(DISTINCT O.orderid) AS numorders,SUM(OD.qty) AS totalqty
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
ON C.custid = O.custid
INNER JOIN Sales.OrderDetails AS OD
ON OD.orderid = O.orderid
WHERE COUNTRY = 'USA'
GROUP BY C.custid

--Return Customer and their orders,including customers who doesn't placed orders.
SELECT * FROM Sales.Customers
SELECT * FROM Sales.Orders

SELECT C.custid,C.companyname,O.orderid,O.orderdate
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
ON C.custid = O.custid

--Return Customers who doesn't placed any order

SELECT C.custid,C.companyname
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
ON C.custid = O.custid
WHERE O.orderid IS NULL

--Calculating row numbers order based on order date ordering for each customer separately.
SELECT * FROM Sales.Orders
SELECT custid,orderdate,orderid, ROW_NUMBER() over(PARTITION BY custid ORDER BY orderdate) as rownum
from Sales.Orders

---- Return for each customer the customer ID and region
-- sort the rows in the output by region
-- having NULLs sort last (after non-NULL values)
-- Note that the default in T-SQL is that NULLs sort first
-- Tables involved: Sales.Customers table


SELECT * FROM Sales.Customers

select custid,region
from Sales.Customers
order by 
   CASE WHEN region IS NULL THEN 1 ELSE 0 END,region;

--- Write a query that returns all orders placed on the last day of
-- activity that can be found in the Orders table
-- Tables involved: TSQLV4 database, Orders table
SELECT * FROM Sales.Orders

SELECT orderid,orderdate,custid,empid
FROM Sales.Orders
WHERE orderdate = (SELECT MAX(orderdate) FROM Sales.Orders)

-- 2 (Optional, Advanced)
-- Write a query that returns all orders placed
-- by the customer(s) who placed the highest number of orders
-- * Note: there may be more than one customer
--   with the same number of orders
-- Tables involved: TSQLV4 database, Orders table
SELECT orderid,custid,orderdate,empid
FROM Sales.Orders
WHERE custid IN (SELECT TOP(1) custid FROM Sales.Orders
 GROUP BY custid
 ORDER BY COUNT(*) DESC)

 -- Write a query that returns employees
-- who did not place orders on or after May 1st, 2016
-- Tables involved: TSQLV4 database, Employees and Orders tables
SELECT * FROM HR.Employees
SELECT * FROM Sales.Orders

SELECT empid,firstname,lastname
FROM HR.Employees
WHERE empid NOT IN(SELECT empid FROM Sales.Orders
WHERE orderdate >= '2016-05-01')

-- Write a query that returns
-- countries where there are customers but not employees
-- Tables involved: TSQLV4 database, Customers and Employees tables
SELECT * FROM HR.Employees
SELECT * FROM Sales.Customers

SELECT DISTINCT country FROM Sales.Customers
WHERE country NOT IN (SELECT country FROM HR.Employees)

-- Write a query that returns for each customer
-- all orders placed on the customer's last day of activity
-- Tables involved: TSQLV4 database, Orders table
SELECT * FROM Sales.Orders

SELECT custid,orderid,orderdate,empid
FROM Sales.Orders AS O1
WHERE orderdate = 
(SELECT MAX(O2.orderdate)
 FROM Sales.Orders AS O2
 WHERE O2.custid = O1.custid)
order by custid

