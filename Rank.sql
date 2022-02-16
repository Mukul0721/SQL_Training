 SQL RANK FUNCTIONS

 RANK FUNCTIONS ARE :
 1) ROW_NUMBER() : ROW _NUMBER GIVES CONTINEOUS NUMBER FOR DUPLICATE VALUES.
 2) RANK ()      : RANK GIVES SAME NUMBER FOR DUPLICATE VALUES BUT IT SKIPS THE NEXT NUMBER
 3) DENSE_RANK() : DENSE_RANK GIVES SAME NUMBER FOR DUPLICATE VALUES BUT IT DOSENT SKIPS THE NEXT NUMBER.
 4) NTILE()      : NTILE() IS USED FOR 
 ==============================================================
IF EXISTS (SELECT 1 FROM SYS.TABLES WHERE NAME = 'XAMRESULT')
  DROP TABLE XAMRESULT

  GO
 CREATE TABLE XAMRESULT(

 NAME VARCHAR(20),
 SUBJECT VARCHAR(20),
 MARKS INT
 )

 INSERT INTO XAMRESULT(NAME,SUBJECT,MARKS)
 VALUES('ALLEN','SECINCE',78),('ALLEN','MATHS',77),('ALLEN','HINDI',67),('ALLEN','ENGLISH',76),
       ('JOHN','SECINCE',67),('JOHN','MATHS',77),('JOHN','HINDI',56),('JOHN','ENGLISH',81),
	   ('ANNU','SECINCE',58),('ANNU','MATHS',77),('ANNU','HINDI',57),('ANNU','ENGLISH',58),
	   ('LILLY','SECINCE',75),('LILLY','MATHS',63),('LILLY','HINDI',59),('LILLY','ENGLISH',76)
 

 SELECT * FROM XAMRESULT

 SELECT NAME,SUBJECT,MARKS, ROW_NUMBER()OVER(ORDER BY NAME) ROWNUMBER
 FROM XAMRESULT

 SELECT NAME,SUBJECT,MARKS,RANK()OVER( ORDER BY MARKS) ROWNUMBER
 FROM XAMRESULT

 SELECT NAME,SUBJECT,MARKS,DENSE_RANK()OVER( ORDER BY MARKS) ROWNUMBER
 FROM XAMRESULT

 SELECT NAME,SUBJECT,MARKS,NTILE(6) OVER(ORDER BY MARKS)
 FROM XAMRESULT


 SELECT * FROM EMP
 SELECT NAME,BRANCH,GENDER,AGE,RANK() OVER(PARTITION BY GENDER ORDER BY NAME)
 FROM EMP