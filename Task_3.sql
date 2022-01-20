SELECT
    area_id,
    avg(compensation_form) AS avg_from,
    avg(compensation_to) AS avg_to,
    avg((compensation_form + compensation_to) / 2) AS avg_total
FROM
    vacancy
GROUP BY
    area_id;
