/*
ROWID	ARTIST	TITLE	GENRE	YEAR	TIME	COPIES	SOUNDTRACK

tinyint 1-256 1 biti
smallint 2 biti
int 4 biti
bigint 8 biti
*/
/*
CREATE TABLE NewTable (ROWID TINYINT,
							  ARTIST CHAR(50),
							  TITLE CHAR(50),
							  GENRE char(10),
							  YEAR SMALLINT,
							  TIME CHAR(10),
							  COPIES BIGINT,
							  SOUNDTRACK TINYINT,
							  )
							  
INSERT INTO NewTable (ROWID	ARTIST	TITLE	GENRE	YEAR	TIME	COPIES	SOUNDTRACK)
# VALUE (datele din tabel), (urmatorul rand), ...
*/

#1	Ce genuri muzicale avem in tabel?
SELECT DISTINCT t.GENRE
FROM TOP10LOVESONGS t;

#2	Afisati numele artistilor in ordine alfabetica afisati o singura data
SELECT DISTINCT t.ARTIST 
FROM TOP10LOVESONGS t
ORDER BY t.ARTIST ASC;

#3	Identificati artistii si melodiile care au fost interpretate in duet (doi artisti)?
SELECT t.ARTIST, t.TITLE
FROM TOP10LOVESONGS t
WHERE t.ARTIST LIKE '%&%';

#4	Identificati toate melodiile lui Elvis Presley lansate incepand cu 1960 
SELECT t.TITLE
FROM TOP10LOVESONGS t
WHERE t.ARTIST = 'Elvis Presley' AND t.`YEAR` >= 1960;

#5	Identificati melodiile din genul Slow din anii 60'-70', cu mai mult de 10 mil copies 
 -- sau melodiile genului Rock din anii 60'-70', cum cel putin 15 mil copies 
SELECT t.TITLE
FROM TOP10LOVESONGS t
WHERE t.GENRE = 'Slow' AND (t.`YEAR` BETWEEN 1960 AND 1979) AND t.COPIES > 10000000
   OR t.GENRE LIKE 'Rock%' AND (t.`YEAR` BETWEEN 1960 AND 1979) AND t.COPIES >= 15000000;
 
#6	Identificati toate melodiile din genul Rock, indiferent de an, care au fost Soundtrack (linie melodica intr-un film)
SELECT t.TITLE
FROM TOP10LOVESONGS t
WHERE t.GENRE LIKE 'Rock%' AND t.SOUNDTRACK = 1;

#7	Afisati toate coloanele pentru melodiile din 
-- anii 60, Rock 
-- anii 70, Slow 
-- anii 80-90, Rock si Slow.
SELECT *
FROM TOP10LOVESONGS t
WHERE t.`YEAR` BETWEEN 1960 AND 1969 AND t.GENRE LIKE 'Rock%'
OR t.`YEAR` BETWEEN 1970 AND 1979 AND t.GENRE = 'Slow'
OR t.`YEAR` BETWEEN 1980 AND 1999;

#8	Stim ca fiecare artist a primit o suma de bani pentru melodia care a fost coloana sonora in film (coloana Soundtrack)
-- in anii 60-70 se acordau 10 mil $, iar in anii 80-90 se acordau 25 mil $
-- identificatii artistul, anul si suma de bani primiti
SELECT t.ARTIST, t.YEAR, 10000000 AS bani
FROM TOP10LOVESONGS t
WHERE t.SOUNDTRACK = 1 AND t.`YEAR` BETWEEN 1960 AND 1979
UNION ALL
SELECT t.ARTIST, t.YEAR, 25000000 AS bani
FROM TOP10LOVESONGS t
WHERE t.SOUNDTRACK = 1 AND t.`YEAR` BETWEEN 1980 AND 1999;
/*
SELECT t.ARTIST, t.`YEAR`, case 
									when t.`YEAR` BETWEEN 1960 AND 1979 then 10000000
									when t.`YEAR` BETWEEN 1980 AND 1999 then 25000000
*/
#9	Pentru fiecare melodie Rock calculati durata melodiei in secunde.
SELECT t.ARTIST, t.TITLE, TIME_TO_SEC(t.TIME) AS Durata_melodie_in_secunde
FROM TOP10LOVESONGS t
WHERE t.GENRE LIKE 'Rock%';

#10 Daca 1 copie (coloana COPIES) valora 2 $ la lansarea in anii 60-70, respectiv 4 $ la lansarea in anii 80-90,
 -- care ar fi valoarea totala a copiilor pentru melodiile genului Slow care sa nu fie Soundtrak?
SELECT SUM( t.COPIES *(
				CASE 
				WHEN t.`YEAR` BETWEEN 1960 AND 1979 THEN 2 
				WHEN t.`YEAR` BETWEEN 1980 AND 1999 THEN 4 
				END)) AS Valoare_totala, COUNT(*)
FROM TOP10LOVESONGS t
WHERE t.GENRE = 'Slow' AND t.SOUNDTRACK = 0;
