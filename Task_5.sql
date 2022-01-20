SELECT
    vacancy_id, v.title, count(*)
FROM
    reply
LEFT JOIN
    vacancy v on reply.vacancy_id = v.id
WHERE
    reply.placement_time <= (
    SELECT
        placement_time
    FROM
        vacancy
    WHERE id = reply.vacancy_id
    ) + interval '7 days'
GROUP BY
    vacancy_id, v.title
HAVING count(*) > 5;
