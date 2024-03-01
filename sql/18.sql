/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
WITH RevenueCalculation AS (
    SELECT 
        f.title,
        COALESCE(SUM(p.amount), 0.00) AS revenue
    FROM film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY f.title
),
TotalRevenue AS (
    SELECT SUM(revenue) AS total FROM RevenueCalculation
),
RevenueWithRank AS (
    SELECT
        title,
        revenue,
        RANK() OVER (ORDER BY revenue DESC) AS rank,
        SUM(revenue) OVER (ORDER BY revenue DESC) AS "total revenue"
    FROM RevenueCalculation
),
RevenuePercent AS (
    SELECT
        rank,
        title,
        revenue,
        "total revenue",
        100.0 * "total revenue" / (SELECT total FROM TotalRevenue) AS "revenue percent"
    FROM RevenueWithRank
)
SELECT 
    rank,
    title,
    revenue,
    "total revenue",
    CASE 
        WHEN "revenue percent" >= 100 THEN '100.00' -- Adjusted for clarity and accuracy
        ELSE TO_CHAR("revenue percent", 'FM00.00') -- Ensures two leading digits
    END AS "percent revenue"
FROM RevenuePercent
ORDER BY rank, title; -- Order by rank for clarity in ranking sequence

