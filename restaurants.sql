-- Preview the data
SELECT *
FROM places;

SELECT *
FROM reviews;

-- Find all places that cost $20 or less
SELECT *
FROM places
WHERE price_point = "$"
OR price_point = "$$";

-- Join the two tables with an inner join
SELECT name, average_rating, reviews.username,
  reviews.rating, reviews.review_date, reviews.note
FROM places
INNER JOIN reviews
ON places.id = reviews.place_id;

-- Join the two tables with a left join
SELECT name, average_rating, reviews.username,
  reviews.rating, reviews.review_date, reviews.note
FROM places
LEFT JOIN reviews
ON places.id = reviews.place_id;

-- Find all the id's of places without reviews
SELECT places.id, places.name
FROM places
LEFT JOIN reviews
ON places.id = reviews.place_id
WHERE reviews.place_id IS NULL;

-- Select all the reviews from 2020 and join with the places table
WITH reviews_2020 AS (
  SELECT * 
  FROM reviews
  WHERE strftime('%Y', review_date) = "2020"
)
SELECT places.name,
reviews_2020.username,
reviews_2020.rating,
reviews_2020.review_date
FROM places
JOIN reviews_2020
ON places.id = reviews_2020.place_id;

-- Find the reviewer with the most reviews that are below the average rating
SELECT reviews.username, COUNT(reviews.id) AS review_count
FROM reviews
JOIN places ON reviews.place_id = places.id
WHERE reviews.rating < (SELECT AVG(average_rating) FROM places)
GROUP BY reviews.username
ORDER BY review_count DESC
LIMIT 1;


