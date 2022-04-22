Pivot and Unpivot in SQL are two relational operators that are used to convert a table expression into another.
Pivot in SQL is used when we want to transfer data from row level to column level.
Unpivot in SQL is used when we want to convert data from column level to row level.
PIVOT and UNPIVOT relational operators are used to generate a multidimensional reporting.

SYNTAX FOR PIVOT
SELECT <non-pivoted column>,  
       <list of pivoted column>  
FROM  
(<SELECT query  to produces the data>)  
    AS <alias name>  
PIVOT  
(  
<aggregation function>(<column name>)  
FOR  
[<column name that  become column headers>]  
    IN ( [list of  pivoted columns])  
  
) AS <alias name  for  pivot table>  

--============================================
CREATE TABLE WORKERS(
NAME VARCHAR(30),
YEAR INT,
SALES INT
)

INSERT INTO WORKERS  
SELECT 'Pankaj',2010,72500 UNION ALL  
SELECT 'Rahul',2010,60500 UNION ALL  
SELECT 'Sandeep',2010,52000 UNION ALL  
SELECT 'Pankaj',2011,45000 UNION ALL  
SELECT 'Sandeep',2011,82500 UNION ALL  
SELECT 'Rahul',2011,35600 UNION ALL  
SELECT 'Pankaj',2012,32500 UNION ALL  
SELECT 'Pankaj',2010,20500 UNION ALL  
SELECT 'Rahul',2011,200500 UNION ALL  
SELECT 'Sandeep',2010,32000   

SELECT * FROM WORKERS
 --THIS PIVOT CAN BE USED WHEN WE DON'T HAVE ID IN TABLE
SELECT NAME, [2010],[2011],[2012]
FROM WORKERS
PIVOT
(
 SUM(SALES) FOR YEAR IN([2010],[2011],[2012])
 ) AS PIVOTTABLE


CREATE TABLE WORKERS_1(
ID INT IDENTITY(1,1),
NAME VARCHAR(30),
YEAR INT,
SALES INT
)

INSERT INTO  WORKERS_1
SELECT 'Pankaj',2010,72500 UNION ALL  
SELECT 'Rahul',2010,60500 UNION ALL  
SELECT 'Sandeep',2010,52000 UNION ALL  
SELECT 'Pankaj',2011,45000 UNION ALL  
SELECT 'Sandeep',2011,82500 UNION ALL  
SELECT 'Rahul',2011,35600 UNION ALL  
SELECT 'Pankaj',2012,32500 UNION ALL  
SELECT 'Pankaj',2010,20500 UNION ALL  
SELECT 'Rahul',2011,200500 UNION ALL  
SELECT 'Sandeep',2010,32000   

SELECT * FROM WORKERS_1

SELECT YEAR, Pankaj,Rahul,Sandeep
from 
(select name,year,sales from WORKERS_1)as Sourcetable --for id we need to create drived table
pivot
(
 sum(sales) for name in(Pankaj,Rahul,Sandeep)
 ) as pivottable

 --==========================================================
 --UNPIVOT
 CREATE TABLE WORKERSCOPY_1(
 NAME INT,
 YEAR INT,
 SALES INT
 )

 INSERT INTO WORKERCOPY_1
 SELECT YEAR,Pankaj,Rahul,Sandeep
 FROM
 (SELECT NAME,YEAR,SALES FROM WORKERSCOPY_1)AS SPV
 PIVOT
 (
  SUM(SALES) FOR NAME IN(Pankaj,Rahul,Sandeep)
  ) AS PVT
 --==================================
 /*write PIVOT and UNPIVOT example on Covid cases data
create a table with CityName, Year, covidcases
insert some sample data (take multiple rows per city)
apply PIVOT and UNPIVOT */

CREATE TABLE COVID(
ID INT,
CITYNAME VARCHAR(40),
YEAR INT,
COVIDECASES INT,
)

INSERT INTO COVID
SELECT 1,'INDORE',2020,40000
UNION
SELECT 2,'VARODARA',2020,60000
UNION
SELECT 3,'HYDERABAD',2020,70000
UNION
SELECT 4,'BANGALORE',2020,80000
UNION
SELECT 5,'INDORE',2021,80000
UNION
SELECT 6,'VARODARA',2021,70000
UNION
SELECT 7,'HYDERABAD',2021,90000
UNION
SELECT 8,'BANGALORE',2021,95000
UNION
SELECT 9,'INDORE',2022,NULL
UNION
SELECT 10,'VARODARA',2022,1500
UNION
SELECT 11,'HYDERABAD',2022,NULL
UNION
SELECT 12,'BANGALORE',2022,10000

SELECT * FROM COVID

SELECT CITYNAME, [2020],[2021],[2022]
FROM 
(SELECT CITYNAME,YEAR,COVIDECASES
FROM COVID) AS DERIVED
PIVOT
( 
 SUM(COVIDECASES) FOR YEAR IN([2020],[2021],[2022])
 ) AS PIVOTTABLE
 
--===================
SELECT YEAR, INDORE,VARODARA,HYDERABAD,BANGALORE
FROM
(SELECT CITYNAME,YEAR,COVIDECASES
FROM COVID)AS DERIVED
PIVOT(
SUM(COVIDECASES) FOR CITYNAME IN( INDORE,VARODARA,HYDERABAD,BANGALORE)
)AS PVT
 

--======================================
--UNPIVOT
CREATE TABLE COVID_COPY(
YEAR INT,
INDORE INT,
VARODARA INT,
HYDERABAD INT,
BANGALORE INT
)
 INSERT INTO COVID_COPY
 SELECT YEAR, INDORE,VARODARA,HYDERABAD,BANGALORE
FROM
(SELECT CITYNAME,YEAR,COVIDECASES
FROM COVID)AS DERIVED
PIVOT(
SUM(COVIDECASES) FOR CITYNAME IN( INDORE,VARODARA,HYDERABAD,BANGALORE)
)AS PVT

SELECT * FROM COVID_COPY

SELECT CITYNAME,YEAR,COVIDECASES FROM COVID_COPY
UNPIVOT
(
COVIDECASES FOR CITYNAME IN ( INDORE,VARODARA,HYDERABAD,BANGALORE)
)PVT
--=================================================
SELECT * FROM Sales.OrderDetails
ALTER PROCEDURE USP_PRODUCTDETAILS
( @unitprice decimal(20,10),
  @qty int
)
as
begin
 select * from Sales.OrderDetails
 where unitprice = @unitprice
 and qty = @qty
end

execute  USP_PRODUCTDETAILS @unitprice =34.80 ,@qty =5

select DATEDIFF(YEAR,'2021-12-12','2022-12-12')
select DATEADD(MONTH,12,'2020-12-24')
select getdate()
select DATEPART(MONTH,getdate()
select DATENAME(QQ,'2018-07-21') --qq for quarter of year
select DATEFROMPARTS(2018,05,23)
select EOMONTH('2021-02-23')
select day(eomonth('2014-08-23'))
select DATEDIFF(MONTH,'2021-04-23','2022-02-23')
select convert(varchar(20),getdate())
select year('2021-10-12')
select day('2022-07-21')
select CONVERT(datetime,getdate())

--=================================
--RANK FUNCTION
SELECT * FROM EMPLOYEE
SELECT FIRST_NAME,LAST_NAME,DEPARTMENT,DENSE_RANK()  OVER (PARTITION BY DEPARTMENT ORDER BY SALARY)
