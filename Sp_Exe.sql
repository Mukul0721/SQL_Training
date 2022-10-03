Use TSQL2012
Go
Select *  From  EMPLOYEE
Alter Procedure csp_empdtls12
( @ID int,
  @Salary Float = Null
  )
  As
  Begin 
   Select First_Name,Last_Name,Department
   From EMPLOYEE
   Where   EMPLOYEE_ID = @ID
   And  SALARY  = @Salary OR @Salary is Null

   End

EXECUTE csp_empdtls12 2,80000.00

--Deleting Records Using SP
Create Procedure Csp_deleteemp
( @Employee_Id Int
) 
AS
Begin
--IF Exists (select * from EMPLOYEE Where EMPLOYEE_ID = @Employee_Id)
 Delete From EMPLOYEE
 Where EMPLOYEE_ID = @Employee_Id
-- ELSE
 If @@ERROR <>
 Raiserror('Employee ID does not Exists',16,1)
End

Execute Csp_deleteemp 19
--Calling lastname using sp
Alter Proc csp_emplastname
 ( @EMPLOYEE_ID INT,
   @Last_Name Varchar(20) = Null
 ) 
 AS
 BEGIN
  Select Last_Name from EMPLOYEE
  Where EMPLOYEE_ID = @EMPLOYEE_ID
  And LAST_NAME  = @Last_Name Or @Last_Name IS Null
 End

 Execute csp_emplastname 4
 --OR
 Alter Procedure csp_emplastnm
 ( @Employee_ID INT
 )
 AS
 BEGIN
  Select first_name+last_Name as Full_Name From EMPLOYEE
  Where EMPLOYEE_ID = @Employee_ID
 End

 Execute csp_emplastnm 7

 CREATE PROCEDURE usp_GetLastName @EmployeeID int
AS
SELECT Last_Name 
FROM EMPLOYEE  
WHERE Employee_ID = @EmployeeID   
IF @@error <> 0 
BEGIN     
RAISERROR ('Error Occurred', 16, 1) 
RETURN 1  
END 
ELSE 
RETURN 0
 Exec usp_GetLastName 3

 --Sp using multiple argument 
 Alter Proc csp_NameEmployee
 ( @Employee_IdFrom Int,@Employee_IDTo Int
 )
 AS
 BEGIN
  If Exists (Select * from EMPLOYEE where EMPLOYEE_ID Between @Employee_IdFrom and @Employee_IDTo)
  Begin
   Select First_Name,Last_Name,Department,Salary
   From EMPLOYEE
   Where EMPLOYEE_ID Between @Employee_IdFrom and @Employee_IDTo
   Order by SALARY DESC
  End

  Else 
   Print 'Employee Id Doesnot exists'
End

Execute csp_NameEmployee 10,12
---Procedure Using While Loop
Create Procedure usp_EmployeeName
( @Employee_idFrom Int,@Employee_idTo Int
)
As
Begin
 IF Exists(Select * from EMPLOYEE Where EMPLOYEE_ID BEtween @Employee_IdFrom and @Employee_IDTo)
 Begin
  Declare @EmployeeNumber Int = @Employee_IDFrom
  While @EmployeeNumber <= @Employee_IDTo
  Begin
    If Exists(Select * from EMPLOYEE Where EMPLOYEE_ID = @EmployeeNumber)
    Select First_Name,Last_Name,Department,Salary
	From EMPLOYEE
	Where EMPLOYEE_ID = @EmployeeNumber
	Set @EmployeeNumber = @EmployeeNumber + 1
  End
 End
End

Execute  usp_EmployeeName 5,15

create proc NameEmployees(@EmployeeNumberFrom int, @EmployeeNumberTo int, @NumberOfRows int) as
begin
    select Employee_ID, First_Name,Last_Name
    from Employee
    where EMPLOYEE_ID between @EmployeeNumberFrom and @EmployeeNumberTo
    SET @NumberOfRows = @@ROWCOUNT
end
go
DECLARE @NumberRows int, @ReturnStatus int
EXEC @ReturnStatus = NameEmployees 2,16, @NumberRows
SELECT @NumberRows


Alter Procedure usp_GetName
( @EmployeeID Int,
  @EmployeeStatus Int OUTPUT
)
AS
Begin
  Select LASTNAME From Employees
  Where ID =  @EmployeeId
  And EmpSalary = @EmployeeStatus
End 
 
 Declare @EmployeeStatus Int
Execute usp_GetName 7,@EmployeeStatus output
Print @EmployeeStatus

Select * from Employees

Create PROCEDURE usp_Getsalary 
   @empId int,  
   @EmpSalary int OUTPUT  
AS  
BEGIN  
   SELECT FirstName,LastName
   FROM dbo.Employees
   WHERE ID = @empId  
   And EmpSalary = @EmpSalary  
END

 Declare @Empsalary Int
 Execute uspGetsalary 6, @EmpSalary output
 Print @Empsalary