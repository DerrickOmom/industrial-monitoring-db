#!/bin/bash

# ==========================================
# GENERATOR TEMPERATURE SENSOR SIMULATOR
# ==========================================

# Database configuration
DB_NAME="industrial_monitoring_db"
DB_USER="postgres"

# Sensor configuration
SENSOR_ID=1

# Initial temperature
temp=70

echo "Starting Generator Temperature Monitoring..."

# Infinite monitoring loop
while true
do
    # Generate random fluctuation between -2 and +2
    fluctuation=$(( (RANDOM % 5) - 2 ))

    # Update temperature
    temp=$(( temp + fluctuation ))

    # Enforce operating limits
    if [ $temp -lt 60 ]; then
        temp=60
    fi

    if [ $temp -gt 95 ]; then
        temp=95
    fi

    # Determine quality flag
    if [ $temp -lt 80 ]; then
        quality="GOOD"
        error="NONE"

    elif [ $temp -ge 80 ] && [ $temp -lt 90 ]; then
        quality="WARNING"
        error="HIGH_TEMP"

    else
        quality="CRITICAL"
        error="OVERHEAT"
    fi

    # Current timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Display live monitoring output
    echo "[$timestamp] Sensor:$SENSOR_ID | Temp:${temp}°C | Status:$quality"

    # Insert into PostgreSQL
    psql -U $DB_USER -d $DB_NAME -c "
    INSERT INTO sensor_readings
    (
        sensor_id,
        reading_value,
        reading_time,
        quality_flag,
        error_code
    )
    VALUES
    (
        $SENSOR_ID,
        $temp,
        '$timestamp',
        '$quality',
        '$error'
    );
    "

    # Wait before next reading
    sleep 2

done