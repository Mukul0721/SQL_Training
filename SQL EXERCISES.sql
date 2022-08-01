USE TSQL2012
GO
If exists(Select 1 from Sys.tables Where Name = 'EmployeeDetails1')
 Drop Table EmployeeDetails1

 Create Table EmployeeDetails1(
 Empid Int,
 FullName Varchar(30),
 Managerid Int,
 DateofJoining Date,
 City Varchar(20)
 )

Insert Into EmployeeDetails1(Empid,FullName,Managerid,DateofJoining,City)
Values(1,'John Snow',12,'2014/01/23','Toronto'),(2,'Walter White',04,'2015/04/24','California'),
      (3,'Ankit Jain',08,'2016/07/21','New Delhi'),(4,'Anamika Roy',09,'2018/11/24','Hyderabad')

If exists (Select 1 From sys.tables Where Name  = 'EmployeeSalary')
  Drop Table EmployeeSalary

  Create Table EmployeeSalary(
   EmpId Int,
   Project Varchar(20),
   Salary Int,
   Variable Int
   )

   Insert into EmployeeSalary(EmpId,Project,Salary,Variable)
    values(01,'P1',15000,5000),(02,'P2',16000,6000),(03,'P3',18000,3000),(04,'P2',18000,000),(05,'P1',20000,1000)
	Insert Into EmployeeDetails1
	Select 6,'Ramesh Chaudhary',07,'2019/12/21','Banglore'
Select * from EmployeeDetails1
Select * From EmployeeSalary

--1.SQL Query to fetch records that are present in one table but not in another table.
   Select * From EmployeeDetails1 Where Empid Not In(Select Empid From EmployeeSalary)

   Select * From EmployeeDetails1 Ed
   Left Join EmployeeSalary Es
   ON Ed.Empid = Es.EmpId
--2.SQL query to fetch all the employees who are not working on any project.
    Select * From EmployeeSalary
	Where Project IS Null

--3.SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.
    Select * From EmployeeDetails1
	Where DateofJoining Between '2020/01/01' And '2020/12/31'
--4.Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
    Select * From EmployeeDetails1 Ed Where Exists (Select * From EmployeeSalary Es Where Ed.Empid = Es.EmpId )
--5.Write an SQL query to fetch project-wise count of employees.
    Select Project,Count(Empid) as EmpProject From EmployeeSalary
	Group By Project
	Order By EmpProject DESC
--6.Fetch employee names and salary even if the salary value is not present for the employee.
    Select E.FullName,S.Salary From EmployeeDetails1 E
	Left join EmployeeSalary S
	On E.Empid = S.EmpId

--7.Write an SQL query to fetch all the Employees who are also managers.
    Select Distinct E.FullName From EmployeeDetails1 E
	Inner Join EmployeeDetails1 M
	On E.Empid = M.Empid
--8.Write an SQL query to fetch duplicate records from EmployeeDetails.

   SELECT FullName, ManagerId, DateOfJoining, City, COUNT(*)
   FROM EmployeeDetails1
   GROUP BY FullName, ManagerId, DateOfJoining, City
   HAVING COUNT(*) > 1;
--9.Write an SQL query to fetch only odd rows from the table.

  Select Empid,project,Salary,ROW_NUMBER()Over(Order by EmpId) As RowNumber From EmployeeSalary

  SELECT E.EmpId, E.Project, E.Salary
  FROM (
    SELECT *, Row_Number() OVER(ORDER BY EmpId) AS RowNumber
    FROM EmployeeSalary
     ) E
  WHERE E.RowNumber % 2 = 1;
--10.Write a query to find the 3rd highest salary from a table without top or limit keyword.
    Select Salary From EmployeeSalary Emp1 
	  Where 2 = (Select Count (Distinct(Emp2.salary))
	  From EmployeeSalary Emp2 Where Emp2.Salary > Emp1.Salary)

--11. Write an SQL query to fetch the EmpId and FullName of all the employees working under Manager with id – ‘07’.
      Select EmpId,FullName From EmployeeDetails1
	  Where Managerid = 07
--12. Write an SQL query to fetch the different projects available from the EmployeeSalary table.
      Select Distinct Project From EmployeeSalary
--13. Write an SQL query to fetch the count of employees working in project ‘P1’.
      Select Count(*) From EmployeeSalary
	  Where Project  = 'P1'
--14. Write an SQL query to find the maximum, minimum, and average salary of the employees.
      Select Max(Salary) mx,
	         Min(Salary)mn,
			 Avg(Salary)av
      From EmployeeSalary
--15. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.
      Select EmpId,Salary From EmployeeSalary
	  Where Salary Between 9000 and 15000. 
--16. Write an SQL query to fetch those employees who live in Toronto and work under manager with ManagerId –12 .
      Select Empid,FullName From EmployeeDetails1
	  Where City = 'Toronto' And ManagerId = 12
--17. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 07.
      Select Empid,Fullname From EmployeeDetails1
	  Where City = 'California' Or Managerid  = 07
--18. Write an SQL query to fetch all those employees who work on Project other than P1.
      Select * From EmployeeSalary Where Not Project = 'P1'
--19. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.
      Select Empid,Salary+variable As VabSal From EmployeeSalary
--20. Ques.10. Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and
--    ending with any sequence of characters.
      Select Empid,FullName From EmployeeDetails1
	  Where FullName Like '_hn%'
--21. Write an SQL query to fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’.
      Select EmpId From EmployeeDetails1
	  Union
	  Select Empid From EmployeeSalary
--22. Write an SQL query to fetch common records between two tables.
      Select * from EmployeeDetails1
	  Intersect
	  Select * from EmployeeSalary
--23. Write an SQL query to fetch records that are present in one table but not in another table.
      Select * From EmployeeDetails1 Ed
	  Left Join EmployeeSalary Es
	  On Ed.Empid = Es.EmpId

	  Select * from EmployeeDetails1
	  Minus
	  Select * from EmployeeSalary
--24. Write an SQL query to fetch the EmpIds that are present in both the tables –   ‘EmployeeDetails’ and ‘EmployeeSalary.
      Select * from EmployeeDetails1 Where empId in(Select EmpId from EmployeeSalary)
--25. Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary.
      Select * From EmployeeDetails1 Where Empid Not In(Select EmpId From EmployeeSalary)
--26. Write an SQL query to fetch the employee full names and replace the space with ‘-’.
      SELECT REPLACE(FullName,' ','-')
      FROM EmployeeDetails1;
--27. Write an SQL query to fetch the position of a given character(s) in a field.
      SELECT CHARINDEX('Snow',FullName)
      FROM EmployeeDetails1;
--28. Write an SQL query to display both the EmpId and ManagerId together.
      Select CONCAT(Empid,ManagerId)as New_Id
	  From EmployeeDetails1
--29. Write a query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table.
      Select SUBSTRING(Fullname,1,Charindex(' ' ,FullName)) From EmployeeDetails1
--30. Write an SQL query to upper case the name of the employee and lower case the city values.
      Select Upper(FullName),LOWER(City) From EmployeeDetails1
--31. Write an SQL query to find the count of the total occurrences of a particular character – ‘n’ in the FullName field.
      Select Fullname, Len(FullName)-Len(Replace(Fullname,'n','')) From EmployeeDetails1
--32. Write an SQL query to update the employee names by removing leading and trailing spaces.
      Update EmployeeDetails1
	  Set FullName = LTRIM(RTRIM(FullName))
	 
--33. Fetch all the employees who are not working on any project.
      Select * From EmployeeSalary
	  Where Project is Null
--34. Write an SQL query to fetch employee names having a salary greater than or equal to 15000 and less than or equal to 18000.
      Select EmpId,FullName From EmployeeDetails1
	  Where Empid IN(Select Empid From EmployeeSalary Where Salary Between 15000 And 18000)
--35. Write an SQL query to find the current date-time.
      Select GETDATE()
--36. Write an SQL query to fetch all the Employees details from EmployeeDetails table who joined in the Year 2020.
      Select * From EmployeeDetails1
	  Where DateofJoining Between '2020/01/01'And '2020/12/31'
--37. Write an SQL query to fetch all employee records from EmployeeDetails table who have a salary record in EmployeeSalary table.
      Select * From EmployeeDetails1 ED
	  Where Exists
	  (Select * from EmployeeSalary ES Where ED.Empid = Es.EmpId)
--38. Write an SQL query to fetch project-wise count of employees sorted by project’s count in descending order.
      Select Project,Count(Empid)as EmpCont
	  From EmployeeSalary
	  Group by Project
	  Order by EmpCont DESC

--39. Write a query to fetch employee names and salary records. Display the employee details even if the salary record is 
--    not present for the employee.
      Select * From EmployeeDetails1 Ed
	  Left Join EmployeeSalary Es
	  On Ed.Empid = Es.EmpId
      
--40. Write an SQL query to join 3 tables.
      Select Colmn1,Colmn2
	  From tableA
	  Join TableB On TableA.Colmn3 = TableB.Colmn3
	  Join TableC on TableA.Colmn4 = TableC.Colmn4

      
--===================================
Select CONCAT('Paradigm',' IT ',2)

Select len('Fullname') From EmployeeDetails1
Select FullName from EmployeeDetails1

SELECT FullName, 
LEN(FullName) - LEN(REPLACE(FullName, 'n', ''))
FROM EmployeeDetails1;

--==========================
Select 1a
Select A = 15
Select sp_primarykeys 
Select (1/2)*10


CREATE TABLE COUNTRY
(CID INT PRIMARY KEY,
CNAME VARCHAR(200)
)
INSERT INTO COUNTRY VALUES(1,'RAFI'),(2,'MUKUL'),(3,'RAMYA'),(4,'KIRAN'),(5,'BALA'),
(6,'SAIRAM'),(7,'MADHAV'),(8,'VIJAY'),(9,'MUKESH'),(10,'RAM')

CREATE TABLE PRODUCT
(
PID INT PRIMARY KEY,
PNAME VARCHAR(200),
CID INT FOREIGN KEY REFERENCES COUNTRY(CID)
)
INSERT INTO PRODUCT VALUES(1,'Adjustable Race',1),(2,'Bearing Ball',2),(3,'BB Ball Bearing',3),
(4,'Headset Ball Bearings',4),(5,'Blade',5),(6,'LL Crankarm',6),(7,'ML Crankarm',7),
(8,'HL Crankarm',8),(9,'Chainring Bolts',9),(10,'Chainring Nut',10)

Select * From COUNTRY
Select * From PRODUCT

declare @output table 
(cid int,
pid int
)

declare @s int ,
        @e int
set @s=1
set @e=1
while (@s=@s and @e<=10)
begin
insert into @output (pid,cid)
select pid,COUNTRY.CID  from product,COUNTRY 
where pid=@s and country.cid in (select country.cid from COUNTRY where country.CID>=@e)
set @s=@s+1
set @e=@e+1
end
select * from  @output

Select * from EMPLOYEE

Create Trigger tr_Employeeinsert
On EMPLOYEE
For Insert
As
Begin
 Declare @Employee_Id int 
 Select @Employee_Id = Employee_Id From Inserted

 Insert Into EMPLOYEE
 Values('New Employee_Id  =' Cast(@Employee_Id  as Varchar(10))+'is added with date'+cast(getdate()as varchar(40)))

End
 

 Create Trigger tr_Employeetbl
 On Employee
 For Insert 
 As
 begin 
  Print 'New Employee_Id Inserted'
End

Insert Into EMPLOYEE
Select 16,'Ramu','Ram',25000,'2022/04/21','Reports'

--To Disable Trigger Will use following Command
DISABLE Trigger tr_Employeetbl On EMPLOYEE
--To Enable Will Use Enable Keyword


--Stored Procedure Useing Output
Create Procedure csp_countbyEmployee
(
  @Employee_id int Output
  )
As
Begin
  Select @Employee_id = Count(Employee_id) From EMPLOYEE
End

DECLARE @EID INT
SET @EID=0
EXEC csp_countbyEmployee
@Employee_id=@EID

--=========================
Select * From Employees
Create PROCEDURE countEmployee (@EmployeeCount INT OUTPUT)  
AS  
BEGIN  
    SELECT @EmployeeCount = COUNT(Id)FROM Employees;  
END;  

-- Declare an Int Variable that corresponds to the Output parameter in SP  
DECLARE @TotalEmployee INT   
  
-- Don't forget to use the keyword OUTPUT  
EXEC  [dbo].[countEmployee] @TotalEmployee OUTPUT  
  
-- Print the result  
Select  @TotalEmployee   

--=========================
Select * From empl1
Select * From dept1

Select * From empl1 e
left join dept1 d
on e.EMPID = d.DeptID

Select * from empl1 where DeptID not in(Select DeptID from dept1)
 

Create Table #Employee
( Id Int Identity(1,1),
  Name varchar(20),
  Salary Int
  )

INSERT INTO #Employee VALUES ('Rick', 3000);
INSERT INTO #Employee VALUES ('John', 4000);
INSERT INTO #Employee VALUES ('Shane', 3000);
INSERT INTO #Employee VALUES ('Peter', 5000);
INSERT INTO #Employee VALUES ('Jackob', 7000);
INSERT INTO #Employee VALUES ('Sid', 1000);

Select * From #Employee

Select *,ROW_NUMBER()Over(Order by Salary Desc) Row_Number From #Employee
--Row_number gives contineous number for duplicate values .
Select*,RANK()Over(Order by Salary Desc) Rank From #Employee
--Rank gives same number for duplicate values but it skips the next contineous number.
Select *,DENSE_RANK()Over(Order by Salary Desc) Dense_Rank From #Employee
--Dense_Rank gives gives same number for duplicate values but it doesn't skip the next number.

Declare @#startpoint int, 
        @#endpoint int,
		@#Id int,
		@#Name varchar(30),
		@#Salary Int

Set @#startpoint = (Select Min(Id) From #Employee)
Set @#endpoint =   (Select MAX(id) from #Employee)

While (@#startpoint <= @#endpoint)
Begin
   Select @#Id = Id From #Employee Where Id = @#startpoint
   Select @#Name = Name From #Employee Where Id = @#startpoint
   Select @#Salary = Salary From #Employee Where Salary = @#startpoint
   Print 'My Id is'+Cast(@#Id as Varchar(20))+' and my Name is'+@#Name+' having Salary'+Cast(@#Salary as Varchar(20))
    
	Set @#startpoint = @#startpoint + 1
End
--=======

Select STUFF('Paradigm Information And Technology',9,34,'IT')
CREATE OR ALTER PROCEDURE Sp_outputparameters_Production
(
@listprice        FLOAT,
@productcount    INT OUTPUT
)
AS
BEGIN 
   SELECT * FROM Production.Product
   WHERE ListPrice<@listprice

   SELECT @productcount=@@ROWCOUNT
END

DECLARE @count int
EXEC Sp_outputparameters_Production
@listprice    =34.20,
@productcount=@count OUTPUT


CREATE TABLE EMP
( E_ID INT PRIMARY KEY ,
  NAME VARCHAR(20),
  SALARY INT,
  DEPTID INT 
)

INSERT INTO EMP(E_ID,NAME,SALARY,DEPTID)
VALUES(1,'VINAY',20000,1),(2,'RAM',23000,2),(3,'SAI',24000,3),(4,'VIMAL',18000,4),(5,'RAFI',23000,2),(6,'RAMU',25000,4),
      (7,'ABHISHEK',26000,1)

CREATE TABLE DEPT(ID INT PRIMARY KEY,DEPTNAME VARCHAR(30),DEPTID INT,
   E_ID INT FOREIGN KEY REFERENCES EMP(E_ID)
    )

INSERT INTO DEPT
VALUES(1,'IT',1,1),(2,'CS',2,2),(3,'RPT',3,3),(4,'IT',1,4),(5,'CS',2,5),(6,'HR',4,6),(7,'RPT',3,7)


SELECT * FROM EMP
SELECT * FROM DEPT
 
 SELECT*FROM EMP WHERE DEPTID IN(SELECT DEPTID FROM DEPT)

