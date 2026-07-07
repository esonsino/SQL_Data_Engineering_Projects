CREATE DATABASE jobs_mart;

SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS jobs_mart;

--DROP DATABASE IF EXISTS jobs_mart;
SHOW schemas;

SELECT
    *
FROM
    information_schema.schemata;

CREATE schema jobs_mart.staging;

USE jobs_mart;

--drop schema staging;
CREATE TABLE staging.preferred_roles (role_id INTEGER, role_name VARCHAR);

SELECT
    *
FROM
    information_schema.tables
WHERE
    table_catalog = 'jobs_mart';

DROP TABLE jobs_mart.main.preferred_roles;