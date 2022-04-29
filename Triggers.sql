TRIGGER IN SQL is a special type of stored procedure that automatically runs when an event occurs in database server.DML trigger
  runs when a user tries to modify data through a data manuplation language(DML) event.
  DML TRIGGERS
      AFTER TRIGGERS
	  INSTEAD TRIGGERS
  DDL TRIGGERS
  LOGON TRIGGERS
  DML TRIGGERS ARE : INSERT
                     UPDATE
					 DELETE


CREATE TABLE Employee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)


Insert into Employee values (1,'John', 5000, 'Male', 3)
Insert into Employee values (2,'Mike', 3400, 'Male', 2)
Insert into Employee values (3,'Pam', 6000, 'Female', 1)

CREATE TABLE EmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)
--INSERT TRIGGER
ALTER TRIGGER tr_Employee_ForInsert
ON Employee
FOR INSERT
AS
BEGIN
 DECLARE @Id int
 SELECT @Id = Id FROM INSERTED

 INSERT INTO EmployeeAudit
 VALUES('NEW EMPLOYEE WITH ID = ' + CAST(@Id AS VARCHAR(10)) + ' IS ADDED AT ' + CAST(GETDATE() AS VARCHAR(20)))

END
INSERT INTO Employee values(4,'Rani',4500,'Female',3)
INSERT INTO Employee values(5,'Anni',4800,'Female',1)
INSERT INTO Employee values(6,'Nannu',4800,'male',2)
INSERT INTO Employee values(7,'Anil',5400,'male',1)
DELETE FROM EmployeeAudit
WHERE Id = 12
SELECT * FROM Employee
SELECT * FROM EmployeeAudit

ALTER TRIGGER tr_Employee_Fordelete
ON Employee
FOR DELETE
AS
BEGIN
  DECLARE @Id INT
  SELECT @Id = Id FROM DELETED

  INSERT INTO EmployeeAudit
  VALUES ('EMPLOYEE WITH ID = ' + CAST(@Id AS VARCHAR(20)) + ' IS DELETED AT ' + CAST(GETDATE() AS VARCHAR(20))) 

END

INSERT INTO Employee(
DELETE FROM EmployeeAudit
WHERE ID = 4
SELECT * FROM EmployeeAudit

DROP TABLE Employee
DROP TABLE EmployeeAudit

DROP TRIGGER tr_Employee_ForInsert

Create trigger tr_Employee_ForUpdate
on Employee
for Update
as
Begin
      -- Declare variables to hold old and updated data
      Declare @Id int
      Declare @OldName nvarchar(20), @NewName nvarchar(20)
      Declare @OldSalary int, @NewSalary int
      Declare @OldGender nvarchar(20), @NewGender nvarchar(20)
      Declare @OldDeptId int, @NewDeptId int
     
      -- Variable to build the audit string
      Declare @AuditString nvarchar(1000)
      
      -- Load the updated records into temporary table
      Select *
      into #TempTable
      from inserted
     
      -- Loop thru the records in temp table
      While(Exists(Select Id from #TempTable))
      Begin
            --Initialize the audit string to empty string
            Set @AuditString = ''
		
            -- Select first row data from temp table
            Select Top 1 @Id = Id, @NewName = Name, 
            @NewGender = Gender, @NewSalary = Salary,
            @NewDeptId = DepartmentId
            from #TempTable
           
            -- Select the corresponding row from deleted table
            Select @OldName = Name, @OldGender = Gender, 
            @OldSalary = Salary, @OldDeptId = DepartmentId
            from deleted where Id = @Id
   
     -- Build the audit string dynamically           
            Set @AuditString = 'Employee with Id = ' + Cast(@Id as nvarchar(4)) + ' changed'
            if(@OldName <> @NewName)
                  Set @AuditString = @AuditString + ' NAME from ' + @OldName + ' to ' + @NewName
                 
            if(@OldGender <> @NewGender)
                  Set @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender
                 
            if(@OldSalary <> @NewSalary)
                  Set @AuditString = @AuditString + ' SALARY from ' + Cast(@OldSalary as nvarchar(10))+ ' to ' + Cast(@NewSalary as nvarchar(10))
                  
     if(@OldDeptId <> @NewDeptId)
                  Set @AuditString = @AuditString + ' DepartmentId from ' + Cast(@OldDeptId as nvarchar(10))+ ' to ' + Cast(@NewDeptId as nvarchar(10))
           
            insert into EmployeeAudit values(@AuditString)
            
            -- Delete the row from temp table, so we can move to the next row
            Delete from #TempTable where Id = @Id
      End
End 