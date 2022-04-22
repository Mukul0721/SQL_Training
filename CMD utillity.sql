
*/
 -- this turns on advanced options and is needed to configure xp_cmdshell
EXEC sp_configure 'show advanced options', '1'
RECONFIGURE
-- this enables xp_cmdshell
EXEC sp_configure 'xp_cmdshell', '1' 
RECONFIGURE

SELECT * FROM HumanResources.Employee

EXEC master..xp_cmdshell 'BCP AdventureWorks2019.HumanResources.Employee OUT "C:\BCP_Demo.txt" -T -c'

--CMD
C:\WINDOWS\System32>BCP [AdventureWorks2014].[dbo].[SalesOrderDetail] out C:\BCP_DEMO.txt -S NAVEEN-PC\SQLDBDEV -T -c –b1000 –t,

C:\WINDOWS\System32>BCP [adventureworks2014].dbo.[SalesOrderDetail_Copy] in C:\BCP_DEMO.txt -S NAVEEN-PC\SQLDBDEV -T –c

EXEC master..xp_cmdshell 'BCP "SELECT [SalesOrderID], [SalesOrderDetailID],[CarrierTrackingNumber] FROM
[AdventureWorks2019].[dbo].[SalesOrderDetail]" queryout "C:\BCP_DEMO.txt" -S NAVEEN-PC\SQLDBDEV -T' -- –c'

