/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
 */
SELECT special_feature as special_features, COUNT(*)
FROM (
  SELECT unnest(special_features) AS special_feature
  FROM film
) AS sf
GROUP BY special_feature
ORDER BY special_feature;

