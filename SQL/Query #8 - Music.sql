# 1. Afișați numele artistului cu cele mai multe melodii
SELECT m.ARTIST, COUNT(*) AS Numar_Melodii
FROM Music m

# 2. Identificați numărul de melodii din tabel la nivelul fiecărui an. Ordonare după an

# 3. Afișați câmpurile ARTIST şi TITLE pentru melodiile care conțin cuvântul SONG în titlu

# 4. Care este ultimul an pentru care Elvis Presley apare cu o melodie în tabel?

# 5. Care sunt primele 3 genuri muzicale cu cele mai multe melodii? Nu vom lua în considerare genul TBD. Afișați coloana GENRE şi alăturat numărul de melodii.

# 6. Calculați proporția (procentul) fiecărui gen muzical în total melodii. Afișați coloana GENRE, numărul de melodii, respectiv procentul cu 2 zecimale.

# 7. Identificați artiștii care în același an au avut cel puțin 4 melodii. Afișați ARTIST, YEAR, numărul melodiilor.

# 8. Afișați toate coloanele cu durata mai mare de 400 secunde, pentru melodiile lansate între anii 1980-1990 sau începând cu 2000

# 9. La nivel de ARTIST, YEAR, GENRE calculați numărul de melodii şi numărul total de secunde

# 10. Identificați cea mai scurtă şi cea mai lungă melodie în secunde