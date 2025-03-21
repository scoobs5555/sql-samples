SELECT * FROM trips;

SELECT * FROM riders;

SELECT * FROM cars;

-- Create a trip log with the trips and its users
SELECT riders.first, riders.last, trips.date, trips.pickup
FROM riders
LEFT JOIN trips
ON riders.id = trips.rider_id;

-- Create a link between the trips and cars tables
SELECT *
FROM trips
JOIN cars
ON trips.car_id = cars.id;

-- Stack the riders table on top of the riders2 table
SELECT *
FROM riders
UNION
SELECT *
FROM riders2;

-- What is the average cost for a trip
SELECT AVG(cost)
FROM trips;

-- Find all the riders who have used Lyft less than 500 times
SELECT *
FROM riders
WHERE total_trips < 500;

-- Calculate the number of cars that are active
SELECT COUNT(*)
FROM cars
WHERE status = 'active';

-- Find the 2 cars that have the highest trips_completed
SELECT *
FROM cars
ORDER BY trips_completed DESC
LIMIT 2;