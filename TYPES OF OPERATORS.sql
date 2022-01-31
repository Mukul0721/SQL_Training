OPERATORS IN SQL SERVER
=====================================

1) ARITHMETRIC OPERATORS
2) LOGICAL OPERATORS
3) SET OPERATORS
4) COMPARISON OPERATORS
5) SPECIAL OPERATORS
6) ASSIGNMENT OPERATORS
7) STRING CONCAT OPERATOR

================================================

1) ARITHMETRIC OPERATORS : USED TO PERFORM MATHEMATICAL OPERATIONS ON GIVEN VALUES
   
   ARITHMETRIC OPERATORS ARE :
    
	+    'ADDITION'
	-    'SUBTRACTION'
	*    'MULTIPLICATION'
	/    'DIVIDION'
	%    'MODULE'

IF EXISTS(SELECT 1 FROM SYS.TABLES WHERE NAME = 'STUDENTS_MARK')
BEGIN 
  DROP TABLE STUDENTS_MARK
END


GO
CREATE TABLE STUDENTS_MARK(
 ID INT,
 CLASS VARCHAR(10),
 NAME VARCHAR(20),
 ENGLISH INT,
 HINDI INT,
 MATHS INT,
 SCIENCE INT,
 COMPUTER INT
 )

GO

INSERT INTO STUDENTS_MARK(ID,CLASS,NAME,ENGLISH,HINDI,MATHS,SCIENCE,COMPUTER)
VALUES(1,'IX','VISHAL',65,45,86,75,90),
      (2,'IX','SNEHAL',78,87,67,84,75),
	  (3,'IX','ANNI',56,65,45,67,87),
	  (4,'IX','RAHUL',55,45,65,53,76),
	  (5,'IX','HARDIK',49,56,98,56,76)

SELECT * FROM STUDENTS_MARK

ALTER TABLE STUDENTS_MARK
ADD TOTALMARKS INT

ALTER TABLE STUDENTS_MARK
ADD AVG_MARKS INT

UPDATE STUDENTS_MARK
SET TOTALMARKS = ENGLISH+HINDI+MATHS+SCIENCE+COMPUTER
WHERE ID = 5

UPDATE STUDENTS_MARK
SET AVG_MARKS = TOTALMARKS/5
WHERE ID = 5

SELECT *FROM STUDENTS_MARK 
 

SELECT TOTALMARKS * AVG_MARKS 
FROM STUDENTS_MARK
WHERE ID =1

SELECT TOTALMARKS - AVG_MARKS
FROM STUDENTS_MARK
WHERE ID = 2

SELECT TOTALMARKS / AVG_MARKS
FROM STUDENTS_MARK
WHERE ID = 5

SELECT TOTALMARKS % AVG_MARKS
FROM STUDENTS_MARK
WHERE ID = 5

========================================
2) LOGICAL OPERATORS : USED TO CHECK SOME CONDITIONS AND RETURNS BOOLEAN VALUE MAY BE TRUE OR FALSE.
   LOGICAL OPERATORS ARE :
   AND
   ALL
   BETWEEN
   IN 
   LIKE 
   NOT
   OR
   IS NULL

   SELECT * FROM 
   STUDENTS_MARK
   WHERE TOTALMARKS BETWEEN 300 AND 400
   
    SELECT * FROM 
   STUDENTS_MARK
   WHERE NAME LIKE('S%L')
	
	SELECT * FROM 
   STUDENTS_MARK
   WHERE TOTALMARKS IS NULL

======================================
SET OPERATORS : USED TO COMBINE RESULT OF 2 OR MORE TABLES AS A SINGLE SET OF VALUES.
SET OPERATORS ARE : 
 UNION 
 UNION ALL
 INTERSECT
 EXCEPT

 Some important Rules we should follow to use Set Operators.
 Number of columns and order must be the same in all the queries.
Columns Datatypes should be compatible.

Create table class_A(id int,studnetname varchar(50),Marks int,Age int)  
Create table class_B(id int,studentname varchar(50),marks int ,Age int) 

SELECT * FROM class_A
SELECT * FROM class_B

insert into class_A values(1,'A',88,21)  
insert into class_A values(2,'B',76,19)  
insert into class_A values(3,'C',81,22)  
insert into class_A values(4,'D',57,20)


insert into class_B values(1,'A',88,21)  
insert into class_B values(5,'E',57,20)  
insert into class_B values(6,'P',57,20)

UNION : Union fetches all the values from the tables without Duplicates.
SELECT * FROM class_A
UNION
SELECT * FROM class_B

UNION ALL : SAME AS UNION BUT HAVING SMALL DIFFERENCE IT RETURNS DUPLICATE VALUES TOO.

SELECT * FROM class_A
UNION ALL
SELECT * FROM class_B

INTERSECT : It returns the common values from the Tables.

Select studnetname from class_a  
intersect  
Select studentname from class_b

EXCEPT : USED TO DISPLAY  RESULTS THAT ARE IN ONE TABLE NOT IN OTHER TABLE.

Select studnetname from class_a  
EXCEPT  
Select studentname from class_b

4) COMPARISON OPERATORS : Comparison Operators are used for comparing values with the given specific conditions.
   COMPARISON OPERATORS  ARE :
   > 'GREATER THEN'
   < 'LESS THEN'
   <= 'LESS THEN EQUAL TO'
   >= 'GREATER THEN EQUAL TO'
   != 'NOT EQUAL TO'

   SELECT NAME 
   FROM STUDENTS_MARK
   WHERE TOTALMARKS <300

   SELECT NAME,ID 
   FROM STUDENTS_MARK
   WHERE MATHS > 80

   SELECT NAME,TOTALMARKS,AVG_MARKS
   FROM STUDENTS_MARK
   WHERE ID = 5

======================================================

5)SPECIAL OPERATORS 
These are special operators in SQL Server,
1) Between
2) In
3) Like
4) IsNull

Between :
--------
Between is used to fetch values from a given Range. Between operator is to return the values from source values.
It can be applied on small to big range values only.
It doesn’t support Big to small values range.
We should use and operator when we implement between operators.
Example

Write a query to get students whose age is between 22 to 26.
Select * from class_A where age Between 20 and 22  

In:
----

It works on the given list of values in the given condition.
It is an extension of Or operator.
The performance of In operator is faster than OR operator. When we use OR operator we will repeat the column names again and again in the query but when we use In operator there is no need to repeat the column name in the query.
In OR operator query length will be increased.
Example

Write a query to display student details whose names are a,c,d.
select * from class_A where studnetname in('a','c','d')  

IS NULL :
---------

IS NULL operator is to compare the values with Null in the table.
It occupies 0-byte memory.

Like :
------

Like is used to filter the values in the given expression or condition.

We can use like operator with this given expression. These are called Wildcard operators.
% It represents any char in the given expression.
-It represents a single char in the expression.
[]-it represents a group of char.
Example

Write a query to display student details whose name starts with a.
select * from class_A where studnetname like 'a%' 

6) Assignment operator
=======================
The assignment operator is used to assign values to operands.

Assignment operator: =

Select * from STUDENTS_MARK where id=4  

