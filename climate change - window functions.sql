-- Preview the data
SELECT * 
FROM state_climate
LIMIT 10;

-- How average temperature changes over time in each state
SELECT state, year, tempf, AVG(tempf) 
OVER (PARTITION BY state) AS 'running_avg_temp'
FROM state_climate
ORDER BY year
LIMIT 10;

-- Lowest temperatures for each state
SELECT state, year, tempf,
FIRST_VALUE(tempf) OVER (PARTITION BY state
ORDER BY tempf) 
AS 'lowest_temp'
FROM state_climate
LIMIT 10;

-- Highest temperatures for each state
SELECT state, year, tempf,
LAST_VALUE(tempf) OVER (PARTITION BY state ORDER BY tempf
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'highest_temp'
FROM state_climate
LIMIT 10;

-- Temperature change each year in each state
SELECT state, year, tempf,
tempf - LAG(tempf, 1, tempf) 
OVER (PARTITION BY state ORDER BY year) AS 'change_in_temp'
FROM state_climate
ORDER BY change_in_temp DESC
LIMIT 10;

-- Rank the coldest temperatures on record
SELECT state, year, tempf,
RANK() OVER (ORDER BY tempf)
AS 'rank'
FROM state_climate
LIMIT 10;

-- Rank the warmest for each state
SELECT state, year, tempf,
RANK() OVER (PARTITION BY state ORDER BY tempf DESC)
AS warmest_rank
FROM state_climate
LIMIT 10;

-- Average yearly temperatures in quartiles by state
SELECT NTILE(4) OVER (PARTITION BY state ORDER BY tempf)
AS quartile, year, state, tempf
FROM state_climate
LIMIT 10;

-- Average yearly temperatures in quintiles
SELECT NTILE(5) OVER (ORDER BY tempf)
AS quintile, year, state, tempf
FROM state_climate
LIMIT 10;


