select * from circuits
inner join races
on circuits.circuitId = races.circuitId;

select distinct country, circuitRef from circuits
inner join races
on circuits.circuitId = races.circuitId
group by country, circuitRef
order by country;

-- queries para pais com maior numero de pistas
select country, count(*) as contar_pistas from 
(select distinct country, circuitRef from circuits
inner join races
on circuits.circuitId = races.circuitId
group by country, circuitRef
order by country) as pistas
group by country
order by contar_pistas desc
 limit 5;

