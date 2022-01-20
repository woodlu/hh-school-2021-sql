-- Вакансии: индекс для быстрого поиска вакансий из определённого города(area_id)
CREATE INDEX area_id_index ON vacancy(area_id);
-- Вакансии: индекс для быстрого поиска вакансий по времени публикования(placement_time)
CREATE INDEX placement_time_index ON vacancy(placement_time);
-- Вакансии: индекс для быстрого поиска вакансий по зарплате
CREATE INDEX compensation_index ON vacancy(compensation_form, compensation_to);

-- такие же индексы можно сделать и для резюме

-- Отклики: индекс для поиска наиболее новых откликнувшихся резюме
CREATE INDEX placement_time_index ON reply(placement_time);