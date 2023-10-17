#Cerinte ( sursa mysql, baza comenzi)

-- 1. Afisati metodele de plata asociate fiecarui curier. Doar cele doua coloane.
SELECT o.Courier, GROUP_CONCAT(DISTINCT o.PaymentMode) AS MetodePlata
FROM comenzi.Orders o
GROUP BY o.Courier;

SELECT DISTINCT a.Courier, a.PaymentMode
FROM comenzi.Orders a
ORDER BY 1,2;

-- 2. Afisati numarul de clienti la nivel de tara si oras. Ordonati dupa tara si oras
SELECT o.Country, o.City, COUNT(DISTINCT o.CustomerId) AS NumarClienti
FROM comenzi.Customers o
GROUP BY o.Country, o.City
ORDER BY o.Country, o.City;

SELECT a.Country, a.City, COUNT(*) Customers
FROM comenzi.Customers a
GROUP BY a.Country, a.City
ORDER BY a.Country, a.City;

-- 3. Identificati LastName-ul care se regaseste la mai mult de un client. Afisati doar LastName si numarul de clienti, nu idul clientului.
SELECT c.LastName, COUNT(DISTINCT c.CustomerId) AS NumarClienti
FROM comenzi.Customers c
GROUP BY c.LastName
HAVING COUNT(DISTINCT c.CustomerId) > 1;

SELECT a.LastName, COUNT(*) Count
FROM comenzi.Customers a
GROUP BY  a.LastName 
HAVING  COUNT(*)>1;

/* 4. Cate comenzi s-au plasat in fiecare an, 
•	livrate de curierul DHL cu metoda de plata Cash 
•	sau livrate de curierul TNT cu metoda de plata Card Online
•	sau livrate de curierii FedEx si UPS laolalta indiferent de metoda de plata?
Afisati anul, curierul si numarul de comenzi*/
SELECT YEAR(o.OrderDate) AS An, o.Courier, COUNT(*) AS NumarComenzi
FROM comenzi.Orders o
WHERE (o.Courier = 'DHL' AND o.PaymentMode = 'Cash')
   OR (o.Courier = 'TNT' AND o.PaymentMode = 'Card Online')
   OR (o.Courier IN ('FedEx', 'UPS'))
GROUP BY An, o.Courier;

-- 5. Afisati emailul clientilor care au comandat cel putin 10 bucati din produsul cu numele Mishi Kobe Niku?


/* 6. Dorim sa oferim cate un voucher cadou tuturor clientilor care au plasat cel putin 10 comenzi, iar valoarea totalta a comenzilor este mai mare de 25000.
 Afisatie email, tara, numar comenzi si valoare totala comenzi.*/

-- 7. Identificati clientii care au platit pentru toate comenzile cu o singura metoda de plata
# nu cred ca e bine
SELECT c.CustomerId
FROM comenzi.Orders c
GROUP BY c.CustomerId
HAVING COUNT(DISTINCT c.PaymentMode) = 1;

-- 8. Afisati preturile active in ziua de Craciun in 2019 pentru produsele cu id-urile (10,45,62 si 78)
SELECT p.ProductId, p.StartDate, p.Price
FROM comenzi.ProductPriceHistory p
WHERE p.ProductId IN (10, 45, 62, 78) AND p.StartDate = '2019-12-25';


/* 9. Care este produsul si pretul cu intervalul cel mai mare de timp fara nicio schimbare de pret pana la data curenta?
Nu vom lua IN considerare cele doua produse servicii (79 si 80)
Puteti folosi una din functiile  de data si timp de aici https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html  (cautati ce functie face diferenta intre doua date)
*/


/* 10. Departamentul de Legal doreste sa stie care sunt clientii care nu aveau varsta legala la data plasarii comenzii.
	In USA si Canada varsta legala este 21 ani
	In toate celelalte tari varsta legala este 18 ani
	Pentru simplificarea rezolvarii, putem  considera 1 an = 365 zile
	Afisati toate detaliile de mai jos pentru acesti clientii.
	Nu vom lua in considerare produsele servicii (voucherul si taxa de transport)
	
Header 
CustomerId / Country / DateOfBirth / OrderDate / CustomerAgeAtOrderDate / ProductName
*/
