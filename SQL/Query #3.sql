# INT -> DOUBLE
SELECT 1.0*10/100;
SELECT 10/(100*1.0);

SELECT *
FROM Orders o
WHERE o.OrderDate BETWEEN '2020-03-31' AND '2021-03-31'
AND o.PaymentMode = 'Cash';

SELECT *
FROM Customers c
WHERE c.Country IN ('UK', 'USA', 'Spain') AND c.FirstName LIKE '%AR%';

SELECT *
FROM Products p
WHERE p.IsService = 0 AND p.ProductName LIKE 'S%_%S';

SELECT *
FROM OrderItems i
WHERE (i.UnitPrice >= 120 AND i.Quantity < 20) OR (i.UnitPrice <= 20 AND i.Quantity > 120);