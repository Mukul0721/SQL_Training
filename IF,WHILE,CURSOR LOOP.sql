--CONDITIONAL AND CENTROL STATEMENT

IF CONDITION IS USED WHEN WE WANT TO CHECK ANYTHING AT ONCE.

CURSORS ARE USED WHEN WE THERE IS GAPS IN DATA LIKE OR THE ROWS ARE NOT IN SEQUENCE.

WHILE CONDITION IS USED WHEN WE WANT TO CHECK ANYTHING FOR MULTIPLE TIME.
WHILE LOOP IS DONE IN THREE STEPS
 * INITIALIZATION
 * CONDITION
 * INCRIMENT


--TO CHECK GIVEN NUMBER IS EVEN OR ODD

DECLARE @NUMBER INT
SET @NUMBER = 5
IF(@NUMBER % 2 = 0)
BEGIN
   PRINT 'GIVEN NUMBER IS EVEN'
END 
ELSE 
 BEGIN 
   PRINT 'GIVEN NUMBER IS ODD'
END

=======================================
DECLARE @NUMBER INT
SET @NUMBER = 8
IF (@NUMBER % 2 = 0)
BEGIN
  PRINT'GIVEN NUMBER IS EVEN'
END
ELSE
BEGIN
  PRINT 'GIVEN NUMBER IS ODD'
END
========================================
--PRINT NUMBER FROM 1 TO 100
DECLARE @START INT
SET @START = 1
WHILE(@START <= 100)
BEGIN 
 PRINT @START
 SET @START =@START + 1
END
==========================================
--PRINT NUMBER FROM 100 TO 1
DECLARE @START INT
SET @START = 100
WHILE(@START >= 1)
BEGIN
 PRINT @START
 SET @START = @START - 1
END
==============================
--PRINT NUMBER 

DECLARE @NUMBER INT
SET @NUMBER = 5
IF(@NUMBER % 2 = 0)
BEGIN
   PRINT 'GIVEN NUMBER IS EVEN'
END 
ELSE 
 BEGIN 
   PRINT 'GIVEN NUMBER IS ODD'
END
=====================================
--TO PRINT NAME AND ID AS SENTENCE

DECLARE @START INT                    --INITILAZIATION
       ,@END INT
       ,@ID INT
       ,@NAME VARCHAR(100)
SET @START = (SELECT MIN(ID) FROM EMP)
SET @END = (SELECT MAX(ID) FROM EMP)

WHILE (@START <= @END)                --CONDITION 
BEGIN
  SELECT @ID = ID FROM EMP WHERE ID = @START
  SELECT @NAME = NAME FROM EMP WHERE ID = @START
  PRINT 'MY ID IS ' + CAST( @ID AS VARCHAR(100))+ ' MY NAME IS '+@NAME
  SET @START = @START+1             --INCREMENT
END


======================================================
DECLARE @START INT
       ,@END INT
	   ,@ID INT
	   ,@NAME VARCHAR(100)
	   ,@AGE INT
SET @START = (SELECT MIN(ID) FROM EMPLOYEE_DETAILS)
SET @END = (SELECT MAX(ID) FROM EMPLOYEE_DETAILS)
WHILE (@START <= @END)
BEGIN
  SELECT @ID = ID FROM EMPLOYEE_DETAILS WHERE ID = @START
  SELECT @NAME = NAME FROM EMPLOYEE_DETAILS WHERE ID = @START
  SELECT @AGE = AGE FROM EMPLOYEE_DETAILS WHERE ID = @START
  PRINT ' MY ID IS ' +CAST( @ID AS VARCHAR(30))+ ' MY NAME IS ' + @NAME  + ' AND AGE IS '+ CAST( @AGE AS VARCHAR(30))
  SET @START = @START + 1
END
====================================================================================================================
--CURSORS
DECLARE @ID INT
       ,@NAME VARCHAR(100)
DECLARE C CURSOR
FOR
SELECT ID,NAME FROM EMP

OPEN C

FETCH NEXT FROM  C
INTO @ID,@NAME

WHILE (@@FETCH_STATUS = 0)
BEGIN
   PRINT 'MY ID IS '+ CAST(@ID AS VARCHAR(100))+ ' MY NAME IS ' + @NAME
   FETCH NEXT FROM C
    INTO @ID,@NAME
END

CLOSE C
DEALLOCATE C
===================================================================
--TO PRINT A TO Z
SELECT ASCII ('A')
SELECT ASCII ('Z')

DECLARE @START INT
SET @START = 65
WHILE(@START <=90)
BEGIN
 PRINT CHAR(@START)
 SET @START = @START +1
END

===============================================================
--TO PRINT a TO z

SELECT ASCII = ('a')
SELECT ASCII = ('b')

DECLARE @START INT
SET @START = 97
WHILE(@START <= 122)
BEGIN
  PRINT CHAR(@START)
  SET @START = @START +1
END