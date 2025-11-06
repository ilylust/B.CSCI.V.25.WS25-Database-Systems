-- 1. List all the drivers who won a race in 2005.
SELECT DISTINCT forename, surname FROM drivers 
JOIN results 
    ON drivers.id = results.driver_id 
JOIN races 
    ON results.year = races.year AND results.round = races.round 
WHERE races.year = 2005 AND finalPosition = 1;
-- 2. List all the drivers who has ever won a race in Dallas
SELECT DISTINCT forename, surname FROM drivers 
JOIN results
    ON results.driver_id = drivers.id 
JOIN races
    ON results.year = races.year 
JOIN race_names
    ON races.raceName_id = race_names.id
JOIN race_circuits
    ON races.year = race_circuits.year AND race_names.name = race_circuits.race
JOIN circuits
    ON race_circuits.circuit = circuits.name
WHERE circuits.city = 'Dallas'
    AND results.finalPosition = 1;
-- 3. Provide the final results of 1999 for drivers.
SELECT forename, surname, finalPosition, points, laps FROM drivers 
JOIN results 
    ON results.driver_id = drivers.id 
WHERE year = 1999 
ORDER BY finalPosition;
-- 4. List all the Grand Prixs that that happened at least 10 times between 1985 and 2000
SELECT race_names.name FROM race_names JOIN races ON races.raceName_id = race_names.id WHERE races.year BETWEEN 1985 AND 2000 GROUP BY race_names.name HAVING COUNT(*) >= 10;
-- 5. List all the circuits that had at least 10 races between 1985 and 2000.
SELECT race_circuits.circuit FROM race_circuits JOIN race_names ON race_circuits.race = race_names.name JOIN races ON race_names.id = races.raceName_id AND race_circuits.year = races.year WHERE races.year BETWEEN 1985 AND 2000 GROUP BY race_circuits.circuit HAVING COUNT(*) >= 10;
-- 6. Create a view that tells for each driver, how many times they started from the first position.
CREATE VIEW driver_start_postion_first AS SELECT DISTINCT forename, surname, COUNT(*) AS 'First position start count' FROM drivers JOIN results ON drivers.id = results.driver_id WHERE startPosition = 1 GROUP BY forename, surname;
-- 7. Delete all the data after 2000.
DELETE FROM results WHERE year > 2000;
DELETE FROM races WHERE year > 2000;
DELETE FROM race_circuits WHERE year > 2000;
-- 8. List all of the drivers who has no race results. (hint: use LEFT join)
SELECT forename, surname
FROM drivers
LEFT JOIN results ON drivers.id = results.driver_id
WHERE results.driver_id IS NULL;
-- 9. Delete all lap statistics data.
ALTER TABLE results DROP COLUMN laps;
ALTER TABLE results DROP COLUMN fastestLap;
ALTER TABLE results DROP COLUMN fastestLapTime;
-- 10. Delete all data related to Constructors.
ALTER TABLE results DROP constructorName;
DROP TABLE constructors;