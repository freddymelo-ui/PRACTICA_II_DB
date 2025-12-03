-- Tabla para atributos compuestos (POP_YEAR y COORDINATES)

CREATE TABLE POP_YEAR (
    pop INT,
    year INT,
    PRIMARY KEY (pop, year)
);

CREATE TABLE COORDINATES (
    latitude NUMERIC(9, 6),
    longitude NUMERIC(9, 6),
    PRIMARY KEY (latitude, longitude)
);

-- Entidades Fuertes

CREATE TABLE COUNTRY (
    code CHAR(3) PRIMARY KEY,
    name VARCHAR(100),
    governtm VARCHAR(100),
    indep_date DATE,
    gdp NUMERIC(15, 2),
    gdp_agr NUMERIC(15, 2),
    gdp_ind NUMERIC(15, 2),
    gdp_serv NUMERIC(15, 2),
    unemploym NUMERIC(5, 2),
    localname VARCHAR(100),
    pop INT,
    pop_stat INT,
    pop_grw NUMERIC(5, 2),
    inf_mort NUMERIC(5, 2),
    -- FK para la relación 1:1 'capital'
    capital_city_name VARCHAR(100),
    capital_city_localname VARCHAR(100),
    capital_city_pop INT,
    capital_city_year INT,
    -- FK para la relación 1:N 'is member'
    is_member_of_abbrev VARCHAR(10) 
);

CREATE TABLE ORGANIZATION (
    abbrev VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    establi INT
);

CREATE TABLE CONTINENT (
    name VARCHAR(50) PRIMARY KEY,
    area NUMERIC(15, 2)
);

CREATE TABLE LANGUAGE (
    name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE ETHNIC_GRP (
    name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE RELIGION (
    name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE CITY (
    name VARCHAR(100),
    localname VARCHAR(100),
    pop INT,
    year INT,
    coordinates_lat NUMERIC(9, 6),
    coordinates_lon NUMERIC(9, 6),
    elevation NUMERIC(10, 2),
    country_code CHAR(3) NOT NULL, -- FK de la relación 1:N 'in'
    PRIMARY KEY (name, localname, pop, year), -- Clave compuesta
    FOREIGN KEY (pop, year) REFERENCES POP_YEAR (pop, year),
    FOREIGN KEY (coordinates_lat, coordinates_lon) REFERENCES COORDINATES (latitude, longitude),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code)
);

-- Tablas de Cuerpos de Agua y Tierra

CREATE TABLE LAKE (
    name VARCHAR(100) PRIMARY KEY,
    elevation NUMERIC(10, 2),
    depth NUMERIC(10, 2),
    area NUMERIC(15, 2),
    type VARCHAR(50),
    coordinates_lat NUMERIC(9, 6),
    coordinates_lon NUMERIC(9, 6),
    country_code CHAR(3), -- FK de la relación 1:N 'in'
    FOREIGN KEY (coordinates_lat, coordinates_lon) REFERENCES COORDINATES (latitude, longitude),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code)
);

CREATE TABLE RIVER (
    name VARCHAR(100) PRIMARY KEY,
    length NUMERIC(10, 2),
    area NUMERIC(15, 2),
    depth NUMERIC(10, 2),
    coordinates_lat NUMERIC(9, 6),
    coordinates_lon NUMERIC(9, 6),
    country_code CHAR(3), -- FK de la relación 1:N 'in'
    FOREIGN KEY (coordinates_lat, coordinates_lon) REFERENCES COORDINATES (latitude, longitude),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code)
);

CREATE TABLE ESTUARY (
    name VARCHAR(100) PRIMARY KEY,
    elevation NUMERIC(10, 2),
    coordinates_lat NUMERIC(9, 6),
    coordinates_lon NUMERIC(9, 6),
    country_code CHAR(3), -- FK de la relación 1:N 'in'
    FOREIGN KEY (coordinates_lat, coordinates_lon) REFERENCES COORDINATES (latitude, longitude),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code)
);

CREATE TABLE SEA (
    name VARCHAR(100) PRIMARY KEY,
    depth NUMERIC(10, 2)
);

CREATE TABLE ISLAND (
    name VARCHAR(100) PRIMARY KEY,
    area NUMERIC(15, 2),
    type VARCHAR(50),
    elevation NUMERIC(10, 2),
    coordinates_lat NUMERIC(9, 6),
    coordinates_lon NUMERIC(9, 6),
    country_code CHAR(3), -- FK de la relación 1:N 'in'
    FOREIGN KEY (coordinates_lat, coordinates_lon) REFERENCES COORDINATES (latitude, longitude),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code)
);

CREATE TABLE MOUNTAIN (
    name VARCHAR(100) PRIMARY KEY,
    type VARCHAR(50),
    elevation NUMERIC(10, 2),
    coordinates_lat NUMERIC(9, 6),
    coordinates_lon NUMERIC(9, 6),
    country_code CHAR(3), -- FK de la relación 1:N 'in'
    FOREIGN KEY (coordinates_lat, coordinates_lon) REFERENCES COORDINATES (latitude, longitude),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code)
);

CREATE TABLE DESERT (
    name VARCHAR(100) PRIMARY KEY,
    area NUMERIC(15, 2),
    coordinates_lat NUMERIC(9, 6),
    coordinates_lon NUMERIC(9, 6),
    country_code CHAR(3), -- FK de la relación 1:N 'in'
    FOREIGN KEY (coordinates_lat, coordinates_lon) REFERENCES COORDINATES (latitude, longitude),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code)
);

CREATE TABLE SOURCE (
    name VARCHAR(100) PRIMARY KEY,
    elevation NUMERIC(10, 2),
    coordinates_lat NUMERIC(9, 6),
    coordinates_lon NUMERIC(9, 6),
    FOREIGN KEY (coordinates_lat, coordinates_lon) REFERENCES COORDINATES (latitude, longitude)
);

--FK pendientes de COUNTRY
ALTER TABLE COUNTRY
ADD FOREIGN KEY (capital_city_name, capital_city_localname, capital_city_pop, capital_city_year)
REFERENCES CITY (name, localname, pop, year);

ALTER TABLE COUNTRY
ADD FOREIGN KEY (is_member_of_abbrev)
REFERENCES ORGANIZATION (abbrev);

-------------------------------------------------------------------------------
-- Tablas de Relaciones
-------------------------------------------------------------------------------
CREATE TABLE COUNTRY_BORDERS (
    country_code_1 CHAR(3) NOT NULL,
    country_code_2 CHAR(3) NOT NULL,
    PRIMARY KEY (country_code_1, country_code_2),
    FOREIGN KEY (country_code_1) REFERENCES COUNTRY (code),
    FOREIGN KEY (country_code_2) REFERENCES COUNTRY (code)
);

CREATE TABLE COUNTRY_LANGUAGE (
    country_code CHAR(3) NOT NULL,
    lang_name VARCHAR(50) NOT NULL,
    percentt NUMERIC(5, 2),
    speak BOOLEAN, -- Asumiendo que 'speak' es un atributo booleano/flag
    PRIMARY KEY (country_code, lang_name),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code),
    FOREIGN KEY (lang_name) REFERENCES LANGUAGE (name)
);

CREATE TABLE COUNTRY_ETHNIC_GRP (
    country_code CHAR(3) NOT NULL,
    grp_name VARCHAR(50) NOT NULL,
    percentt NUMERIC(5, 2),
    belong BOOLEAN, -- Asumiendo que 'belong' es un atributo booleano/flag
    PRIMARY KEY (country_code, grp_name),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code),
    FOREIGN KEY (grp_name) REFERENCES ETHNIC_GRP (name)
);

CREATE TABLE COUNTRY_RELIGION (
    country_code CHAR(3) NOT NULL,
    rel_name VARCHAR(50) NOT NULL,
    percentt NUMERIC(5, 2),
    believe BOOLEAN, -- Asumiendo que 'believe' es un atributo booleano/flag
    PRIMARY KEY (country_code, rel_name),
    FOREIGN KEY (country_code) REFERENCES COUNTRY (code),
    FOREIGN KEY (rel_name) REFERENCES RELIGION (name)
);

CREATE TABLE RIVER_ON_SEA (
    river_name VARCHAR(100) NOT NULL,
    sea_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (river_name, sea_name),
    FOREIGN KEY (river_name) REFERENCES RIVER (name),
    FOREIGN KEY (sea_name) REFERENCES SEA (name)
);

CREATE TABLE RIVER_ON_LAKE (
    river_name VARCHAR(100) NOT NULL,
    lake_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (river_name, lake_name),
    FOREIGN KEY (river_name) REFERENCES RIVER (name),
    FOREIGN KEY (lake_name) REFERENCES LAKE (name)
);

CREATE TABLE RIVER_TO_ESTUARY (
    river_name VARCHAR(100) NOT NULL,
    estuary_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (river_name, estuary_name),
    FOREIGN KEY (river_name) REFERENCES RIVER (name),
    FOREIGN KEY (estuary_name) REFERENCES ESTUARY (name)
);

CREATE TABLE ISLAND_IN_SEA (
    island_name VARCHAR(100) NOT NULL,
    sea_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (island_name, sea_name),
    FOREIGN KEY (island_name) REFERENCES ISLAND (name),
    FOREIGN KEY (sea_name) REFERENCES SEA (name)
);

