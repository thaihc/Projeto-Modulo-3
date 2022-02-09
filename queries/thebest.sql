CREATE TABLE resultadoscorridas(
ResultadoID INT PRIMARY KEY,
CorridaID INT, 
PilotoID INT, 
PilotoPosicaoCheg INT,
PilotoPontosCorrida INT, 
ResultadoVrapida VARCHAR(7)
);

CREATE TABLE ´corridas´(
CorridaID INT PRIMARY KEY,
CorridaAno YEAR,
CorridaOrdem INT,
CorridaData DATE
);
DROP TABLE ´corridas´;
CREATE TABLE ´pilotos´(
PilotoID INT PRIMARY KEY, 
PilotoNomepop VARCHAR(255),
PilotoSigla VARCHAR(100),
PilotoNome VARCHAR(255),
PilotoSobrenome VARCHAR(255)
);

ALTER TABLE resultadoscorridas ADD FOREIGN KEY (PilotoID) REFERENCES ´pilotos´ (PilotoID);
ALTER TABLE resultadoscorridas ADD FOREIGN KEY (CorridaID) REFERENCES  ´corridas´ (CorridaID);


SELECT *, COUNT(*) AS TOTAL_CORRIDAS FROM resultadoscorridas WHERE CorridaID IN(SELECT CorridaID FROM ´corridas´ WHERE CorridaAno BETWEEN 2007 AND 2022)
AND PilotoPosicaoCheg<=3;

SELECT * FROM resultadoscorridas WHERE PilotoID IN (SELECT PilotoID FROM ´corridas´ WHERE CorridaAno BETWEEN 2007 AND 2022)
AND PilotoPosicaoCheg<=3;

SELECT X.PilotoID, X.PODIOS
FROM
(SELECT PilotoID, COUNT(CorridaID) AS PODIOS FROM resultadoscorridas
WHERE PilotoID IN (SELECT PilotoID FROM ´corridas´ WHERE CorridaAno BETWEEN 2007 AND 2022)
AND PilotoPosicaoCheg<=3
GROUP BY PilotoID)X;

SELECT A.PilotoID, A.TOTAL_CORRIDAS
FROM (SELECT PilotoID, COUNT(CorridaID) AS TOTAL_CORRIDAS FROM resultadoscorridas GROUP BY PilotoID)A;

-- Quais são os 10 melhores pilotos da atualidade segundo os registros mais recentes?
SELECT A.PilotoID, ´pilotos´.PilotoNome,´pilotos´.PilotoSobrenome, X.PODIOS, A.TOTAL_CORRIDAS, 
(X.PODIOS/A.TOTAL_CORRIDAS)*100 AS PERCENTUAL_PODIOS FROM vw_totalcorridas A INNER JOIN vw_npodios X
ON A.PilotoID= X.PilotoID 
INNER JOIN ´pilotos´
ON X.PilotoID= ´pilotos´.PilotoID
ORDER BY X.PODIOS DESC LIMIT 10;
SELECT  PilotoID, PODIOS, TOTAL_CORRIDAS, PERCENTUAL_PODIOS, CONCAT(PilotoNome, ' ', PilotoSobrenome) AS PILOTO_NOMECOMP FROM vw_resultados GROUP BY PILOTO_NOMECOMP;

SELECT * FROM vw_totalcorridas;
SELECT * FROM vw_resultados;
SELECT * FROM vw_10melhores;