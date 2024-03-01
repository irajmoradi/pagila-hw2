/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN (
    SELECT DISTINCT inv.film_id
    FROM inventory inv
    JOIN rental r ON inv.inventory_id = r.inventory_id
    JOIN customer c ON r.customer_id = c.customer_id
    JOIN address a ON c.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    WHERE co.country ILIKE '%United States%'
) AS rented_in_us ON f.film_id = rented_in_us.film_id
WHERE rented_in_us.film_id IS NULL
ORDER BY f.title;

