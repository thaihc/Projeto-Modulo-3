CREATE TABLE resultadoscorridas(
ResultadoID INT PRIMARY KEY,
CorridaID INT, 
PilotoID INT, 
PilotoPosicaoCheg INT,
PilotoPontosCorrida INT, 
ResultadoVrapida VARCHAR(7)
);

CREATE TABLE ´corridas´(
CorridaID BIGINT PRIMARY KEY,
CorridaAno YEAR,
CorridaOrdem INT,
CorridaData DATE
);

CREATE TABLE ´pilotos´(
PilotoID INT PRIMARY KEY, 
PilotoNomepop VARCHAR(255),
PilotoSigla VARCHAR(100),
PilotoNome VARCHAR(255),
PilotoSobrenome VARCHAR(255)
);
SELECT *, COUNT(*) AS TOTAL_CORRIDAS FROM resultadoscorridas WHERE CorridaID IN(SELECT CorridaID FROM ´corridas´ WHERE CorridaAno BETWEEN 2007 AND 2022)
AND PilotoPosicaoCheg<=3;

SELECT * FROM resultadoscorridas WHERE PilotoID IN (SELECT PilotoID FROM ´corridas´ WHERE CorridaAno BETWEEN 2007 AND 2022)
AND PilotoPosicaoCheg<=3;

SELECT X.PilotoID, X.PODIOS, X.CORRIDAS_VENCIDAS
FROM
(SELECT PilotoID, COUNT(CorridaID) AS PODIOS FROM resultadoscorridas
WHERE PilotoID IN (SELECT PilotoID FROM ´corridas´ WHERE CorridaAno BETWEEN 2007 AND 2022)
AND PilotoPosicaoCheg<=3
GROUP BY PilotoID)X;

SELECT A.PilotoID, A.TOTAL_CORRIDAS
FROM (SELECT PilotoID, COUNT(CorridaID) AS TOTAL_CORRIDAS FROM resultadoscorridas GROUP BY PilotoID)A;

SELECT A.PilotoID, X.PODIOS, A.TOTAL_CORRIDAS,
(X.PODIOS/A.TOTAL_CORRIDAS)*100 AS PERCENTUAL_PODIOS FROM vw_totalcorridas A INNER JOIN vw_npodios X
ON A.PilotoID= X.PilotoID;
SELECT * FROM vw_results;

