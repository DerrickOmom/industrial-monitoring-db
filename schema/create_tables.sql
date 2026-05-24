DROP TABLE IF EXISTS sensor_readings;
DROP TABLE IF EXISTS sensors;
DROP TABLE IF EXISTS generators;
CREATE TABLE generators (
    generator_id SERIAL PRIMARY KEY,
    generator_name VARCHAR(255),
    location VARCHAR(255),
    model VARCHAR(255),
    capacity_KVA INT,
    installation_date DATE,
    status VARCHAR(100),
    fuel_type VARCHAR(100)
);
CREATE TABLE sensors (
    sensor_id SERIAL PRIMARY KEY,
    generator_id INT REFERENCES generators(generator_id),
    sensor_type VARCHAR(255),
    unit VARCHAR(255),
    install_position VARCHAR(255),
    last_calibration_date DATE
);
CREATE TABLE sensor_readings(
    reading_id SERIAL PRIMARY KEY,
    sensor_id INT REFERENCES sensors(sensor_id),
    reading_value FLOAT,
    reading_time TIMESTAMP,
    quality_flag VARCHAR(100),
    error_code VARCHAR(100)
);
SELECT * FROM generators;
SELECT * FROM sensors;  
SELECT * FROM sensor_readings;
