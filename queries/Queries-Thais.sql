create database `formula1`;
use `formula1`;

-- Modelagem das tabelas

CREATE TABLE `constructors` (
  `constructorId` int PRIMARY KEY AUTO_INCREMENT,
  `constructorRef` varchar(255),
  `name` varchar(255),
  `nationality` varchar(255)
);

CREATE TABLE `constructorStandings` (
  `constructorStandingsId` int PRIMARY KEY AUTO_INCREMENT,
  `raceId` int,
  `constructorId` int,
  `points` int,
  `position` int,
  `positionText` varchar(255),
  `wins` int
);

CREATE TABLE `drivers` (
  `driverId` int PRIMARY KEY AUTO_INCREMENT,
  `driverRef` varchar(255),
  `forename` varchar(255),
  `surname` varchar(255),
  `nationality` varchar(255)
);

CREATE TABLE `races` (
  `raceId` int PRIMARY KEY AUTO_INCREMENT,
  `year` year,
  `round` int,
  `circuitId` int,
  `name` varchar(255),
  `date` date,
  `time` time
);

CREATE TABLE `results` (
  `resultId` int PRIMARY KEY AUTO_INCREMENT,
  `raceId` int,
  `driverId` int,
  `constructorId` int,
  `number` int,
  `grid` int,
  `positionOrder` int,
  `points` int,
  `laps` int
);

-- Conectando as chaves estrangeiras (FK's)

alter table `constructorstandings` add foreign key (`raceId`) references `races` (`raceId`);
alter table `constructorstandings` add foreign key (`constructorId`) references `constructors` (`constructorId`);
alter table `results` add foreign key (`raceId`) references `races` (`raceId`);
alter table `results` add foreign key (`driverId`) references `drivers` (`driverId`);
alter table `results` add foreign key (`constructorId`) references `constructors` (`constructorId`);

-- Queries/Filtros

-- Quais as equipes que estiveram mais vezes no pódio?
select constructors.name, count(constructorstandings.position) as quantidade_vezes_podio, 
sum(constructorstandings.points) as soma_de_pontos 
from constructorstandings
inner join constructors
on constructorstandings.constructorId = constructors.constructorId
where position <= 3 
group by name
order by quantidade_vezes_podio desc
limit 5;

-- Quais equipes alcançaram mais vezes a primeira posição?
select constructors.name, constructors.nationality, count(constructorstandings.position) as qtd_1lugar 
from constructorstandings
inner join constructors
on constructorstandings.constructorId = constructors.constructorId
where position = 1 
group by name
order by qtd_1lugar desc
limit 5;

-- Quais os pilotos brasileiros responsáveis pela classificação das equipes que ficaram em 1° lugar?
select constructors.name as name_constructor, constructors.nationality as nationality_constructor, 
drivers.forename as name_driver, drivers.surname, drivers.nationality as nationality_driver,
constructorstandings.position, races.year
from constructorstandings
inner join constructors
on constructorstandings.constructorId = constructors.constructorId
inner join results
on constructors.constructorId = results.constructorId
inner join drivers
on results.driverId = drivers.driverId
inner join races
on results.raceId = races.raceId
where position = 1 and drivers.nationality = 'Brazilian'
group by surname, name_constructor
order by name_constructor, year;


