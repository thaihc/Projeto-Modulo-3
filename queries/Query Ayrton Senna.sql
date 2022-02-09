CREATE TABLE drivers(
id int AUTO_INCREMENT PRIMARY KEY,
driveRef varchar(100), 
nationality varchar(100)
);
 CREATE TABLE races(
id int AUTO_INCREMENT PRIMARY KEY,
date date ,
name varchar(100)
);

CREATE TABLE mytable(
   resultId INTEGER  NOT NULL PRIMARY KEY 
  ,raceId   INTEGER  NOT NULL
  ,driverId INTEGER  NOT NULL
  ,position INTEGER 
  ,points   NUMERIC(4,2) NOT NULL
);

select * from `mytable`;
 ALTER TABLE mytable 
ADD foreign key (driverId) 
references drivers (ID);

ALTER TABLE mytable
ADD foreign key (raceId)
references races (ID);

select driverId, raceId from mytable 
where driverId = 102 AND position <= 3; 

select driveRef, count(*) as totalPodios from mytable 
inner join drivers on mytable.driverId = drivers.id
where driverId = 102 and position <= 3;
select * from view_podios;

select raceId, count(*) as totalCorridas from mytable
where  driverId = 102;

SELECT * FROM view_podios inner join 
 view_total_corridas;









