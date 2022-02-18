
Create Procedure csp_CustomerBankTransactions
(
		@CustomerName Varchar(100)
		,@ActionType Varchar(100)
		,@Amount Decimal (10,2)
		,@Gender Varchar(10)
)
AS
Begin


	If @ActionType = 'Account Creation'
	Begin
	
			If exists (Select * from Customers where CustomerName = @CustomerName )
			Begin
		
				Select 'Customer Already exists'

			End
			Else
			Begin
				Insert into Customers (CustomerName, Gender, Balance)
				Select @CustomerName,@Gender,@Amount

				Update BANK_ACCOUNT
				Set Totalbalance = TotalBalance + @Amount

			End

	End
	IF @ActionType = 'Deposit'
	Begin
	
		if exists (Select * from Customers where CustomerName = @CustomerName)
		Begin
		
			Update Customers
			Set Balance = Balance + @Amount
			where CustomerName = @CustomerName

			Update BANK_ACCOUNT
			Set TotalBalance = TotalBalance + @Amount

		End
		else
		Begin
			Select 'Customer does not exists'
		End

	End
	IF @ActionType = 'Withdraw'
	Begin
	
		if exists (Select * from Customers where CustomerName = @CustomerName)
		Begin
		
			if (Select sum(balance) from Customers where CustomerName = @CustomerName) < @Amount
			Begin
			
				Select 'Customer has insufficient funds'

			End
			Else
			Begin

				Update Customers
				Set Balance = Balance - @Amount
				where CustomerName = @CustomerName

				Update BANK_ACCOUNT
				Set TotalBalance = TotalBalance - @Amount
		
			End

		End
		else
		Begin
			Select 'Customer does not exists'
		End

	End


End

go
EXEC csp_CustomerBankTransactions
         @CustomerName = 'MUKUL'
		,@ActionType = 'WITHDRAW'
		,@Amount  = 3000
		,@Gender = 'MALE'

SELECT * FROM Customers