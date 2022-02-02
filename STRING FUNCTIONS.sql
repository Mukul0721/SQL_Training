STRING FUNCTIONS
--===================
--LEN : Return a number of characters of a character string
DATALENGTH : Returns the number of bytes used to represent an expression

LOWER : Convert a string to Lowercase
UPPER : Convert a string to Uppercase

LEFT :  Extracts a number of characters from a string (starting from left)
RIGHT : Extracts a number of characters from a string (starting from right)

LTRIM : Removes leading spaces from a string
RTRIM : Removes trailing spaces from a string

SUBSTRING : Extracts some characters from a string
CHARINDEX : Returns the position of a substring in a string 
PATINDEX :  Returns the position of a pattern in a string

REPLACE :  	Replaces all occurrences of a substring within a string, with a new substring
REPLICATE : Repeats a string a specified number of times
REVERSE :   Reverses a string and returns the result
STUFF :     Deletes a part of a string and then inserts another part into the string, starting at a specified position

SPACE : 	Returns a string of the specified number of space characters
ASCII :     Returns the ASCII value for the specific character
CHAR  :     Returns the character based on the ASCII code

=========================================
SELECT LEN('MUKUL KUMAR' )
SELECT DATALENGTH('HE WORKS IN PARADIGMIT')
 
SELECT ID,NAME,LEN(MAIL)
FROM EMPLOYEE_DETAILS

SELECT LEFT('MUKUL KUMAR',5)
SELECT RIGHT('MUKUL KUMAR',4)

SELECT LTRIM('              MUKUL KUMAR')
SELECT RTRIM('MUKUL KUMAR      ')
SELECT LEN ( RTRIM('MUKUL KUMAR      '))

SUBSTRING(EXPRESSION,START,LENGTH)

SELECT SUBSTRING('MUKUL KUMAR',2,8)
SELECT ID,NAME,SUBSTRING(MAIL,2,7)
FROM EMPLOYEE_DETAILS

CHARINDEX(EXPRESSION TO FIND,EXPRESSION TO SEARCH,START LOCATON)
 SELECT CHARINDEX('@','MUKUL@KUMAR') 

SELECT PATINDEX('MUKUL_','MUKUL@KUMAR')

 REPLACE(STRING,EXPRESSION TO REMOVE,EXPRESSION TO ADD)
 SELECT REPLACE('MUKUL@KUMAR','U','%')

 STUFF(CHARACTER _EXPRESSION,START,LENGTH,REPLACE WITH_EXPRESSION)
 SELECT STUFF('MUKUL',2,5,'RA')

SELECT REPLICATE('MUKUL'+'    ',2)
SELECT REVERSE('MUKUL')


SELECT 'MUKUL'+SPACE(2)+'KUMAR'

SELECT ASCII('A') 
SELECT ASCII('Z')

SELECT CHAR(67)