-- Preview the tables
SELECT *
FROM users
LIMIT 10;

SELECT *
FROM posts
LIMIT 10;

SELECT *
FROM subreddits
LIMIT 10;

-- Count of how many subreddits
SELECT COUNT(id)
FROM subreddits;

-- User with the highest score
SELECT *
FROM users
ORDER BY score DESC
LIMIT 1;

-- Post with the highest score
SELECT *
FROM posts
ORDER BY score DESC
LIMIT 1;

-- Top 5 subreddits with the highest subscriber_count
SELECT *
FROM subreddits
ORDER BY subscriber_count DESC
LIMIT 5;

-- Find users with highest number of posts
SELECT users.username, COUNT(posts.user_id)
FROM users
LEFT JOIN posts
ON users.id = posts.user_id
GROUP BY users.id
ORDER BY 2 DESC;

-- View only existing posts with active users
SELECT *
FROM posts
JOIN users
ON posts.user_id = users.id;

-- Stack posts2 under existing posts table
SELECT *
FROM posts
UNION
SELECT *
FROM posts2;

-- Find out which subreddits have the most popular posts (score at least 5000)
WITH popular_posts AS (
  SELECT *
  FROM posts
  WHERE score > 5000
)
SELECT subreddits.name, popular_posts.title, popular_posts.score
FROM subreddits
INNER JOIN popular_posts
ON popular_posts.subreddit_id = subreddits.id
ORDER BY popular_posts.score DESC;

-- find out the highest scoring post for each subreddit
SELECT posts.title, subreddits.name, MAX(posts.score)
FROM posts
JOIN subreddits
ON subreddits.id = posts.subreddit_id
GROUP BY subreddits.id;

-- Calculate the average score of all the posts for each subreddit
SELECT subreddits.id, subreddits.name, ROUND(AVG(posts.score),1)
FROM subreddits
JOIN posts
ON posts.subreddit_id = subreddits.id
GROUP BY subreddits.id
ORDER BY 3 DESC;

