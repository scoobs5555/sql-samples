-- Preview the data
SELECT * 
FROM employees
LIMIT 10;

SELECT *
FROM projects
LIMIT 10;

-- Employees who have not chosen a project
SELECT first_name, last_name
FROM employees
WHERE current_project IS NULL;

-- Names of project that were not chosen by any employee
SELECT project_name
FROM projects
WHERE project_id NOT IN (
  SELECT current_project
  FROM employees
  WHERE current_project IS NOT NULL
);

-- Find name of project chosen by the most employees
SELECT projects.project_name, COUNT(employees.current_project)
FROM projects
JOIN employees
ON projects.project_id = employees.current_project
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Projects chosen by multiple employees
SELECT project_name
FROM projects
JOIN employees
ON projects.project_id = employees.current_project
WHERE employees.current_project IS NOT NULL
GROUP BY current_project
HAVING COUNT(employees.current_project) >1;

-- How many available project positions for developpers? (min 2 developers per project)
SELECT (COUNT(*) * 2) - (
  SELECT COUNT(*)
  FROM employees
  WHERE current_project IS NOT NULL
    AND position = 'Developer') AS 'Count'
FROM projects;

-- Most common personality
SELECT personality
FROM employees
GROUP BY personality
ORDER BY COUNT(personality) DESC
LIMIT 1;

-- Names of projects chosen by employees with the most common personality type
SELECT project_name
FROM projects
JOIN employees
  ON projects.project_id = employees.current_project
WHERE personality = (
  SELECT personality
  FROM employees
  GROUP BY personality
  ORDER BY COUNT(personality) DESC
  LIMIT 1);

-- Personality type most represented by employees with a selected project
SELECT last_name, first_name, personality, project_name
FROM employees
INNER JOIN projects 
  ON employees.current_project = projects.project_id
WHERE personality = (
   SELECT personality 
   FROM employees
   WHERE current_project IS NOT NULL
   GROUP BY personality
   ORDER BY COUNT(personality) DESC
   LIMIT 1);
   
   
