# 1.	Write a query that will show the total number of ItemId.
SELECT COUNT(i.ItemId) AS TotalNumberOfItems
FROM Items i;

# 2.	Write a query that will show the total number of SaleId for each PartnerId.
SELECT s.PartnerId, COUNT(s.SaleId) AS TotalNumberOfSales
FROM Sales s
GROUP BY s.PartnerId;

# 3.	Write a query that will show all the PartnerId for which the PartnerCode begin with NY
SELECT p.PartnerId
FROM Partners p
WHERE p.PartnerCode LIKE 'NY%';

# 4.	Write a query that will show the total SalePrice paid by PartnerId=100
SELECT s.PartnerId, SUM(s.SalePrice) AS TotalSalePrice
FROM Sales s
WHERE s.PartnerId = 100
GROUP BY s.PartnerId;

# 5.	Write a query that will show the Average SalePrice on March 2010.
SELECT AVG(s.SalePrice) AS  AverageSalePrice
FROM Sales s
WHERE s.DATE>= '2010-03-01' AND s.DATE < '2010-04-01';

# 6.	Write a query that will return the Total Sales Value for each ItemId from Items table for JANUARY 2014.
SELECT s.ItemId, SUM(s.Quantity * s.SalePrice) AS TotalSalesValue
FROM Sales s
WHERE s.Date >= '2014-01-01' AND s.Date < '2014-02-01'
GROUP BY s.ItemId;

# 7.	Write a query that will return the Total Sales Value registered to the parner: “Gigel” for January 2010. 
SELECT SUM(s.Quantity * s.SalePrice) AS TotalSalesValue
FROM Sales s
JOIN Partners p ON s.PartnerId = p.PartnerId
WHERE p.PartnerName = 'Gigel' AND s.Date >= '2010-01-01' AND s.Date < '2010-02-01';

# 8.	Write a query that will return the top 10 best-selling products from a value standpoint.
SELECT i.ItemName, SUM(s.Quantity * s.SalePrice) AS TotalSalesValue
FROM Sales s
JOIN Items i ON s.ItemId = i.ItemId
GROUP BY i.ItemName
ORDER BY TotalSalesValue DESC
LIMIT 10;

# 9.	Delete all partners from the Partners table that don’t have any sales associated.
DELETE FROM Partners
WHERE PartnerId NOT IN (SELECT DISTINCT PartnerId FROM Sales);

# 10.	Modify the sales price for item having the ItemId 35 for all sales in the last 5 days for the partner:  “Gigel”. The new sales price is 2550.
UPDATE Sales
SET SalePrice = 2550
WHERE ItemId = 35 AND PartnerId = (SELECT PartnerId FROM Partners WHERE PartnerName = 'Gigel') AND Date >= DATEADD(day, -5, GETDATE());

# 11.	Insert a new partner record in the Partners table having the PartnerId 105 and the PartnerName “Veronica”.
INSERT INTO Partners (PartnerId, PartnerName)
VALUES (105, 'Veronica');

# 12.	If we apply an index on the Sales table based on the column “Date”, do we increase, decrease or is there no effect on the performance of the query from point 1 of this test? Please explain why.
/* Adding an index on the "Date" column in the Sales table can improve the performance of 
the query from point 1. The reason is that when you have a WHERE clause that filters records 
based on a column like "Date," an index on that column allows the database to quickly locate 
the relevant rows without having to scan the entire table. This significantly reduces the number 
of disk reads and improves the query execution time.
*/

# 13.	If we apply an index on the Partners table based on the column “PartnerCode” do we increase, decrease or is there no effect on the performance of the insert query from point 6 of this test? Please explain why.
/* Adding an index on the "PartnerCode" column in the Partners table may slightly decrease 
the performance of the insert query from point 6. The reason is that when you insert 
a new record, the database needs to update the index to maintain its sorted order. This additional 
overhead can slow down the insert operation, but the impact might not be significant unless you 
have a very large number of records in the table.
*/

# 14.	Add the column MU (Measure Unit) in the table Items.
ALTER TABLE Items
ADD MU VARCHAR(50);

# 15.	Delete the previously created column from the table Items.
ALTER TABLE Items
DROP COLUMN MU;

# 16.	Please list at least 2 differences between the functions COALESCE and ISNULL.
/*
COALESCE: It accepts multiple input expressions and returns the first non-null expression in the 
list. It is an ANSI standard function and is supported by most database systems.

ISNULL: It accepts only two input expressions and returns the first expression if it is not null; 
otherwise, it returns the second expression. It is specific to SQL Server and not part of the ANSI SQL standard.
*/

# 17.	Please list at least 3 differences between TRUNCATE  and  DELETE.
/*
TRUNCATE is a DDL (Data Definition Language) operation, while DELETE is a DML (Data Manipulation Language) operation.
TRUNCATE removes all rows from a table and deallocates the space used by the table, resulting in
a smaller transaction log, while DELETE removes rows one by one and logs each row deletion, resulting in a larger transaction log.
TRUNCATE cannot be used on tables involved in foreign key constraints, while DELETE can be used.
*/

# 18.	What is the difference between UNION and UNION ALL.
/*
UNION: It combines the result sets of two or more SELECT queries into 
a single result set, removing duplicate rows. It performs a distinct operation on the combined result.
UNION ALL: It also combines the result sets of two or more SELECT 
queries into a single result set, but it includes all rows from all SELECT queries, including duplicates.
*/
# 19.	How many clustered indexes can be defined on one table?
/* In SQL Server, a table can have only one clustered index. The clustered index 
determines the physical order of the data in the table. However, a table can have 
multiple non-clustered indexes.
*/
# 20.	Which id value will be returned by the below select statement given the following details:
DECLARE @Logic TABLE (ID INT, Product VARCHAR(50))
INSERT INTO @Logic
VALUES (1, 'Baseball Hat'),
       (2, 'Bicycle'),
       (3, 'Snowboard'),
       (4, 'Goggles'),
       (5, 'Shows')

SELECT ID
FROM @Logic
WHERE Product = 'Bicycle' OR Product = 'Snowboard' AND ID = 4

-- Answer: In SQL Server, a table can have only one clustered index. The clustered index determines the physical order of the data in the table. However, a table can have multiple non-clustered indexes.

# 21.	Having the following table structure what do the operators INTERSECT and EXCEPT return?
/*
Table_A		Table_B
		
Col_X		Col_Y
18			1
20			20
4			2
1			3
2		

SELECT Col_X AS 'Intersect'
FROM Table_A
INTERSECT
SELECT Col_Y
FROM Table_B
*/
-- Answer:
-- The result of the INTERSECT query will be a single column named 'Intersect' containing the values 1, 2, and 20.
/*
SELECT Col_X AS 'Except'
FROM Table_A
EXCEPT
SELECT Col_Y
FROM Table_B
*/
-- Answer:
-- The result of the INTERSECT query will be a single column named 'Intersect' containing the values 1, 2, and 20.

# 22.	Please specify the value returned by each of the statements below:
DECLARE @a VARCHAR(10), @b VARCHAR(10), @c VARCHAR(10), @d VARCHAR(20), @e VARCHAR(20)
SET @a= 'ana'
SET @b= ' are mere'
SET @c= ' are mere '

SELECT LEN(@a) AS V1		-- Answer: 3 => the length of the string "ana" is 3 characters
SELECT LEN(@b) AS V2 	-- Answer: 9 => the length of the string " are mere" is 9 characters.
SELECT LEN(@c) AS V3 	-- Answer: 10 => the length of the string " are mere " is 10 characters
SELECT @d = @a + @c 		-- Answer: 10 => the length of the string " are mere " is 10 characters
SELECT LEN(@d) AS V4 	-- Answer: 12 => the length of the string "ana are mere " is 12 characters
SELECT @e = LTRIM(RTRIM(@a)) + LTRIM(RTRIM(@c)) 	
-- Answer:  "ana are mere" because LTRIM and RTRIM functions remove any leading and trailing spaces from the strings before concatenating them
SELECT LEN(@e) AS V5 	-- Answer:  11 because the length of the string "ana are mere" is 11 characters (no leading or trailing spaces)

