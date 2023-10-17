SELECT C.FirstName, C.LastName
FROM Customers C
WHERE C.DateOfBirth < '1990-01-01'
AND C.Country = 'UK';

SELECT O.OrderId
FROM OrderItems O
WHERE O.UnitPrice > 100
AND O.Quantity >= 50
ORDER BY O.OrderId desc
LIMIT 3;


SELECT S.CustomerId 
FROM Orders S
WHERE S.OrderDate < '2021-03-01'
AND S.PaymentMode = 'Cash'
AND S.Courier <> 'DHL';

SELECT *
FROM Products P
WHERE P.IsService = 0
AND (P.CurrentUnitPrice > 100
OR  P.CurrentUnitPrice < 5);