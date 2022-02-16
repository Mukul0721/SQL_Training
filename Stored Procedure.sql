Stored Procedures are created to perform one or more DML operations on Database.
It is nothing but the group of SQL statements that accepts some input in the form of parameters
and performs some task and may or may not returns a value. 

TYPES OF STORED PROCEDURE ARE :
  1) SIMPLE PROCEDURE WITHOUT PARAMETERS
  2) STORED PROCEDURE WITH PARAMETERS
  3) STORED PROCEDURE WITH OPTIONAL PARAMETERS
  --=========================================================
  1) CREATING STORED PROCEDURE WITHOUT PARAMETERS
   
    CREATE PROCEDURE usp_getcustomerdetails
	AS
	BEGIN
	  
	  SELECT * FROM Sales.Customers
    
	END

	EXECUTE usp_getcustomerdetails
	
	SELECT * FROM Production.Categories
	SELECT * FROM Production.Products
2) CREATING PROCEDURE WITH PARAMETERS

   CREATE PROCEDURE usp_getproductdetailsbycatogries
   (
   @categoryid int,
   @unitprice int
   )
   AS
   BEGIN

   SELECT * FROM Production.Products
   WHERE categoryid = @categoryid
   AND unitprice >= @unitprice

   END

   EXEC usp_getproductdetailsbycatogries @categoryid =1,@unitprice = 18

--=============================================
SELECT * FROM Production.Suppliers
CREATE PROCEDURE udp_GetSUPPLIERSdetails
(
@city varchar(100)
)
AS
BEGIN
  SELECT * FROM Production.Suppliers
  WHERE city =@city
END

EXEC udp_GetSUPPLIERSdetails @city = 'London' 
--==================================================================
3) CREATING PROCEDURE WITH OPTIONAL PARAMETERS

CREATE PROCEDURE usp_getdetailswithoptional
(
 @empid int,
 @firstname varchar(100),
 @title varchar(100) = null
)
AS
BEGIN
 SELECT * FROM HR.Employees
 WHERE empid = @empid
 AND  firstname = @firstname
 AND (title = @title or @title IS NULL)
END

EXEC  usp_getdetailswithoptional @empid= 1,@firstname = 'Sara'

--=====================================================================
