CREATE DATABASE SQL_Training

========================================= 

 SQL-data-types
==============

1) Numeric Data Types
	bit		(0-1)
	tinyint	(0-255)
	smallint(-32,768	32,767)
	int		(-2,147,483,648	2,147,483,647)
	bigint	(-9,223,372,036, 854,775,808	9,223,372,036, 854,775,807)
	decimal	(-10^38 +1	10^38 -1)
	
2) Date and Time Data Types
	Date
	Time
	DateTime
	
3) Character and String Data Types
	CHAR -- fixed lenth
	VARCHAR -- varchar(100)
	VARCHAR(max)	
	TEXT
	NCHAR
	NVARCHAR
	NVARCHAR(max)
	NTEXT

Working with Tables & Insert
=============================
1) Creating/drop Tables



if exists (Select 1 from sys.tables where name = 'Students')
	drop table Students

go

Create table Students
(
	StudentID int,
	Name Varchar(50),
	Gender Varchar(6),
	Age tinyint,
	Fee Decimal (10,2),
	JoinedDate Datetime,
	IsStudentActive bit
)

 if not exists (Select * from sys.tables where name = 'Students_Mukul')
Begin
	Select 'Creating table'

	Create table Students_Mukul
	(
		StudentID int,
		Name Varchar(50),
		Gender Varchar(6),
		Age tinyint,
		Fee Decimal (10,2),
		JoinedDate Datetime,
		IsStudentActive bit
	)
End

SELECT * FROM Students
SELECT * FROM Students_Mukul
