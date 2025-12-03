-- DML para tablas de atributos compuestos (No tienen FK externas)
INSERT INTO POP_YEAR (pop, year) VALUES 
(5000000, 2023), -- pop: 5M, year: 2023
(1000000, 2022), -- pop: 1M, year: 2022
(800000, 2023);  -- pop: 800K, year: 2023

INSERT INTO COORDINATES (latitude, longitude) VALUES 
(13.500000, 34.500000),      -- Capital C01
(40.712800, -74.006000),     -- Capital C02
(2.500000, 34.000000),       -- Lago Malawi
(45.000000, 15.000000),      -- Río Amazonas
(10.000000, 10.000000),      -- Coord. genérica
(10.000000, -80.000000),     -- Capital C03
(0.000000, 30.000000),       -- Lago Tanganica
(1.000000, 33.000000),       -- Lago Victoria
(30.000000, 31.000000),      -- Río Nilo
(38.000000, -90.000000);     -- Río Misisipi

-- Entidades Fuertes (que no dependen de COUNTRY o CITY)
INSERT INTO CONTINENT (name, area) VALUES 
('Asia', 44614000.00),
('África', 30365000.00),
('América del Norte', 24230000.00);

INSERT INTO ORGANIZATION (abbrev, name, type, establi) VALUES 
('UN', 'Naciones Unidas', 'Global', 1945),
('EU', 'Unión Europea', 'Regional', 1993);

INSERT INTO LANGUAGE (name) VALUES 
('Español'),
('Inglés'),
('Francés');

INSERT INTO ETHNIC_GRP (name) VALUES 
('Mayoría A'),
('Minoría B');

INSERT INTO RELIGION (name) VALUES 
('Cristianismo'),
('Islam');

INSERT INTO SEA (name, depth) VALUES 
('Mar Mediterráneo', 1500.00),
('Mar Caribe', 2500.00);

-------------------------------------------------------------------------------
-- PASO 1: Insertar Países (COUNTRY) sin referencia a la capital (usando NULL)
-------------------------------------------------------------------------------
INSERT INTO COUNTRY (code, name, governtm, indep_date, gdp, gdp_agr, gdp_ind, gdp_serv, unemploym, localname, pop, pop_stat, pop_grw, inf_mort, capital_city_name, capital_city_localname, capital_city_pop, capital_city_year, is_member_of_abbrev) VALUES 
('C01', 'País Agrícola', 'República', '1960-01-01', 100000.00, 55000.00, 20000.00, 25000.00, 5.50, 'AgriLand', 5000000, 5000000, 1.50, 20.5, NULL, NULL, NULL, NULL, 'UN'), 
('C02', 'País Industrial', 'Monarquía', '1776-07-04', 500000.00, 50000.00, 300000.00, 150000.00, 4.00, 'IndusNation', 80000000, 80000000, 0.80, 5.0, NULL, NULL, NULL, NULL, 'UN'), 
('C03', 'País de Servicios', 'Democracia', '1990-10-03', 200000.00, 10000.00, 50000.00, 140000.00, 7.00, 'ServiceRep', 10000000, 10000000, 2.00, 15.0, NULL, NULL, NULL, NULL, 'EU');

-------------------------------------------------------------------------------
-- PASO 2: Insertar Ciudades Capitales (Ahora que los países existen, la FK funciona)
-------------------------------------------------------------------------------
INSERT INTO CITY (name, localname, pop, year, coordinates_lat, coordinates_lon, elevation, country_code) VALUES 
('Capital C01', 'Cap C01', 1000000, 2022, 13.500000, 34.500000, 500.00, 'C01'), 
('Capital C02', 'Cap C02', 5000000, 2023, 40.712800, -74.006000, 10.00, 'C02'),
('Capital C03', 'Cap C03', 800000, 2023, 10.000000, -80.000000, 50.00, 'C03');

-------------------------------------------------------------------------------
-- PASO 3: Actualizar los Países (COUNTRY) con la referencia a su capital
-------------------------------------------------------------------------------
UPDATE COUNTRY
SET capital_city_name = 'Capital C01',
    capital_city_localname = 'Cap C01',
    capital_city_pop = 1000000,
    capital_city_year = 2022
WHERE code = 'C01';

UPDATE COUNTRY
SET capital_city_name = 'Capital C02',
    capital_city_localname = 'Cap C02',
    capital_city_pop = 5000000,
    capital_city_year = 2023
WHERE code = 'C02';

UPDATE COUNTRY
SET capital_city_name = 'Capital C03',
    capital_city_localname = 'Cap C03',
    capital_city_pop = 800000,
    capital_city_year = 2023
WHERE code = 'C03';

-------------------------------------------------------------------------------
-- Insertar Cuerpos de Agua y Tierra (Ahora que los países existen)
-------------------------------------------------------------------------------
INSERT INTO LAKE (name, elevation, depth, area, type, coordinates_lat, coordinates_lon, country_code) VALUES 
('Malawi', 475.00, 706.00, 29600.00, 'Rift', 2.500000, 34.000000, 'C01'), 
('Tanganica', 782.00, 1470.00, 32900.00, 'Rift', 0.000000, 30.000000, 'C01'), 
('Victoria', 1134.00, 84.00, 68870.00, 'Tectónico', 1.000000, 33.000000, 'C01');

INSERT INTO RIVER (name, length, area, depth, coordinates_lat, coordinates_lon, country_code) VALUES 
('Amazonas', 6992.00, 7050000.00, 50.00, 45.000000, 15.000000, 'C01'), 
('Nilo', 6650.00, 3349000.00, 20.00, 30.000000, 31.000000, 'C02'),
('Misisipi', 3734.00, 3238000.00, 15.00, 38.000000, -90.000000, 'C02');

-------------------------------------------------------------------------------
-- Insertar Tablas de Relaciones (Ahora que las entidades existen)
-------------------------------------------------------------------------------
INSERT INTO COUNTRY_BORDERS (country_code_1, country_code_2) VALUES 
('C01', 'C02'),
('C02', 'C01'),
('C01', 'C03'),
('C03', 'C01');

INSERT INTO COUNTRY_LANGUAGE (country_code, lang_name, percentt, speak) VALUES 
('C01', 'Español', 95.00, TRUE),
('C02', 'Inglés', 80.00, TRUE),
('C03', 'Francés', 70.00, TRUE),
('C01', 'Inglés', 5.00, TRUE);

INSERT INTO COUNTRY_ETHNIC_GRP (country_code, grp_name, percentt, belong) VALUES 
('C01', 'Mayoría A', 70.00, TRUE),
('C01', 'Minoría B', 30.00, TRUE),
('C02', 'Mayoría A', 90.00, TRUE);

INSERT INTO COUNTRY_RELIGION (country_code, rel_name, percentt, believe) VALUES 
('C01', 'Cristianismo', 85.00, TRUE),
('C02', 'Islam', 75.00, TRUE),
('C03', 'Cristianismo', 50.00, TRUE);

INSERT INTO RIVER_ON_SEA (river_name, sea_name) VALUES 
('Nilo', 'Mar Mediterráneo');

INSERT INTO RIVER_ON_LAKE (river_name, lake_name) VALUES 
('Amazonas', 'Victoria');


-- Limpieza de datos antes de la carga inicial
TRUNCATE TABLE 
    -- Relaciones (Hijas)
    COUNTRY_BORDERS, 
    COUNTRY_LANGUAGE, 
    COUNTRY_ETHNIC_GRP, 
    COUNTRY_RELIGION,
    RIVER_ON_SEA, 
    RIVER_ON_LAKE, 

    -- Entidades que referencian a COUNTRY/COORDINATES/POP_YEAR
    CITY, 
    LAKE, 
    RIVER, 

    -- Entidades Principales
    COUNTRY, 
    ORGANIZATION, 
    LANGUAGE, 
    ETHNIC_GRP, 
    RELIGION, 
    SEA, 
    CONTINENT,
    
    -- Atributos compuestos
    POP_YEAR,
    COORDINATES

-- Opciones de PostgreSQL:
RESTART IDENTITY -- Reinicia cualquier contador de secuencia (Serial/Auto-Incremento)
CASCADE;          -- Elimina filas en tablas dependientes (Claves Foráneas)