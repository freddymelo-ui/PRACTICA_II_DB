--1.  ¿Cuál es el nombre y la superficie terrestre de cada continente? 

SELECT 
    name, 
    area
FROM 
    CONTINENT;

--2.  ¿Cuál es la superficie y la profundidad del lago Malawi? 

SELECT 
    area, 
    depth
FROM 
    LAKE
WHERE 
    name = 'Malawi';

--3.  ¿Cuáles son los nombres y la superficie de todos los lagos en orden decreciente de profundidad? 

SELECT 
    name, 
    area
FROM 
    LAKE
ORDER BY 
    depth DESC;

--4.  ¿Cuál es el nombre de los países donde la agricultura representa al menos el 50% del producto interno bruto? -- use INNER JOIN ... ON 

SELECT 
    T1.name
FROM 
    COUNTRY AS T1 
INNER JOIN 
    COUNTRY AS T2 
ON 
    T1.code = T2.code
WHERE 
    (T1.gdp_agr / T1.gdp) >= 0.50;

--5.  ¿Cómo se llama el río más largo? -- use una subconsulta

SELECT 
    name
FROM 
    RIVER
WHERE 
    length = (SELECT MAX(length) FROM RIVER);