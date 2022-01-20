CREATE TABLE company
(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    area_id INTEGER NOT NULL,
    rating REAL,
    description TEXT
);

CREATE TABLE area
(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100)
);

CREATE TABLE vacancy
(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    compensation_form INTEGER,
    compensation_to INTEGER,
    compensation_gross BOOLEAN,
    placement_time timestamp(0) DEFAULT NOW(),
    company_id INTEGER NOT NULL,
    area_id INTEGER NOT NULL,
    description TEXT,
    FOREIGN KEY (company_id) REFERENCES company(id) ON DELETE CASCADE,
    FOREIGN KEY (area_id) REFERENCES area(id) ON DELETE CASCADE
);

CREATE TABLE resume
(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    compensation INTEGER,
    placement_time timestamp(0) DEFAULT NOW(),
    gender BOOLEAN NOT NULL,
    birth DATE NOT NULL,
    area_id INTEGER NOT NULL,
    experience TEXT,
    about TEXT
);

CREATE TABLE specialization
(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100)
);

CREATE TABLE reply
(
    vacancy_id INTEGER NOT NULL,
    resume_id INTEGER NOT NULL,
    placement_time timestamp(0) DEFAULT NOW(),
    FOREIGN KEY (vacancy_id) REFERENCES vacancy(id) ON DELETE CASCADE,
    FOREIGN KEY (resume_id) REFERENCES resume(id) ON DELETE CASCADE,
    PRIMARY KEY (vacancy_id, resume_id)
);

CREATE TABLE resume_specialization
(
    resume_id INTEGER NOT NULL,
    specialization_id INTEGER NOT NULL,
    FOREIGN KEY (resume_id) REFERENCES resume(id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES specialization(id) ON DELETE CASCADE,
    PRIMARY KEY (resume_id, specialization_id)
);

CREATE TABLE vacancy_specialization
(
    vacancy_id INTEGER NOT NULL,
    specialization_id INTEGER NOT NULL,
    FOREIGN KEY (vacancy_id) REFERENCES vacancy(id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES specialization(id) ON DELETE CASCADE,
    PRIMARY KEY (vacancy_id, specialization_id)
);
