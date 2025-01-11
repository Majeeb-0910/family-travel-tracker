
-- Family Travel Tracker DB SETUP --


-- the Country Code is a 2 letter code for each country -- 
-- to create the table and insert data using a csv file use the following -- 

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    country_code CHAR(2) NOT NULL,
    country_name VARCHAR(50) NOT NULL
);

COPY countries (id, country_code, country_name)
FROM 'D:/path/to/your/countries.csv' -- replace with the path to your csv file
DELIMITER ','
CSV HEADER;


DROP TABLE IF EXISTS visited_countries, users;

CREATE TABLE users(
id SERIAL PRIMARY KEY,
name VARCHAR(15) UNIQUE NOT NULL,
color VARCHAR(15)
);

CREATE TABLE visited_countries(
id SERIAL PRIMARY KEY,
country_code CHAR(2) NOT NULL,
user_id INTEGER REFERENCES users(id)
);

INSERT INTO users (name, color)
VALUES ('Majeeb', 'teal'), ('Abdul', 'powderblue');

INSERT INTO visited_countries (country_code, user_id)
VALUES ('FR', 1), ('IN', 1), ('CA', 2), ('IN', 2 );

SELECT *
FROM visited_countries
JOIN users
ON users.id = user_id;

-- LIST OF COUNTRIES VISITED BY EACH USER ordered by user id--

SELECT u.name, u.id, vc.id as vc_id, vc.country_code, c.country_name
FROM visited_countries AS vc
JOIN users AS u ON vc.user_id = u.id
JOIN countries AS c ON vc.country_code = c.country_code
ORDER BY u.id;