
/*

SQL PROJECT

*/


-- 1. Age (in years) of people living in 'Segovia'.

SELECT FLOOR((SYSDATE - birthdate)/365.25) as AGE
FROM persons
WHERE town = 'Segovia';

/*
This query takes the difference between the system date (current date) and the entries under the 
variable 'birthdate' from the table 'persons', divides it by 365.25 and rounds it down to convert the 
individuals' dates of birth into their ages. It then saves these as the entries of a newly created variable 
called 'AGE'. Finally, the query returns the entries of the new variable 'AGE' where the 
corresponding entry under the variable 'town' is equal to the string "Segovia". 
*/


-- 2. Name of drivers whose name contain the word 'SOL'

SELECT name 
FROM persons
JOIN drivers ON persons.dni = drivers.dni
WHERE upper(name) LIKE '%SOL%';

/*
This query creates a new table from the 'persons' and 'drivers' tables based on the related column 
'dni'. It then returns the newly created table altered to consist of only one column with the entries of 
the variable name' where said entries contain the string "sol".
*/


-- 3. Radars registering no observation on 19/JAN/2011, between 22:00 h. and 22:59 h.

SELECT r.road, r.km_point, r.direction
FROM radars r 
JOIN observations o ON r.road = o.road AND r.km_point = o.km_point AND r.direction = o.direction
MINUS
SELECT r. road, r.km_point, r.direction
FROM radars r
JOIN observations o ON r.road = o.road AND r.km_point = o.km_point AND r.direction = o.direction
WHERE o.odatetime BETWEEN '19/01/11 22:00:00' AND '19/01/11 22:59:00';

/*
This query first creates a new table A from the 'radars' and 'observations' tables consisting of only 
the related columns 'road', 'km_point' and 'direction'. It then creates another new table B from the 
same 'radars' and 'observations' tables consisting of only the same related columns 'road', 
'km_point' and 'direction', as well as containing only the entries that correspond to those of the 
variable 'odatetime' that fall between 22:00 and 22:59 on the 19th of January 2011. Finally, it 
subtracts table B from table A to create a new table which is returned.
*/


-- 4. Report the average speeds of each vehicle (make + model), ordered from lowest to highest.
--    Vehicle models for which there are less than 800 recorded observations should be discarded.

SELECT v.make, v.model, AVG(o.speed) AS AVERAGE, count(*) AS COUNT
FROM vehicles v
JOIN observations o ON v.nplate = o.nplate
GROUP BY v.make, v.model 
HAVING count(*) > 800
ORDER BY AVG(o.speed) ASC;

/*
This query creates a new table from the 'vehicles' and 'observations' tables based on the related 
column 'nplate' and consisting of only the columns 'make', 'model'. The rows of the table where the 
entries of both 'make' and 'model' are repeated are grouped where if these repetitions do not exceed a 
total 800 they are discarded. This table is returned in ascending order of average speed. Note that 
above the query is written to include the average speed observed and the total observations made by 
radars of vehicles with a given make and model. This is done to illustrate in the excerpt of the table 
returned that it is in ascending order of average speed and does not contain the make + model 
combinations where fewer than 800 observations are recorded. To remove this one can simply remove 
the code ", AVG(o.speed) AS AVERAGE, count(*) AS COUNT" from line 1.
*/


-- 5.  Monthly report on how many speed violations (recorded speed greater than the speed 
--     limit at that point) have been observed on each radar (for each month and radar). Include the same
--     for each road (and month), and for each road and direction (and month).
--     The required information is: element identifier, total infractions, and indicators regarding the 
--     difference between the actual speed and the speed limit (maximum difference, minimum diff, and 
--     average diff).

SELECT To_char(o.odatetime, 'YYYY/MM') AS MONTH, r.road, r.direction, r.km_point, Count(*) AS TOTAL,
       Max(o.speed - r.speedlim) AS MAX, Min(o.speed - r.speedlim) AS MIN, Avg(o.speed - r.speedlim) AS AVG
FROM radars r 
JOIN observations o ON r.road = o.road AND r.direction = o.direction AND r.km_point = o.km_point
WHERE o.speed > r.speedlim
GROUP BY To_char(o.odatetime, 'YYYY/MM'), r.road, ROLLUP (r.direction, r.km_point)
ORDER BY MONTH ASC;

/*
This query creates a new table from the 'radars' and 'observations' tables based on the related 
columns 'road', 'km_point' and 'direction' and consisting of the columns 'MONTH', 'road', 
'km_point', 'direction', the number of speed violations recorded (on a given road, road and direction, 
or radar) as 'TOTAL' as well as the maximum, minimum and average difference between actual 
speed and speed limit as 'MAX', 'MIN' and 'AVG' respectively. The entries are limited to cases 
where the observed speed exceeds the speed limit. The rows of the table where there are multiple
entries for 'MONTH' and 'road', 'MONTH' and 'road' + 'direction' as well as 'MONTH' and 'road'
+ 'direction' + 'km_point' are grouped. The final results are in ascending order of the variable 
'MONTH'.
*/


-- 6. Public enemy: drivers that have been included more than once in the upper decile of the 
--    report 'monthly infractors' (sorted by amount of infractions, and average speed difference).

WITH
  MonthlyInfractors AS
    (SELECT To_char(odatetime, 'YYYY/MM') AS month, nplate, count(*) AS COUNT
    FROM observations
    GROUP BY To_char(odatetime, 'YYYY/MM'), nplate),
  TopInfractors AS
    (SELECT nplate, COUNT, (ntile(10) OVER (PARTITION BY month ORDER BY Count)) AS TENTILE
    FROM MonthlyInfractors)
SELECT nplate, Sum(Count) AS total FROM TopInfractors
WHERE tentile = 1
GROUP BY nplate
ORDER BY Sum(Count) DESC;

/*
The first query creates a new table called  'MonthlyInfractors' from the 'observations' table consisting 
of the columns 'month', 'nplate', 'km_point', 'direction' and the number of drivers as 'COUNT'. The 
rows of the table where there are multiple entries for 'month' and 'nplate' are grouped. The second
creates another new table called 'TopInfractors' from the 'MonthlyInfractors' table consisting of the 
columns 'nplate', 'COUNT' and the top 10% of drivers with the most infractions for each month and 
radar as 'TENTILE'. The last query creates yet again another new table consisting of the columns 
'nplate' and the sum of 'COUNT' as 'total' from the table 'TopInfractors' where the variable 
'tentile' is equal to 1. The rows of the table where there are multiple entries for 'nplate' are grouped. 
This table is then organised to display the data in descending order of the variable 'total'.
*/


-- 7. Hall of Fame: every radar has its top-ten of fastest observed cars ever. Report cars included in
--    that list on more than ten radars (provide number plate, amount of radars and list of radars).

WITH
  observations2 AS
    (SELECT road||'/'||direction||'/'||km_point AS radar, nplate, speed
    FROM observations),
  InfractionsByRadar AS
    (SELECT nplate, radar, ROW_NUMBER() OVER (PARTITION BY radar ORDER BY speed DESC) AS Rank
    FROM observations2),
  TopCarsUngrouped AS
    (SELECT nplate, LISTAGG(radar, ';') WITHIN GROUP (ORDER BY null) OVER (PARTITION BY nplate) AS Radars
    FROM InfractionsByRadar
    WHERE rank <= 10),
  TopCars AS
    (SELECT nplate, count(*) AS Total, radars
    FROM TopCarsUngrouped
    GROUP BY nplate, radars
    ORDER BY count(*) DESC)
SELECT * FROM TopCars
WHERE Total >= 10;

/*
This query first creates the table observations2 with all the columns that will later be needed, grouping 
the values that identify each radar (road, direction, km_point) into a single column. Each observation 
is then given a rank with a partition cause by comparing all the observations each radar has made and 
ordering them by speed (fastest observations have rank 1). The resulting table is filtered to only 
consider observations with ranks of 10 or lower, and then grouped by nplate. The list of radars where 
these "top ten" observation were taken for each car is saved. Grouping by nplate function Count(*) was used
to obtain the number of times each car has appeared in one of these top ten rankings for a radar. Finally, 
the results are filtered to only show those cars with cars equal or greater than 10
*/
