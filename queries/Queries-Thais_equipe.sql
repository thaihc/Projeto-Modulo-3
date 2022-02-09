create database `formula1`;
use `formula1`;

-- Modelagem das tabelas

CREATE TABLE `constructors` (
    `constructorId` INT PRIMARY KEY AUTO_INCREMENT,
    `constructorRef` VARCHAR(255),
    `name` VARCHAR(255),
    `nationality` VARCHAR(255)
);

CREATE TABLE `constructorStandings` (
    `constructorStandingsId` INT PRIMARY KEY AUTO_INCREMENT,
    `raceId` INT,
    `constructorId` INT,
    `points` INT,
    `position` INT,
    `positionText` VARCHAR(255),
    `wins` INT
);

CREATE TABLE `drivers` (
    `driverId` INT PRIMARY KEY AUTO_INCREMENT,
    `driverRef` VARCHAR(255),
    `forename` VARCHAR(255),
    `surname` VARCHAR(255),
    `nationality` VARCHAR(255)
);

CREATE TABLE `races` (
    `raceId` INT PRIMARY KEY AUTO_INCREMENT,
    `year` YEAR,
    `round` INT,
    `circuitId` INT,
    `name` VARCHAR(255),
    `date` DATE,
    `time` TIME
);

CREATE TABLE `results` (
    `resultId` INT PRIMARY KEY AUTO_INCREMENT,
    `raceId` INT,
    `driverId` INT,
    `constructorId` INT,
    `number` INT,
    `grid` INT,
    `positionOrder` INT,
    `points` INT,
    `laps` INT
);

-- Conectando as chaves estrangeiras (FK's)

alter table `constructorstandings` add foreign key (`raceId`) references `races` (`raceId`);
alter table `constructorstandings` add foreign key (`constructorId`) references `constructors` (`constructorId`);
alter table `results` add foreign key (`raceId`) references `races` (`raceId`);
alter table `results` add foreign key (`driverId`) references `drivers` (`driverId`);
alter table `results` add foreign key (`constructorId`) references `constructors` (`constructorId`);

-- Queries/Filtros

-- Quais as equipes que estiveram mais vezes no pódio?
SELECT 
    constructors.name,
    COUNT(constructorstandings.position) AS quantidade_vezes_podio,
    SUM(constructorstandings.points) AS soma_de_pontos
FROM
    constructorstandings
        INNER JOIN
    constructors ON constructorstandings.constructorId = constructors.constructorId
WHERE
    position <= 3
GROUP BY name
ORDER BY quantidade_vezes_podio DESC
LIMIT 5;

-- Quais equipes alcançaram mais vezes a primeira posição?
SELECT 
    constructors.name,
    constructors.nationality,
    COUNT(constructorstandings.position) AS qtd_1lugar
FROM
    constructorstandings
        INNER JOIN
    constructors ON constructorstandings.constructorId = constructors.constructorId
WHERE
    position = 1
GROUP BY name
ORDER BY qtd_1lugar DESC
LIMIT 5;

-- Quais os pilotos brasileiros responsáveis pela classificação das equipes que ficaram em 1° lugar?
SELECT 
    constructors.name AS name_constructor,
    constructors.nationality AS nationality_constructor,
    drivers.forename AS name_driver,
    drivers.surname,
    drivers.nationality AS nationality_driver,
    constructorstandings.position,
    races.year
FROM
    constructorstandings
        INNER JOIN
    constructors ON constructorstandings.constructorId = constructors.constructorId
        INNER JOIN
    results ON constructors.constructorId = results.constructorId
        INNER JOIN
    drivers ON results.driverId = drivers.driverId
        INNER JOIN
    races ON results.raceId = races.raceId
WHERE
    position = 1
        AND drivers.nationality = 'Brazilian'
GROUP BY surname , name_constructor
ORDER BY name_constructor , year;


