/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */
SELECT DISTINCT UPPER(first_name || ' ' || last_name) AS "Actor Name"
FROM actor
JOIN film_actor USING (actor_id)
WHERE film_id IN
(
  SELECT film_id
  FROM film
  WHERE 'Behind the Scenes' = ANY(special_features)
)
ORDER BY "Actor Name"
;
