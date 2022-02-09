CREATE TABLE `Results` (
  `resultId` int PRIMARY KEY AUTO_INCREMENT,
  `raceId` int,
  `driverId` int,
  `fastestLap` int,
  `fastestLapTime` time
);

CREATE TABLE `Drivers` (
  `driverId` int PRIMARY KEY AUTO_INCREMENT,
  `forname` varchar(255),
  `surname` varchar(255),
  `nationality` varchar(255)
);

CREATE TABLE `Races` (
  `raceId` int PRIMARY KEY AUTO_INCREMENT,
  `year` int,
  `circuitId` int,
  `name` varchar(255)
);

ALTER TABLE `Results` ADD FOREIGN KEY (`driverId`) REFERENCES `Drivers` (`driverId`);

ALTER TABLE `Results` ADD FOREIGN KEY (`raceId`) REFERENCES `Races` (`raceId`);

USE recorde_voltas;
-- Grafico 1 - As Melhores de Felipe Massa
SELECT 
    *
FROM
    drivers
        INNER JOIN
    results ON drivers.driverId = results.driverId
        INNER JOIN
    races ON races.raceId = results.raceId
WHERE
    drivers.nationality = 'Brazilian'
        AND drivers.surname = 'Massa'
ORDER BY results.fastestLapTime ASC
LIMIT 10;
-- Grafico 2 - As 10 + ...lentas
SELECT 
    *
FROM
    drivers
        INNER JOIN
    results ON drivers.driverId = results.driverId
        INNER JOIN
    races ON races.raceId = results.raceId
ORDER BY results.fastestLapTime DESC
LIMIT 10;
-- Grafico 3 - As 10 + Rapidas
SELECT 
    *
FROM
    drivers
        INNER JOIN
    results ON drivers.driverId = results.driverId
        INNER JOIN
    races ON races.raceId = results.raceId
ORDER BY results.fastestLapTime ASC
LIMIT 10;
-- Grafico 4 - Verstappen x Hamilton
SELECT 
    *
FROM
    drivers
        INNER JOIN
    results ON drivers.driverId = results.driverId
        INNER JOIN
    races ON races.raceId = results.raceId
WHERE
    drivers.surname = 'Verstappen'
ORDER BY results.fastestLapTime ASC
LIMIT 10;
-- Hamilton
SELECT 
    *
FROM
    drivers
        INNER JOIN
    results ON drivers.driverId = results.driverId
        INNER JOIN
    races ON races.raceId = results.raceId
WHERE
    drivers.surname = 'Hamilton'
ORDER BY results.fastestLapTime ASC
LIMIT 5;




