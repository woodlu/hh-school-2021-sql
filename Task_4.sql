SELECT pm_date, values, type FROM (
    SELECT to_char(placement_time, 'YYYY-MM') AS pm_date, count(*) AS values, 'vacancy' as type FROM vacancy
    GROUP BY to_char(placement_time, 'YYYY-MM')
    ORDER BY count(*) DESC LIMIT 1
) as vac_max UNION (
    SELECT to_char(placement_time, 'YYYY-MM'), count(*), 'resume' FROM resume GROUP BY to_char(placement_time, 'YYYY-MM') ORDER BY count(*) DESC LIMIT 1
);