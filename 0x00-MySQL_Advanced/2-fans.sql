--  script that ranks country origins of bands, ordered by the number of (non-unique) fans

SELECT origin, SUM(nb_fans) as total_fans, RANK() OVER (ORDER BY SUM(nb_fans) DESC) as country_rank
FROM metal_bands
GROUP BY origin
ORDER BY total_fans DESC;

