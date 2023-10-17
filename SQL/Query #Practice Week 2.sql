/*SQL Week2. Exercitiile se fac in baza world, tabel country_facts*/


 # 1) Afisati continentele in ordine alfabetica.
SELECT distinct c.Country
FROM country_facts c
ORDER BY c.Country; 

 # 2) Afisati coloanele Country si Population in ordine descrescatoare dupa Populatie.
SELECT c.Country, c.Population
FROM country_facts c
ORDER BY c.Population DESC;

 # 3) Afisati primele 10 tari in ordine descrescatoare dupa Internet_Users.
SELECT c.Country, c.Internet_Users
FROM country_facts c
ORDER BY c.Internet_Users desc
LIMIT 10;

 # 4) Identificati tara cu cea mai mare speranta de viata (Life_Expectancy).
SELECT c.Country
FROM country_facts c
ORDER BY Life_Expectancy DESC
LIMIT 1;

 # 5) Identificati tarile urbanizate (Urban_Percentage) in proportie de 100%.
SELECT c.Country
FROM country_facts c
WHERE c.Urban_Percentage = 100;

 # 6) Identificati tarile din Europa care incep cu litera E, respectiv tarile din Asia si Africa care incep cu litera A.
SELECT c.Country
FROM country_facts c
WHERE c.Continent = 'Europe' AND c.Country LIKE 'E%'
OR c.Continent IN ('Asia', 'Africa') AND c.Country LIKE 'A%'; 

 # 7) Cunoscand numarul populatiei si numarul userilor de internet, aflati tara cu rata cea mai ridicata de utilizatori de internet raportat la numarul populatiei tarii respective.
SELECT c.Country, c.Internet_Users / c.Population AS Internet_Users_Rate
FROM country_facts c
ORDER BY Internet_Users_Rate DESC
LIMIT 1;

 # 8) Pentru fiecare continent in parte calculati ce procent reprezinta turistii din toate tarile de pe continent raportat la populatia continetului respectiv.
SELECT c.Continent, (SUM(c.Tourists) * 100.0 / SUM(c.Population)) AS Tourism_Percentage
FROM country_facts c
GROUP BY c.Continent;

 # 9) Identificati tara cu Status 'Developed' si cu cel mai mic GDP, respectiv tara cu Status 'Developing' si cu cel mai mare GDP. Nu vom lua in considerare tarile cu GDP=0
(SELECT c.Country, c.GDP
FROM country_facts c
WHERE c.GDP > 0 AND c.`Status` = 'Developed'
ORDER BY c.GDP ASC
LIMIT 1)
UNION ALL
(SELECT c.Country, c.GDP
FROM country_facts c
WHERE c.GDP > 0 AND c.`Status` = 'Developing'
ORDER BY c.GDP DESC
LIMIT 1);

# 10) Pentru fiecare animal in parte (din coloana National_Animal) calculati numarul tarilor pe care apare acesta. Nu afisati randul cu (NULL)
SELECT c.National_Animal, COUNT(c.Country) AS Number_of_Countries
FROM country_facts c
WHERE c.National_Animal IS NOT NULL
GROUP BY c.National_Animal;

# 11)	Identificati si afisati tara fiecarui continent cu cea mai mare populatie. Solutia optima presupune utilizarea lui:  row_number() over (partition by col1 order by col2 desc) as Rowid. Col1 si col2 vor fi coloanele potrivite din tabelul country_facts.
SELECT Country, Continent, Population
FROM (
  SELECT c.Country, c.Continent, c.Population,
         ROW_NUMBER() OVER (PARTITION BY c.Continent ORDER BY c.Population DESC) AS RowId
  FROM country_facts c
) AS Subquery
WHERE RowId = 1;

# 12) Stiind ca World_Share reprezinta procentul populatiei tarii raportat la intreaga populatie a lumii, calculati separat proportia procentuala cu 2 zecimale si comparati-o cu valoarea gasita in cmpul World_Share. Gasiti primele 3 tari cu diferenta cea mai mare intre calculul vostru si valoarea deja calculata in World_Share.
SELECT c.Country, 
       ROUND((c.Population * 100.0 / 
		 		(SELECT SUM(c.Population) 
				 FROM country_facts c)), 2) 
				 AS Calculated_World_Share,
       ABS(ROUND((c.Population * 100.0 / 
		 				(SELECT SUM(c.Population) 
						 FROM country_facts c)), 2) - c.World_Share) 
						 AS Difference
FROM country_facts c
ORDER BY Difference DESC
LIMIT 3;
