#!/bin/bash

# Industrial Generator Temperature Simulator

echo "Starting Generator Temperature Simulation..."

# initial base temperature
temp=70

while true
do
    # simulate small random change (-2 to +2)
    change=$(( (RANDOM % 5) - 2 ))

    # update temperature
    temp=$((temp + change))

    # enforce safe operating limits (60–90)
    if [ $temp -lt 60 ]; then
        temp=60
    fi

    if [ $temp -gt 90 ]; then
        temp=90
    fi

    # timestamp
    time=$(date +"%H:%M:%S")

    # output
    echo "[$time] Generator Temperature: ${temp}°C"

    # wait 2 seconds
    sleep 2
done