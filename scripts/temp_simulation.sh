#!/bin/bash
DB_USER="postgres"
DB_NAME="postgres"   
DB_HOST="localhost"
DB_PORT="5432"
export PGPASSWORD="root"
# Tells Git Bash EXACTLY where Windows hid your PostgreSQL engine
PSQL_EXE="/c/Program Files/PostgreSQL/18/bin/psql.exe"

echo "Simulating Temperature & Connecting to IndustrialDB..."

while true; do
    temperature=$((RANDOM % 41 + 61))
    echo "Current Temperature: $temperature"
    
    if [[ $temperature -gt 60 && $temperature -lt 70 ]]; then
        status="Normal"
        echo "Normal Temperature"
    elif [[ $temperature -ge 70 && $temperature -lt 80 ]]; then
        status="Warning"
        echo "Warning: High Temperature!"
    elif [[ $temperature -ge 80 ]]; then
        status="Critical"
        echo "Critical: Temperature Too High!"  
    fi
    
    # Run the query using the exact physical path variable
    "$PSQL_EXE" -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT current_database(), current_user;" -c "INSERT INTO sensor_readings (sensor_id, reading_value, reading_time, quality_flag) VALUES (1, $temperature, NOW(), '$status');"
    
    sleep 2
done