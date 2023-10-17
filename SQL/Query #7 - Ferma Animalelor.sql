# Exerciții

# 1. Cate animale, ca număr, se găsesc în cele doua ferme împreună?
SELECT SUM(b.Numar) as TotalAnimale
From Boieri b;

# 2. Cate animale, ca număr, se regăsesc la fiecare fermă?
SELECT b.Ferma, SUM(b.Numar) as TotalAnimale
FROM Boieri b
GROUP BY b.Ferma;

# 3. Cate păsări are fiecare ferma şi care sunt aceste animale?
SELECT b.Ferma, b.Animal, SUM(b.Numar) AS Numar_Pasari
FROM Boieri b 
WHERE b.Clasa = 'Pasari'
GROUP BY b.Ferma, b.Animal;

# 4. Care fermă are cele mai multe tipuri (nu clasă) de animale?
SELECT b.Ferma, COUNT(b.Animal) AS Total_Animale
FROM Boieri b
GROUP BY b.Ferma
ORDER BY Total_Animale DESC
LIMIT 1;

# 5. Identificați ferma care are cel puțin 20 de erbivore.
SELECT b.Ferma, SUM(b.Numar) AS Numar_Erbivore
FROM Boieri b
WHERE b.Clasa = 'Erbivore'
GROUP BY b.Ferma
HAVING SUM(b.Numar)>=20;

# 6. Cu cât la % sunt mai multe animale în Ferma 2 fata de Ferma 1?
SELECT b.Ferma, SUM(b.Numar) / (SELECT SUM(b.Numar) From Boieri b) AS TotalAnimale
FROM Boieri b
GROUP BY b.Ferma;

SELECT b.Ferma,
    SUM(IF(b.Ferma = 1, b.Numar, 0)) AS NumarAnimaleFerma1,
    SUM(IF(b.Ferma = 2, b.Numar, 0)) AS NumarAnimaleFerma2,
    SUM(b.Numar) AS TotalAnimale
FROM Boieri b
GROUP BY b.Ferma;

# 7. Daca fiecare găină face 5 ouă pe săptămână, câte ouă se strâng pe fiecare fermă în 4 săptămâni?
SELECT b.Ferma, SUM(IF(b.Animal = 'Gaini', b.Numar * 5 * 4, 0)) AS OuaStranse
FROM Boieri b
GROUP BY Ferma;


# 8. Știm ca fiecare vacă da 10 litri lapte pe zi, oile 1 litru, caprele 2 litri. Știind
# toate acestea, aflați cat lapte se va strânge într-o săptămână la fiecare
# fermă în parte de la fiecare tip de animal? Folosiți-va de CASE WHEN THEN END
SELECT b.Ferma, b.Animal,
   SUM(CASE        
            WHEN b.Animal = 'Vaci' THEN b.Numar * 10 * 7         
            WHEN b.Animal = 'Oi' THEN b.Numar * 1 * 7          
            WHEN b.Animal = 'Capre' THEN b.Numar * 2 * 7     
        END) AS LapteStrans
FROM Boieri b
WHERE b.Clasa = 'Erbivore'
GROUP BY b.Ferma, b.Animal;
