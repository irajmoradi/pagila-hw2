/*
 * This problem is the same as 05.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT a.last_name, a.first_name
FROM actor a
LEFT JOIN customer c ON a.last_name = c.last_name AND a.first_name = c.first_name
WHERE c.last_name IS NULL AND c.first_name IS NULL
ORDER BY last_name, first_name;

