INSERT INTO
    specialization(title)
VALUES
    ('Автомеханик'),
    ('Курьер'),
    ('Переводчик'),
    ('Секретарь'),
    ('Охранник'),
    ('Финансовый директор'),
    ('Геолог'),
    ('Водитель'),
    ('Археолог'),
    ('Менеджер по закупкам'),
    ('Аналитик'),
    ('Арт-директор'),
    ('Агроном'),
    ('Страховой агент'),
    ('Юрист'),
    ('Грузчик');

INSERT INTO
    area(title)
VALUES
    ('Москва'),
    ('Ленинград'),
    ('Сталинград'),
    ('Мурманск'),
    ('Минск'),
    ('Киев'),
    ('Брест'),
    ('Одесса'),
    ('Севастополь'),
    ('Керчь'),
    ('Новороссийск'),
    ('Смоленск'),
    ('Тула');

-- вставляем данные в таблицу резюме
with resume_data(id, title, compensation, placement_time, gender, birth, area_id, experience, about) as (
    SELECT
        generate_series(1, 110000) as id,
        (text 'resume ' || generate_series(1, 110000)::text) as title,
        round(random() * 200000 + 25000) as compensation,
        now() - random() * (timestamp '2015-01-01 00:00:00' - timestamp '2010-01-01 00:00:00') as placement_time,
        random()::int::boolean as gender,
        date '1960-01-01' + random() * (interval '40 years') as birth,
        round(random() * 12 + 1) as area_id,
        md5(random()::varchar(100)) as experience,
        md5(random()::varchar(100)) as about
)
INSERT INTO
    resume(title, compensation, placement_time, gender, birth, area_id, experience, about)
SELECT title, compensation, placement_time, gender, birth, area_id, experience, about FROM resume_data;

-- вставляем данные в таблицу компаний
with company_data(id, title, phone, area_id, rating, description) as (
    SELECT
        generate_series(1, 1000) as id,
        (text 'company ' || generate_series(1, 1000)::text) as title,
        (round(random() * 89999 + 10000))::text || (round(random() * 89999 + 10000))::text as phone,
        round(random() * 12 + 1) as area_id,
        random() * 5 as rating,
        md5(random()::varchar(100)) as description
)
INSERT INTO
    company(title, phone, area_id, rating, description)
SELECT title, phone, area_id, rating, description FROM company_data;

-- вставляем данные в таблицу вакансий
with vacancy_data(id, title, salary, gross, placement_time, company_id, area_id, description) as (
    SELECT
        generate_series(1, 12000) as id,
        (text 'vacancy ' || generate_series(1, 12000)::text) as title,
        round(random() * 200000 + 30000) as salary,
        random()::int::boolean as gross,
        now() - random() * (timestamp '2015-01-01 00:00:00' - timestamp '2010-01-01 00:00:00') as placement_time,
        round(random() * 999 + 1) as company_id,
        round(random() * 12 + 1) as area_id,
        md5(random()::varchar(100)) as description
)
INSERT INTO
    vacancy(title, compensation_form, compensation_to, compensation_gross, placement_time, company_id, area_id, description)
SELECT title, salary, salary + 25000, gross, placement_time, company_id, area_id, description FROM vacancy_data;

-- вставляем данные в таблицу откликов
DO $$
DECLARE vacID integer;
        pltime timestamp;
BEGIN
    FOR r IN 1..400000 LOOP
    SELECT round(random() * 11999 + 1) INTO vacID;
    SELECT placement_time FROM vacancy WHERE id = vacID INTO pltime;

    INSERT INTO
        reply(vacancy_id, resume_id, placement_time)
    VALUES
        (vacID, round(random() * 109999 + 1), pltime + random() * (now() - pltime)) ON CONFLICT DO NOTHING;
    END LOOP;
END $$;

-- вставляем данные в таблицу резюме_специализация
DO $$
BEGIN
    FOR r IN 1..400000 LOOP
    INSERT INTO
        resume_specialization(resume_id, specialization_id)
    VALUES
        (round(random() * 109999 + 1), round(random() * 15 + 1)) ON CONFLICT DO NOTHING;
    END LOOP;
END $$;

-- вставляем данные в таблицу вакансия_специализация
DO $$
BEGIN
    FOR r IN 1..40000 LOOP
    INSERT INTO
        vacancy_specialization(vacancy_id, specialization_id)
    VALUES
        (round(random() * 11999 + 1), round(random() * 15 + 1)) ON CONFLICT DO NOTHING;
    END LOOP;
END $$;






