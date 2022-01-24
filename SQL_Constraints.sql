--Constraints are nothing but applying rules and regulations to the columns in table.
--Different types of constraints are:
--Default : Use to insert default value to a column when user doesn't specify a value .
--Unique Key : Used to avoid duplicate values but accept single Null value in a columns.
--Primary Key : Doesn't allow any Null as well as Duplicate values in a column.Unique + NotNull = Primary Key
--Foreign Key: Used to create relationship between to tables.
--Not Null : Used to not accept Null values to the Columns.
--Check : Ensures that the values in a column satisfies a specific condition.

=======================================================================================
--Creating Table Using Constraints
If exists (SELECT 1 FROM SYS.TABLES WHERE NAME = 'GENDER')
 DROP TABLE GENDER
 GO 
   
CREATE TABLE GENDER(
ID INT PRIMARY KEY,
NAME VARCHAR(6))

INSERT INTO GENDER(ID,NAME)
VALUES(1,'MALE'),(2,'FEMALE')



If exists(SELECT 1 FROM SYS.TABLES WHERE NAME = 'Employee_Details')
  Drop table Employee_Details
GO

CREATE TABLE Employee_Details(
ID INT PRIMARY KEY,
NAME VARCHAR(20) NOT NULL,
AGE INT CHECK (AGE>18),
GENDERID INT FOREIGN KEY REFERENCES GENDER(ID),
MAIL VARCHAR(40) UNIQUE,
JOINED_DATE DATETIME DEFAULT GETDATE()
)

INSERT INTO Employee_Details(ID,NAME,AGE,GENDERID,MAIL,JOINED_DATE)
VALUES(1,'Ram',19,1,'ram@gmail.com','12-12-2021')

INSERT INTO Employee_Details(ID,NAME,AGE,GENDERID,MAIL)
VALUES(2,'Suman',21,2,'suman@gmail.com')

INSERT INTO Employee_Details(ID,NAME,AGE,GENDERID,MAIL,JOINED_DATE)
VALUES(3,'Deep',23,1,'dee12@hotmail.com','12-09-2018')

INSERT INTO Employee_Details(ID,NAME,AGE,GENDERID,MAIL)
VALUES (4,'Aadu',24,2,'addu345@yahoo.com')

INSERT INTO Employee_Details(ID,NAME,AGE,GENDERID,MAIL)
VALUES(5,'Shimpe',31,null,'shimoeee@gmail.com')

SELECT * FROM Employee_Details
SELECT * FROM GENDER

if not exists(select 1 from sys.tables where name = 'Employee_Details')
Begin
  CREATE TABLE Employee_Details_123(
  ID INT PRIMARY KEY,
  NAME VARCHAR(10) NOT NULL,
  AGE INT CHECK(AGE>10),
  MAIL VARCHAR(20) UNIQUE,
  GENDER VARCHAR(6),
  JOINING_DATE DATETIME DEFAULT GETDATE()
  )
END

SELECT * FROM Employee_Details
