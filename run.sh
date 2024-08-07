#!/bin/bash

DB_USER="postgres"
DB_NAME="postgres"
DB_HOST="localhost"
DB_PORT="5432"
export PGPASSWORD="postgres"

echo "Creating db structure"
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "SET CLIENT_ENCODING TO 'UTF8';" -f "./migrations/0-db_structure.sql"

read -p "Press enter to continue"

echo "Inserting data into sample base"
for sql_file in ./migrations/1-insert_base/*.sql; do
  psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "SET CLIENT_ENCODING TO 'UTF8';" -f "$sql_file"
done

read -p "Press enter to continue"

echo "Inserting partitioned data"
psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "SET CLIENT_ENCODING TO 'UTF8';" -f "./migrations/2-insert_radares.sql"
for sql_file in ./migrations/3-insert_leituras/*.sql; do
  psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -p "$DB_PORT" -c "SET CLIENT_ENCODING TO 'UTF8';" -f "$sql_file"
done

read -p "Press enter to continue"

echo "Creating indexes"
# TODO

unset PGPASSWORD
