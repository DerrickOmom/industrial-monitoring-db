DROP TABLE IF EXISTS sensor_readings;
DROP TABLE IF EXISTS sensors;
DROP TABLE IF EXISTS maintenance_logs;
DROP TABLE IF EXISTS alarm_logs;
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
    quality_flag VARCHAR(100)
);
CREATE TABLE alarm_logs (
    alarm_id SERIAL PRIMARY KEY,
    generator_id INT REFERENCES generators(generator_id),
    alarm_type VARCHAR(255),
    alarm_severity VARCHAR(100),
    alarm_description TEXT,
    alarm_trigger_value FLOAT,
    alarm_trigger_time TIMESTAMP,
    alarm_clear_time TIMESTAMP
);
CREATE TABLE maintenance_logs (
    log_id SERIAL PRIMARY KEY,
    generator_id INT REFERENCES generators(generator_id),
    maintenance_date DATE,
    technician_name VARCHAR(255),
    maintenance_type VARCHAR(255),
    notes TEXT
);

INSERT INTO generators (generator_name, location, model, capacity_KVA, installation_date, status, fuel_type) VALUES
('GenX-1000', 'Plant A', 'Model X', 1000, '2020-01-15', 'Operational', 'Diesel'),
('GenY-2000', 'Plant B', 'Model Y', 2000, '2019-06-20', 'Operational', 'Natural Gas'),
('GenZ-1500', 'Plant C', 'Model Z', 1500, '2021-03-10', 'Under Maintenance', 'Diesel');

INSERT INTO sensors (generator_id, sensor_type, unit, install_position, last_calibration_date) VALUES
(1, 'Temperature', 'Celsius', 'Engine Room', '2023-12-01'),
(1, 'Vibration', 'mm/s', 'Engine Room', '2023-11-15'),
(2, 'Temperature', 'Celsius', 'Control Room', '2023-10-20'),
(2, 'Pressure', 'Bar', 'Control Room', '2023-09-30'),
(3, 'Temperature', 'Celsius', 'Engine Room', '2023-08-25');



SELECT * FROM generators;
SELECT * FROM sensors;  
SELECT * FROM sensor_readings;
SELECT * FROM maintenance_logs;
SELECT * FROM alarm_logs;