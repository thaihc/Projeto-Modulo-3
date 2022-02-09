create table `circuits`(
 `circuitId` int PRIMARY KEY NOT NULL auto_increment,
  `circuitRef` varchar (100),
  `name` varchar (100),
  `location` varchar (100),
  `country` varchar (50)
  
) ;

create table races (
 `raceId` int primary key not null auto_increment,
 `Year` int,
  `round` int,
  `circuitId` int,
  `name` varchar (100),
  `date` date
);

alter table races drop column `time`;
alter table circuits drop column `lat`;
alter table circuits drop column `Ing`;

alter table races add foreign key (`circuitId`) references circuits(`circuitId`);

select * from circuits;

select country, count(country) as QUANTIDADE from circuits group by country order by QUANTIDADE DESC limit 1;

select * FROM races;

select circuits.country, count(circuits.circuitId) as QUANTIDADE from circuits
inner join  races
on circuits.circuitId = races.circuitId
group by circuits.country
order by QUANTIDADE desc limit 5;
 
 select country ,count(circuits.country) as total_de_corridas FROM circuits
 inner JOIN races
 ON circuits.circuitId = races.circuitId group by country having country = 'Italy';


