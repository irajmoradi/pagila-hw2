/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */
SELECT
  DATE_PART('year', rental.rental_date) AS "Year",
  DATE_PART('month', rental.rental_date) AS "Month",
  SUM(payment.amount) AS "Total Revenue"
FROM rental
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY ROLLUP (DATE_PART('year', rental.rental_date), DATE_PART('month', rental.rental_date))
ORDER BY "Year", "Month";

