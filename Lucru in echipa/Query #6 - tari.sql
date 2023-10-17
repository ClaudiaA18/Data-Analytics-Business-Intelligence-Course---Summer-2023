CREATE TABLE Londra (
 							Oras CHAR(50), 
							Tara CHAR(50),
							Continent CHAR(50),	
							Populatie INT,	
							Turisti INT,
							Obiectiv1 CHAR(100),	
							Obiectiv2 CHAR(100),	
							Obiectiv3 CHAR(100)
							  );
# DROP TABLE Londra;
INSERT INTO Londra (Oras, Tara, Continent, Populatie, Turisti, Obiectiv1, Obiectiv2, Obiectiv3)
VALUE ('Londra','UK','Europa',8900000,25000000,'Muzeul Britanic','Palatul Buckingham','London Eye');

#DELETE FROM Londra WHERE Oras='Londra';

SELECT t.Obiectiv2 AS Obiectiv2_recomandat
FROM Londra t;

SELECT *, ROUND( 
			t.Populatie +
			(t.Populatie / 1000 * (15 -8)) + 
			((t.Populatie + (t.Populatie / 1000 * (15 -8)))/ 1000 * (15 -8))) AS Populatie_2025
FROM Londra t;

