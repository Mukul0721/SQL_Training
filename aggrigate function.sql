AGGREGATE FUNCTIONS : Function where the values of multiple rows are grouped together as input on 
                  certain criteria to form a single value of more significant meaning.
AGGREGATE FUNCGTIONS ARE :
     COUNT()
	 AVG()
	 MIN()
	 MAX()
	 SUM()

SELECT COUNT(AGE) FROM EMP
SELECT MIN(AGE) FROM EMP
SELECT MAX(AGE) FROM EMP
SELECT SUM(AGE) FROM EMP
SELECT AVG(AGE) FROM EMP

GROUP BY CLAUSE :The GROUP BY Statement is used to arrange identical data into groups with the help of 
some functions. i.e if a particular column has same values in different rows then it will arrange these rows 
in a group.

Important Points:

GROUP BY clause is used with the SELECT statement.
In the query, GROUP BY clause is placed after the WHERE clause.
In the query, GROUP BY clause is placed before ORDER BY clause if used any.

SELECT * FROM EMP

SELECT NAME,SUM(AGE)
FROM EMP
GROUP BY NAME


SELECT * FROM EMP
ORDER BY AGE DESC

HAVING CLAUSE : Having Clause is basically like the aggregate function with the GROUP BY clause.
       The HAVING clause is used instead of WHERE with aggregate functions.
	   The having clause is always used after the group By clause.


SELECT NAME,SUM(AGE)
FROM EMP
GROUP BY NAME
HAVING SUM(AGE) > 25


