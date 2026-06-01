#!/bin/bash
DB_USER="postgres"
DB_NAME="postgres"
DB_HOST="localhost"
DB_PORT="5432"

# Pulls your saved password from your environment setup
export PGPASSWORD="YOUR_REAL_PASSWORD_HERE"
PSQL_EXE="/c/Program Files/PostgreSQL/18/bin/psql.exe"

echo "Database Cleaner Service Started..."

while true; do
    # Deletes logs older than 5 minutes to preserve disk space
    "$PSQL_EXE" -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c \
    "DELETE FROM public.sensor_readings WHERE reading_time < NOW() - INTERVAL '5 minutes';"
    
    echo "Wiped logs older than 5 minutes. Next clean in 60 seconds."
    sleep 60
done
