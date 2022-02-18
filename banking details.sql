SELECT * FROM Customers
SELECT * FROM BANK_ACCOUNT


go


DECLARE @CustomerName VARCHAR(100)
       ,@ActionType VARCHAR(100)
	   ,@Balance DECIMAL(10,2)
	   ,@Gender VARCHAR(10)

SET @CustomerName = 'Mukul'
SET @ActionType = 'ACCOUNT CREATION'
SET @Balance = 25000
SET @Gender = 'MALE'

IF @ActionType = 'ACCOUNT CREATION'
BEGIN
   IF EXISTS(SELECT * FROM Customers WHERE CustomerName = 'Mukul')
   BEGIN
     SELECT 'ACCOUNT ALLREADY CREATED'
   END	 
   ELSE
   BEGIN
     INSERT INTO Customers(CustomerName,Gender,Balance)
	 SELECT @CustomerName,@Gender,@Balance

	 UPDATE BANK_ACCOUNT
	 SET Totalbalance = Totalbalance + @Balance

   END  
   
END

IF @ActionType = 'DEPOSIT'
BEGIN
  IF EXISTS(SELECT * FROM Customers WHERE CustomerName = @CustomerName)
  BEGIN
    UPDATE Customers
	SET Balance = Balance + @Balance
	WHERE CustomerName = @CustomerName
	
	UPDATE BANK_ACCOUNT
	SET Totalbalance = Totalbalance + @Balance
   END
   ELSE 
   BEGIN
    SELECT 'CUSTOMER DOESNOT EXIST'
   END
END


IF @ActionType = 'WITHDRAW'
BEGIN
 IF EXISTS(SELECT * FROM Customers WHERE CustomerName = @CustomerName)
 BEGIN
	   IF (SELECT SUM(Balance) FROM Customers WHERE CustomerName = @CustomerName) < @Balance
	   BEGIN
		 SELECT 'INSUFFICIENT AMOUNT'
	   END
	   ELSE
	   BEGIN
		 UPDATE Customers
		 SET Balance = Balance - @Balance
		 WHERE CustomerName = @CustomerName 

		 UPDATE BANK_ACCOUNT
		 SET Totalbalance = Totalbalance - @Balance
	   END
	

 END
