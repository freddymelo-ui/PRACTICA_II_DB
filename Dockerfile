# Imagen base oficial de Postgres
FROM postgres:15

# Variables de entorno para crear la BD inicial
ENV POSTGRES_USER=Usuario
ENV POSTGRES_PASSWORD=12345
ENV POSTGRES_DB=Schema_PracticeDB

# Copiar todos los scripts SQL de inicialización
# Se ejecuta automáticamente al iniciar por primera vez el contenedor
COPY ./*.sql /docker-entrypoint-initdb.d/

EXPOSE 5432