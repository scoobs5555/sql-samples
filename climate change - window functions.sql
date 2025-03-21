-- Preview the data
SELECT * 
FROM page_visits
LIMIT 20;

-- # of distinct campaigns
SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

-- # of distinct sources
SELECT COUNT (DISTINCT utm_source)
FROM page_visits;

-- How are they related?
SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;

-- What are the distinct page names
SELECT DISTINCT page_name
FROM page_visits;

-- Display first touches for each campaign
WITH first_touch AS (
  SELECT user_id,
    MIN(timestamp) AS 'first_touch_at'
  FROM page_visits
  GROUP BY 1  
),
ft_attr AS(
SELECT
  ft.user_id, ft.first_touch_at,
  pv.utm_campaign, pv.utm_source
FROM first_touch as ft
JOIN page_visits as pv
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp
)
SELECT
  ft_attr.utm_campaign,
  ft_attr.utm_source,
  COUNT(*)
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;  

-- Display last touches for each campaign for visitors who made a purchase
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id),
lt_attr AS (    
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp)
SELECT
  lt_attr.utm_campaign, lt_attr.utm_source,
  COUNT(*)
  FROM lt_attr
  GROUP BY 1,2
  ORDER BY 3 DESC;


;



