#!/bin/bash

DB_USER="postgres"
DB_NAME="postgres"
DB_HOST="localhost"
DB_PORT="5432"
export PGPASSWORD="140301"

for sql_file in ./migrations/*.sql; do
  psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "SET CLIENT_ENCODING TO 'UTF8';" -f "$sql_file"
done

for sql_file in ./migrations/1-insert_base/*.sql; do
  psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "SET CLIENT_ENCODING TO 'UTF8';" -f "$sql_file"
done

for sql_file in ./migrations/3-insert_leituras/*.sql; do
  psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "SET CLIENT_ENCODING TO 'UTF8';" -f "$sql_file"
done
