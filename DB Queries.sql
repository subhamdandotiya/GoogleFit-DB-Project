


CREATE SCHEMA IF NOT EXISTS google_fit_v_3;
SET SCHEMA 'google_fit_v_3';


CREATE TABLE profile (
    google_id VARCHAR(300) not null,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(100),
    birthday DATE not null,
    primary key (google_id)
);

CREATE TABLE device (
    device_id VARCHAR(100) NOT NULL,
    google_id VARCHAR(300) NOT NULL,
    time_stamp TIME NOT NULL,
    calendar DATE,
    location POINT NOT NULL,
    sequence_number int not null, 
    PRIMARY KEY (device_id, sequence_number),  -- Composite primary key
    CONSTRAINT fk_device_google_id 
        FOREIGN KEY (google_id) 
        REFERENCES profile(google_id) 
        ON DELETE CASCADE    
);

CREATE TABLE health_log (
    health_log_id VARCHAR(100) NOT NULL,
    google_id VARCHAR(300) NOT NULL,
    device_id VARCHAR(100) NOT NULL,
    sequence_number int NOT NULL,  -- New column to match the device table
    time_stamp TIME NOT NULL,
    log_type VARCHAR(100) NOT NULL,
    PRIMARY KEY (health_log_id),
    CONSTRAINT health_log_fkey_google_id 
        FOREIGN KEY (google_id) 
        REFERENCES profile(google_id) 
        ON DELETE CASCADE,
    CONSTRAINT health_log_fkey_device 
        FOREIGN KEY (device_id, sequence_number)  -- Updated foreign key reference
        REFERENCES device(device_id, sequence_number) 
        ON DELETE SET NULL
);

CREATE TABLE sleep (
    health_log_id VARCHAR(100) not null,
    sleep_time TIME,
    REM_sleep DECIMAL,
    primary key (health_log_id),
    constraint sleep_fkey_health_log_id 
    	FOREIGN KEY (health_log_id) 
    	REFERENCES health_log(health_log_id) 
    	ON DELETE CASCADE
);

CREATE TABLE nutrition_log (
    health_log_id VARCHAR(100) not null,
    calorie_count INTEGER,
    hydration_intake INTEGER,
    primary key (health_log_id),
    constraint nutrition_log_fkey_health_log_id 
    	FOREIGN KEY (health_log_id) 
    	REFERENCES health_log(health_log_id) 
    	ON DELETE CASCADE
);

CREATE TABLE activity (
    health_log_id VARCHAR(100) not null,
    exercise_type VARCHAR(100) not null,
    heart_points decimal not null,
    move_minutes decimal not null,
    steps decimal,
    distance DECIMAL,
    pace VARCHAR(100),
    calorie_expenditure INTEGER,
    primary key (health_log_id),
    constraint activity_fkey_health_log_id 
    	FOREIGN KEY (health_log_id) 
    	REFERENCES health_log(health_log_id) 
    	ON DELETE CASCADE
);

CREATE TABLE vital (
    health_log_id VARCHAR(100) NOT NULL,  
    heart_rate INTEGER,
    blood_pressure VARCHAR(10),
    PRIMARY KEY (health_log_id),
    CONSTRAINT vital_fkey_health_log_id 
        FOREIGN KEY (health_log_id) 
        REFERENCES health_log(health_log_id) 
        ON DELETE CASCADE
   
);

CREATE TABLE body_measurement (
    health_log_id VARCHAR(100) not null,
    height DECIMAL,
    weight DECIMAL,
    body_fat DECIMAL,
    primary key (health_log_id),
    constraint body_measurement_fkey_health_log_id 
    	FOREIGN KEY (health_log_id) 
    	REFERENCES health_log(health_log_id) 
    	ON DELETE CASCADE
);

CREATE TABLE cycle (
    health_log_id VARCHAR(100) not null,
    start_date DATE,
    end_date DATE,
    primary key (health_log_id),
    constraint cycle_fkey_health_log_id 
    	FOREIGN KEY (health_log_id) 
    	REFERENCES health_log(health_log_id) 
    	ON DELETE CASCADE
);

CREATE TABLE goal (
    goal_list_id VARCHAR(100) not null,
    google_id VARCHAR(300) not null,
    step_goal decimal,
    heart_point decimal,
    primary key (goal_list_id),
    constraint goal_fkey_google_id 
    	FOREIGN KEY (google_id) 
    	REFERENCES profile(google_id) 
    	ON DELETE CASCADE
);

CREATE TABLE coaching_plan (
    coaching_plan VARCHAR(100) not null,
    google_id VARCHAR(300) not null,
    post_workout_feedback VARCHAR(5000),
    future_workout_recommendation VARCHAR(5000),
    AHA_recommendations VARCHAR(5000),
    primary key (coaching_plan),
    constraint coaching_plan_fkey_google_id 
    	FOREIGN KEY (google_id) 
    	REFERENCES profile(google_id) 
    	ON DELETE CASCADE
);

CREATE TABLE recommendation (
    recommendation_id VARCHAR(100) not null,
    health_log_id VARCHAR(100) not null,
    coaching_plan VARCHAR(100) not null,
    primary key (recommendation_id),
    constraint recommendation_fkey_health_log_id 
    	FOREIGN KEY (health_log_id) 
    	REFERENCES health_Log(health_log_id) 
    	ON DELETE CASCADE,
    constraint recommendation_fkey_coaching_plan 
    	FOREIGN KEY (coaching_plan) 
    	REFERENCES coaching_Plan(coaching_plan) 
    	ON DELETE SET NULL
);

CREATE TABLE notification (
    notification_id VARCHAR(100) NOT NULL,
    goal_list_id VARCHAR(100) NOT NULL,
    recommendation_id VARCHAR(100) NOT NULL,
    device_id VARCHAR(100) NOT NULL,
    sequence_number int NOT NULL,  -- New column to match the device table
    PRIMARY KEY (notification_id),
    CONSTRAINT notification_fkey_goal_list_id 
        FOREIGN KEY (goal_list_id) 
        REFERENCES goal(goal_list_id) 
        ON DELETE SET NULL,
    CONSTRAINT notification_fkey_recommendation_id 
        FOREIGN KEY (recommendation_id) 
        REFERENCES recommendation(recommendation_id) 
        ON DELETE SET NULL,
    CONSTRAINT notification_fkey_device 
        FOREIGN KEY (device_id, sequence_number)  -- Updated foreign key reference
        REFERENCES device(device_id, sequence_number) 
        ON DELETE SET NULL
);


INSERT INTO profile (google_id, first_name, last_name, gender, birthday) VALUES
('user001', 'Alice', 'Smith', 'Female', '1999-05-15'),  -- 25
('user002', 'Bob', 'Johnson', 'Male', '1994-08-22'),   -- 30
('user003', 'Charlie', 'Williams', 'Male', '1987-11-30'), -- 36
('user004', 'Diana', 'Jones', 'Female', '1983-03-10'),  -- 41
('user005', 'Ethan', 'Brown', 'Male', '1995-01-25'),    -- 29
('user006', 'Fiona', 'Davis', 'Female', '1978-06-05'),  -- 46
('user007', 'George', 'Miller', 'Male', '1991-12-18'),  -- 32
('user008', 'Hannah', 'Wilson', 'Female', '1989-02-14'), -- 35
('user009', 'Ian', 'Moore', 'Male', '1996-09-09'),      -- 27
('user010', 'Jessica', 'Taylor', 'Female', '1985-07-20'), -- 39
('user011', 'Kevin', 'Anderson', 'Male', '1979-10-12'), -- 44
('user012', 'Laura', 'Thomas', 'Female', '1993-04-28'),  -- 31
('user013', 'Michael', 'Jackson', 'Male', '1980-11-02'), -- 43
('user014', 'Nina', 'White', 'Female', '1995-08-19'),    -- 29
('user015', 'Oliver', 'Harris', 'Male', '1982-03-30'),   -- 42
('user016', 'Pamela', 'Martin', 'Female', '1975-12-01'), -- 48
('user017', 'Quentin', 'Thompson', 'Male', '1994-05-05'), -- 30
('user018', 'Rachel', 'Garcia', 'Female', '1988-07-15'),  -- 36
('user019', 'Steven', 'Martinez', 'Male', '1972-09-22'),  -- 52
('user020', 'Tina', 'Robinson', 'Female', '1991-01-11');   -- 33

INSERT INTO device (device_id, google_id, time_stamp, calendar, location, sequence_number) VALUES
('device001', 'user001', '08:00:00', '2024-10-01', POINT(37.7749, -122.4194), 1),
('device002', 'user002', '08:30:00', '2024-10-01', POINT(34.0522, -118.2437), 1),
('device003', 'user003', '09:00:00', '2024-10-01', POINT(40.7128, -74.0060), 1),
('device004', 'user004', '09:30:00', '2024-10-01', POINT(51.5074, -0.1278), 1),
('device005', 'user005', '10:00:00', '2024-10-01', POINT(48.8566, 2.3522), 1),
('device006', 'user006', '10:30:00', '2024-10-01', POINT(35.6895, 139.6917), 1),
('device007', 'user007', '11:00:00', '2024-10-01', POINT(55.7558, 37.6173), 1),
('device008', 'user008', '11:30:00', '2024-10-01', POINT(39.9042, 116.4074), 1),
('device009', 'user009', '12:00:00', '2024-10-01', POINT(-33.8688, 151.2093), 1),
('device010', 'user010', '12:30:00', '2024-10-01', POINT(-34.6037, -58.3816), 1),
('device011', 'user011', '13:00:00', '2024-10-01', POINT(37.7749, -122.4194), 1),
('device012', 'user012', '13:30:00', '2024-10-01', POINT(34.0522, -118.2437), 1),
('device013', 'user013', '14:00:00', '2024-10-01', POINT(40.7128, -74.0060), 1),
('device014', 'user014', '14:30:00', '2024-10-01', POINT(51.5074, -0.1278), 1),
('device015', 'user015', '15:00:00', '2024-10-01', POINT(48.8566, 2.3522), 1),
('device016', 'user016', '15:30:00', '2024-10-01', POINT(35.6895, 139.6917), 1),
('device017', 'user017', '16:00:00', '2024-10-01', POINT(55.7558, 37.6173), 1),
('device018', 'user018', '16:30:00', '2024-10-01', POINT(39.9042, 116.4074), 1),
('device019', 'user019', '17:00:00', '2024-10-01', POINT(-33.8688, 151.2093), 1),
('device020', 'user020', '17:30:00', '2024-10-01', POINT(-34.6037, -58.3816), 1);


-- Insert entries into the health_log table
-- Insert entries into the health_log table
INSERT INTO health_log (health_log_id, google_id, device_id, sequence_number, time_stamp, log_type) VALUES
('log001', 'user001', 'device001', 1, '22:00:00', 'Sleep'),
('log002', 'user002', 'device002', 1, '21:30:00', 'Sleep'),
('log003', 'user003', 'device003', 1, '23:00:00', 'Sleep'),
('log004', 'user004', 'device004', 1, '20:30:00', 'Sleep'),
('log005', 'user005', 'device005', 1, '21:00:00', 'Sleep'),
('log006', 'user006', 'device006', 1, '22:30:00', 'Sleep'),
('log007', 'user007', 'device007', 1, '23:15:00', 'Sleep'),
('log008', 'user008', 'device008', 1, '20:45:00', 'Sleep'),
('log009', 'user009', 'device009', 1, '22:00:00', 'Sleep'),
('log010', 'user010', 'device010', 1, '21:00:00', 'Sleep'),
('log011', 'user011', 'device011', 1, '22:15:00', 'Sleep'),
('log012', 'user012', 'device012', 1, '21:45:00', 'Sleep'),
('log013', 'user013', 'device013', 1, '23:30:00', 'Sleep'),
('log014', 'user014', 'device014', 1, '20:00:00', 'Sleep'),
('log015', 'user015', 'device015', 1, '22:45:00', 'Sleep'),
('log016', 'user016', 'device016', 1, '21:15:00', 'Sleep'),
('log017', 'user017', 'device017', 1, '20:30:00', 'Sleep'),
('log018', 'user018', 'device018', 1, '23:00:00', 'Sleep'),
('log019', 'user019', 'device019', 1, '22:00:00', 'Sleep'),
('log020', 'user020', 'device020', 1, '21:30:00', 'Sleep');


-- Insert entries into the sleep table
INSERT INTO sleep (health_log_id, sleep_time, REM_sleep) VALUES
('log001', '22:00:00', 1.5),  -- Example REM sleep in hours
('log002', '21:30:00', 1.0),
('log003', '23:00:00', 1.2),
('log004', '20:30:00', 2.0),
('log005', '21:00:00', 1.8),
('log006', '22:30:00', 1.5),
('log007', '23:15:00', 1.3),
('log008', '20:45:00', 1.7),
('log009', '22:00:00', 1.4),
('log010', '21:00:00', 1.6),
('log011', '22:15:00', 1.2),
('log012', '21:45:00', 1.8),
('log013', '23:30:00', 1.4),
('log014', '20:00:00', 2.0),
('log015', '22:45:00', 1.6),
('log016', '21:15:00', 1.3),
('log017', '20:30:00', 1.5),
('log018', '23:00:00', 1.4),
('log019', '22:00:00', 1.2),
('log020', '21:30:00', 1.7);


-- Insert entries into the health_log table for female profiles with matching device_id and sequence_number
INSERT INTO health_log (health_log_id, google_id, device_id, sequence_number, time_stamp, log_type) VALUES
('log201', 'user001', 'device011', 1, '22:00:00', 'Cycle'),  -- Alice
('log202', 'user004', 'device012', 1, '20:30:00', 'Cycle'),  -- Diana
('log203', 'user006', 'device013', 1, '22:30:00', 'Cycle'),  -- Fiona
('log204', 'user008', 'device014', 1, '21:15:00', 'Cycle'),  -- Hannah
('log205', 'user010', 'device015', 1, '21:00:00', 'Cycle'),  -- Jessica
('log206', 'user012', 'device016', 1, '22:15:00', 'Cycle'),  -- Laura
('log207', 'user014', 'device017', 1, '21:45:00', 'Cycle'),  -- Nina
('log208', 'user016', 'device018', 1, '22:00:00', 'Cycle'),  -- Pamela
('log209', 'user018', 'device019', 1, '21:30:00', 'Cycle'),  -- Rachel
('log210', 'user020', 'device020', 1, '21:00:00', 'Cycle');  -- Tina


-- Insert entries into the cycle table with end_dates between 21-35 days after start_dates for female profiles
INSERT INTO cycle (health_log_id, start_date, end_date) VALUES
('log201', '2024-10-01', '2024-10-22'),  -- 21 days later
('log202', '2024-10-02', '2024-10-29'),  -- 27 days later
('log203', '2024-10-01', '2024-10-25'),  -- 24 days later
('log204', '2024-10-03', '2024-10-30'),  -- 27 days later
('log205', '2024-10-01', '2024-10-31'),  -- 30 days later
('log206', '2024-10-04', '2024-10-25'),  -- 21 days later
('log207', '2024-10-05', '2024-10-30'),  -- 25 days later
('log208', '2024-10-06', '2024-10-28'),  -- 22 days later
('log209', '2024-10-07', '2024-10-29'),  -- 22 days later
('log210', '2024-10-08', '2024-10-31');  -- 23 days later
 


-- Insert entries into the health_log table for each profile with unique health_log_id
INSERT INTO health_log (health_log_id, google_id, device_id, sequence_number, time_stamp, log_type) VALUES
('log301', 'user001', 'device001', 1, '22:00:00', 'Body Measurement'),
('log302', 'user002', 'device002', 1, '22:15:00', 'Body Measurement'),
('log303', 'user003', 'device003', 1, '22:30:00', 'Body Measurement'),
('log304', 'user004', 'device004', 1, '22:45:00', 'Body Measurement'),
('log305', 'user005', 'device005', 1, '23:00:00', 'Body Measurement'),
('log306', 'user006', 'device006', 1, '23:15:00', 'Body Measurement'),
('log307', 'user007', 'device007', 1, '23:30:00', 'Body Measurement'),
('log308', 'user008', 'device008', 1, '23:45:00', 'Body Measurement'),
('log309', 'user009', 'device009', 1, '21:00:00', 'Body Measurement'),
('log310', 'user010', 'device010', 1, '21:15:00', 'Body Measurement'),
('log311', 'user011', 'device011', 1, '21:30:00', 'Body Measurement'),
('log312', 'user012', 'device012', 1, '21:45:00', 'Body Measurement'),
('log313', 'user013', 'device013', 1, '22:00:00', 'Body Measurement'),
('log314', 'user014', 'device014', 1, '22:15:00', 'Body Measurement'),
('log315', 'user015', 'device015', 1, '22:30:00', 'Body Measurement'),
('log316', 'user016', 'device016', 1, '22:45:00', 'Body Measurement'),
('log317', 'user017', 'device017', 1, '23:00:00', 'Body Measurement'),
('log318', 'user018', 'device018', 1, '23:15:00', 'Body Measurement'),
('log319', 'user019', 'device019', 1, '23:30:00', 'Body Measurement'),
('log320', 'user020', 'device020', 1, '23:45:00', 'Body Measurement');


-- Insert entries into the body_measurement table for each profile with corresponding health_log_id
INSERT INTO body_measurement (health_log_id, height, weight, body_fat) VALUES
('log301', 165.0, 60.0, 22.0),
('log302', 175.0, 75.0, 18.0),
('log303', 180.0, 80.0, 20.0),
('log304', 160.0, 55.0, 25.0),
('log305', 170.0, 68.0, 21.0),
('log306', 158.0, 52.0, 24.0),
('log307', 182.0, 85.0, 19.0),
('log308', 165.0, 62.0, 22.5),
('log309', 177.0, 77.0, 17.5),
('log310', 169.0, 65.0, 20.0),
('log311', 174.0, 72.0, 19.0),
('log312', 162.0, 54.0, 26.0),
('log313', 181.0, 82.0, 20.0),
('log314', 159.0, 50.0, 23.0),
('log315', 171.0, 70.0, 18.0),
('log316', 166.0, 64.0, 22.0),
('log317', 178.0, 80.0, 19.5),
('log318', 163.0, 58.0, 24.0),
('log319', 176.0, 78.0, 17.0),
('log320', 168.0, 66.0, 21.0);

-- Insert entries into the health_log table for each profile with unique health_log_id for Nutrition
INSERT INTO health_log (health_log_id, google_id, device_id, sequence_number, time_stamp, log_type) VALUES
('log401', 'user001', 'device001', 1, '12:00:00', 'Nutrition'),
('log402', 'user002', 'device002', 1, '12:15:00', 'Nutrition'),
('log403', 'user003', 'device003', 1, '12:30:00', 'Nutrition'),
('log404', 'user004', 'device004', 1, '12:45:00', 'Nutrition'),
('log405', 'user005', 'device005', 1, '13:00:00', 'Nutrition'),
('log406', 'user006', 'device006', 1, '13:15:00', 'Nutrition'),
('log407', 'user007', 'device007', 1, '13:30:00', 'Nutrition'),
('log408', 'user008', 'device008', 1, '13:45:00', 'Nutrition'),
('log409', 'user009', 'device009', 1, '14:00:00', 'Nutrition'),
('log410', 'user010', 'device010', 1, '14:15:00', 'Nutrition'),
('log411', 'user011', 'device011', 1, '14:30:00', 'Nutrition'),
('log412', 'user012', 'device012', 1, '14:45:00', 'Nutrition'),
('log413', 'user013', 'device013', 1, '15:00:00', 'Nutrition'),
('log414', 'user014', 'device014', 1, '15:15:00', 'Nutrition'),
('log415', 'user015', 'device015', 1, '15:30:00', 'Nutrition'),
('log416', 'user016', 'device016', 1, '15:45:00', 'Nutrition'),
('log417', 'user017', 'device017', 1, '16:00:00', 'Nutrition'),
('log418', 'user018', 'device018', 1, '16:15:00', 'Nutrition'),
('log419', 'user019', 'device019', 1, '16:30:00', 'Nutrition'),
('log420', 'user020', 'device020', 1, '16:45:00', 'Nutrition');

-- Insert entries into the nutrition_log table for each profile with corresponding health_log_id
INSERT INTO nutrition_log (health_log_id, calorie_count, hydration_intake) VALUES
('log401', 500, 2000),
('log402', 600, 2200),
('log403', 450, 1800),
('log404', 550, 2100),
('log405', 700, 2500),
('log406', 400, 1900),
('log407', 600, 2300),
('log408', 500, 2000),
('log409', 450, 1700),
('log410', 650, 2400),
('log411', 550, 2100),
('log412', 700, 2600),
('log413', 500, 2200),
('log414', 600, 2400),
('log415', 550, 2100),
('log416', 650, 2300),
('log417', 500, 2000),
('log418', 600, 2500),
('log419', 450, 1900),
('log420', 700, 2200);




INSERT INTO health_log (health_log_id, google_id, device_id, sequence_number, time_stamp, log_type) VALUES
('log501', 'user001', 'device001', 1, '08:00:00', 'Vital'),
('log502', 'user002', 'device002', 1, '08:15:00', 'Vital'),
('log503', 'user003', 'device003', 1, '08:30:00', 'Vital'),
('log504', 'user004', 'device004', 1, '08:45:00', 'Vital'),
('log505', 'user005', 'device005', 1, '09:00:00', 'Vital'),
('log506', 'user006', 'device006', 1, '09:15:00', 'Vital'),
('log507', 'user007', 'device007', 1, '09:30:00', 'Vital'),
('log508', 'user008', 'device008', 1, '09:45:00', 'Vital'),
('log509', 'user009', 'device009', 1, '10:00:00', 'Vital'),
('log510', 'user010', 'device010', 1, '10:15:00', 'Vital'),
('log511', 'user011', 'device011', 1, '10:30:00', 'Vital'),
('log512', 'user012', 'device012', 1, '10:45:00', 'Vital'),
('log513', 'user013', 'device013', 1, '11:00:00', 'Vital'),
('log514', 'user014', 'device014', 1, '11:15:00', 'Vital'),
('log515', 'user015', 'device015', 1, '11:30:00', 'Vital'),
('log516', 'user016', 'device016', 1, '11:45:00', 'Vital'),
('log517', 'user017', 'device017', 1, '12:00:00', 'Vital'),
('log518', 'user018', 'device018', 1, '12:15:00', 'Vital'),
('log519', 'user019', 'device019', 1, '12:30:00', 'Vital'),
('log520', 'user020', 'device020', 1, '12:45:00', 'Vital');


INSERT INTO vital (health_log_id, heart_rate, blood_pressure) VALUES
('log501', 70, '120/80'),
('log502', 75, '122/78'),
('log503', 68, '118/76'),
('log504', 72, '125/82'),
('log505', 80, '130/85'),
('log506', 65, '115/75'),
('log507', 78, '123/79'),
('log508', 74, '121/80'),
('log509', 69, '119/77'),
('log510', 76, '127/81'),
('log511', 82, '133/84'),
('log512', 72, '120/79'),
('log513', 77, '124/80'),
('log514', 71, '118/78'),
('log515', 79, '126/83'),
('log516', 68, '116/76'),
('log517', 74, '122/79'),
('log518', 70, '120/82'),
('log519', 78, '125/81'),
('log520', 66, '114/75');


INSERT INTO goal (goal_list_id, google_id, step_goal, heart_point) VALUES
('goal001', 'user001', 10000, 50),
('goal002', 'user002', 12000, 60),
('goal003', 'user003', 8000, 40),
('goal004', 'user004', 10000, 50),
('goal005', 'user005', 15000, 70),
('goal006', 'user006', 9000, 45),
('goal007', 'user007', 11000, 55),
('goal008', 'user008', 9500, 50),
('goal009', 'user009', 13000, 65),
('goal010', 'user010', 8500, 35),
('goal011', 'user011', 12000, 60),
('goal012', 'user012', 10000, 50),
('goal013', 'user013', 11500, 55),
('goal014', 'user014', 9000, 45),
('goal015', 'user015', 10000, 50),
('goal016', 'user016', 11000, 55),
('goal017', 'user017', 9500, 50),
('goal018', 'user018', 15000, 70),
('goal019', 'user019', 13000, 65),
('goal020', 'user020', 8000, 40);


INSERT INTO health_log (health_log_id, google_id, device_id, sequence_number, time_stamp, log_type) VALUES
-- Profile user001
('hl001', 'user001', 'device001', 1, '08:00:00', 'activity'),
('hl002', 'user001', 'device001', 1, '08:30:00', 'activity'),
('hl003', 'user001', 'device001', 1, '09:00:00', 'activity'),
('hl004', 'user001', 'device001', 1, '10:00:00', 'activity'),
('hl005', 'user001', 'device001', 1, '11:00:00', 'activity'),

-- Profile user002
('hl006', 'user002', 'device002', 1, '08:00:00', 'activity'),
('hl007', 'user002', 'device002', 1, '08:30:00', 'activity'),
('hl008', 'user002', 'device002', 1, '09:00:00', 'activity'),
('hl009', 'user002', 'device002', 1, '10:00:00', 'activity'),
('hl010', 'user002', 'device002', 1, '11:00:00', 'activity'),

-- Profile user003
('hl011', 'user003', 'device003', 1, '08:00:00', 'activity'),
('hl012', 'user003', 'device003', 1, '08:30:00', 'activity'),
('hl013', 'user003', 'device003', 1, '09:00:00', 'activity'),
('hl014', 'user003', 'device003', 1, '10:00:00', 'activity'),
('hl015', 'user003', 'device003', 1, '11:00:00', 'activity'),

-- Profile user004
('hl016', 'user004', 'device004', 1, '08:00:00', 'activity'),
('hl017', 'user004', 'device004', 1, '08:30:00', 'activity'),
('hl018', 'user004', 'device004', 1, '09:00:00', 'activity'),
('hl019', 'user004', 'device004', 1, '10:00:00', 'activity'),
('hl020', 'user004', 'device004', 1, '11:00:00', 'activity'),

-- Profile user005
('hl021', 'user005', 'device005', 1, '08:00:00', 'activity'),
('hl022', 'user005', 'device005', 1, '08:30:00', 'activity'),
('hl023', 'user005', 'device005', 1, '09:00:00', 'activity'),
('hl024', 'user005', 'device005', 1, '10:00:00', 'activity'),
('hl025', 'user005', 'device005', 1, '11:00:00', 'activity'),

-- Profile user006
('hl026', 'user006', 'device006', 1, '08:00:00', 'activity'),
('hl027', 'user006', 'device006', 1, '08:30:00', 'activity'),
('hl028', 'user006', 'device006', 1, '09:00:00', 'activity'),
('hl029', 'user006', 'device006', 1, '10:00:00', 'activity'),
('hl030', 'user006', 'device006', 1, '11:00:00', 'activity'),

-- Profile user007
('hl031', 'user007', 'device007', 1, '08:00:00', 'activity'),
('hl032', 'user007', 'device007', 1, '08:30:00', 'activity'),
('hl033', 'user007', 'device007', 1, '09:00:00', 'activity'),
('hl034', 'user007', 'device007', 1, '10:00:00', 'activity'),
('hl035', 'user007', 'device007', 1, '11:00:00', 'activity'),

-- Profile user008
('hl036', 'user008', 'device008', 1, '08:00:00', 'activity'),
('hl037', 'user008', 'device008', 1, '08:30:00', 'activity'),
('hl038', 'user008', 'device008', 1, '09:00:00', 'activity'),
('hl039', 'user008', 'device008', 1, '10:00:00', 'activity'),
('hl040', 'user008', 'device008', 1, '11:00:00', 'activity'),

-- Profile user009
('hl041', 'user009', 'device009', 1, '08:00:00', 'activity'),
('hl042', 'user009', 'device009', 1, '08:30:00', 'activity'),
('hl043', 'user009', 'device009', 1, '09:00:00', 'activity'),
('hl044', 'user009', 'device009', 1, '10:00:00', 'activity'),
('hl045', 'user009', 'device009', 1, '11:00:00', 'activity'),

-- Profile user010
('hl046', 'user010', 'device010', 1, '08:00:00', 'activity'),
('hl047', 'user010', 'device010', 1, '08:30:00', 'activity'),
('hl048', 'user010', 'device010', 1, '09:00:00', 'activity'),
('hl049', 'user010', 'device010', 1, '10:00:00', 'activity'),
('hl050', 'user010', 'device010', 1, '11:00:00', 'activity'),

-- Profile user011
('hl051', 'user011', 'device011', 1, '08:00:00', 'activity'),
('hl052', 'user011', 'device011', 1, '08:30:00', 'activity'),
('hl053', 'user011', 'device011', 1, '09:00:00', 'activity'),
('hl054', 'user011', 'device011', 1, '10:00:00', 'activity'),
('hl055', 'user011', 'device011', 1, '11:00:00', 'activity'),

-- Profile user012
('hl056', 'user012', 'device012', 1, '08:00:00', 'activity'),
('hl057', 'user012', 'device012', 1, '08:30:00', 'activity'),
('hl058', 'user012', 'device012', 1, '09:00:00', 'activity'),
('hl059', 'user012', 'device012', 1, '10:00:00', 'activity'),
('hl060', 'user012', 'device012', 1, '11:00:00', 'activity'),

-- Profile user013
('hl061', 'user013', 'device013', 1, '08:00:00', 'activity'),
('hl062', 'user013', 'device013', 1, '08:30:00', 'activity'),
('hl063', 'user013', 'device013', 1, '09:00:00', 'activity'),
('hl064', 'user013', 'device013', 1, '10:00:00', 'activity'),
('hl065', 'user013', 'device013', 1, '11:00:00', 'activity'),

-- Profile user014
('hl066', 'user014', 'device014', 1, '08:00:00', 'activity'),
('hl067', 'user014', 'device014', 1, '08:30:00', 'activity'),
('hl068', 'user014', 'device014', 1, '09:00:00', 'activity'),
('hl069', 'user014', 'device014', 1, '10:00:00', 'activity'),
('hl070', 'user014', 'device014', 1, '11:00:00', 'activity'),

-- Profile user015
('hl071', 'user015', 'device015', 1, '08:00:00', 'activity'),
('hl072', 'user015', 'device015', 1, '08:30:00', 'activity'),
('hl073', 'user015', 'device015', 1, '09:00:00', 'activity'),
('hl074', 'user015', 'device015', 1, '10:00:00', 'activity'),
('hl075', 'user015', 'device015', 1, '11:00:00', 'activity'),

-- Profile user016
('hl076', 'user016', 'device016', 1, '08:00:00', 'activity'),
('hl077', 'user016', 'device016', 1, '08:30:00', 'activity'),
('hl078', 'user016', 'device016', 1, '09:00:00', 'activity'),
('hl079', 'user016', 'device016', 1, '10:00:00', 'activity'),
('hl080', 'user016', 'device016', 1, '11:00:00', 'activity'),

-- Profile user017
('hl081', 'user017', 'device017', 1, '08:00:00', 'activity'),
('hl082', 'user017', 'device017', 1, '08:30:00', 'activity'),
('hl083', 'user017', 'device017', 1, '09:00:00', 'activity'),
('hl084', 'user017', 'device017', 1, '10:00:00', 'activity'),
('hl085', 'user017', 'device017', 1, '11:00:00', 'activity'),

-- Profile user018
('hl086', 'user018', 'device018', 1, '08:00:00', 'activity'),
('hl087', 'user018', 'device018', 1, '08:30:00', 'activity'),
('hl088', 'user018', 'device018', 1, '09:00:00', 'activity'),
('hl089', 'user018', 'device018', 1, '10:00:00', 'activity'),
('hl090', 'user018', 'device018', 1, '11:00:00', 'activity'),

-- Profile user019
('hl091', 'user019', 'device019', 1, '08:00:00', 'activity'),
('hl092', 'user019', 'device019', 1, '08:30:00', 'activity'),
('hl093', 'user019', 'device019', 1, '09:00:00', 'activity'),
('hl094', 'user019', 'device019', 1, '10:00:00', 'activity'),
('hl095', 'user019', 'device019', 1, '11:00:00', 'activity'),

-- Profile user020
('hl096', 'user020', 'device020', 1, '08:00:00', 'activity'),
('hl097', 'user020', 'device020', 1, '08:30:00', 'activity'),
('hl098', 'user020', 'device020', 1, '09:00:00', 'activity'),
('hl099', 'user020', 'device020', 1, '10:00:00', 'activity'),
('hl100', 'user020', 'device020', 1, '11:00:00', 'activity');



INSERT INTO activity (health_log_id, exercise_type, heart_points, move_minutes, steps, distance, pace, calorie_expenditure) VALUES
-- Profile user001
('hl001', 'running', 30, 30, 3000, 3.5, '8:30 min/mile', 300),
('hl002', 'walking', 15, 45, 4000, 2.0, '20:00 min/mile', 200),
('hl003', 'cycling', 40, 60, 5000, 15.0, '12:00 mph', 500),
('hl004', 'swimming', 35, 40, 2000, 1.0, '30 strokes/min', 400),
('hl005', 'yoga', 10, 60, 1000, 0.0, 'N/A', 150),

-- Profile user002
('hl006', 'running', 25, 25, 2500, 2.8, '10:00 min/mile', 250),
('hl007', 'walking', 12, 30, 3000, 1.5, '22:00 min/mile', 150),
('hl008', 'cycling', 35, 55, 4500, 12.0, '14:00 mph', 450),
('hl009', 'swimming', 28, 35, 1500, 0.7, '40 strokes/min', 350),
('hl010', 'yoga', 8, 50, 900, 0.0, 'N/A', 100),

-- Profile user003
('hl011', 'running', 32, 40, 3200, 4.0, '9:00 min/mile', 400),
('hl012', 'walking', 14, 55, 3200, 1.8, '18:00 min/mile', 250),
('hl013', 'cycling', 42, 70, 5500, 18.0, '11:00 mph', 600),
('hl014', 'swimming', 30, 50, 2200, 1.2, '35 strokes/min', 500),
('hl015', 'yoga', 11, 65, 1100, 0.0, 'N/A', 200),

-- Profile user004
('hl016', 'running', 28, 30, 2800, 3.2, '10:00 min/mile', 350),
('hl017', 'walking', 13, 45, 2900, 1.6, '20:00 min/mile', 180),
('hl018', 'cycling', 36, 60, 4600, 13.5, '13:00 mph', 520),
('hl019', 'swimming', 27, 30, 1900, 1.0, '30 strokes/min', 290),
('hl020', 'yoga', 9, 55, 800, 0.0, 'N/A', 120),

-- Profile user005
('hl021', 'running', 26, 20, 2600, 3.0, '10:00 min/mile', 300),
('hl022', 'walking', 11, 50, 2700, 1.4, '20:00 min/mile', 210),
('hl023', 'cycling', 34, 45, 4400, 14.0, '15:00 mph', 480),
('hl024', 'swimming', 29, 55, 2000, 0.9, '40 strokes/min', 320),
('hl025', 'yoga', 10, 65, 950, 0.0, 'N/A', 150),

-- Profile user006
('hl026', 'running', 31, 35, 3100, 3.8, '9:30 min/mile', 390),
('hl027', 'walking', 16, 40, 3300, 1.7, '19:00 min/mile', 260),
('hl028', 'cycling', 38, 65, 4800, 16.0, '12:30 mph', 540),
('hl029', 'swimming', 34, 45, 2100, 1.1, '30 strokes/min', 410),
('hl030', 'yoga', 12, 60, 1000, 0.0, 'N/A', 130),

-- Profile user007
('hl031', 'running', 33, 40, 3200, 4.1, '9:00 min/mile', 420),
('hl032', 'walking', 14, 55, 3100, 1.9, '18:30 min/mile', 230),
('hl033', 'cycling', 39, 70, 5700, 19.0, '11:30 mph', 620),
('hl034', 'swimming', 32, 40, 2400, 1.3, '35 strokes/min', 450),
('hl035', 'yoga', 13, 50, 1200, 0.0, 'N/A', 160),

-- Profile user008
('hl036', 'running', 29, 25, 2900, 3.3, '10:00 min/mile', 310),
('hl037', 'walking', 15, 45, 3100, 1.5, '21:00 min/mile', 195),
('hl038', 'cycling', 37, 60, 5000, 15.5, '13:30 mph', 560),
('hl039', 'swimming', 30, 30, 2100, 1.2, '30 strokes/min', 320),
('hl040', 'yoga', 10, 55, 1000, 0.0, 'N/A', 150),

-- Profile user009
('hl041', 'running', 30, 30, 3000, 3.5, '8:45 min/mile', 310),
('hl042', 'walking', 14, 45, 3200, 1.8, '20:30 min/mile', 240),
('hl043', 'cycling', 36, 65, 4500, 15.0, '12:15 mph', 540),
('hl044', 'swimming', 31, 40, 2200, 1.1, '35 strokes/min', 390),
('hl045', 'yoga', 9, 60, 800, 0.0, 'N/A', 150),

-- Profile user010
('hl046', 'running', 27, 20, 2700, 3.0, '10:00 min/mile', 290),
('hl047', 'walking', 13, 50, 2500, 1.3, '20:00 min/mile', 210),
('hl048', 'cycling', 35, 55, 4800, 14.0, '15:00 mph', 500),
('hl049', 'swimming', 28, 35, 1800, 0.8, '40 strokes/min', 300),
('hl050', 'yoga', 11, 45, 900, 0.0, 'N/A', 140),

-- Profile user011
('hl051', 'running', 29, 30, 2900, 3.2, '10:00 min/mile', 300),
('hl052', 'walking', 15, 40, 3100, 1.6, '18:00 min/mile', 220),
('hl053', 'cycling', 37, 65, 5200, 16.0, '12:30 mph', 550),
('hl054', 'swimming', 32, 30, 2100, 1.0, '35 strokes/min', 350),
('hl055', 'yoga', 10, 50, 1100, 0.0, 'N/A', 130),

-- Profile user012
('hl056', 'running', 26, 40, 2600, 3.0, '10:00 min/mile', 280),
('hl057', 'walking', 12, 45, 2900, 1.5, '20:00 min/mile', 230),
('hl058', 'cycling', 34, 60, 4500, 14.5, '13:00 mph', 480),
('hl059', 'swimming', 29, 55, 2000, 0.9, '40 strokes/min', 360),
('hl060', 'yoga', 11, 50, 950, 0.0, 'N/A', 150),

-- Profile user013
('hl061', 'running', 31, 35, 3100, 3.8, '9:30 min/mile', 390),
('hl062', 'walking', 14, 55, 3300, 1.7, '19:00 min/mile', 260),
('hl063', 'cycling', 38, 70, 4800, 16.0, '12:30 mph', 540),
('hl064', 'swimming', 34, 45, 2100, 1.1, '30 strokes/min', 410),
('hl065', 'yoga', 12, 60, 1000, 0.0, 'N/A', 130),

-- Profile user014
('hl066', 'running', 30, 20, 3000, 3.5, '8:30 min/mile', 300),
('hl067', 'walking', 15, 30, 3000, 1.4, '20:00 min/mile', 200),
('hl068', 'cycling', 36, 50, 4700, 15.0, '12:00 mph', 500),
('hl069', 'swimming', 28, 45, 1900, 1.0, '30 strokes/min', 290),
('hl070', 'yoga', 9, 55, 900, 0.0, 'N/A', 120),

-- Profile user015
('hl071', 'running', 33, 40, 3200, 4.1, '9:00 min/mile', 420),
('hl072', 'walking', 14, 55, 3100, 1.9, '18:30 min/mile', 230),
('hl073', 'cycling', 39, 70, 5700, 19.0, '11:30 mph', 620),
('hl074', 'swimming', 32, 40, 2400, 1.3, '35 strokes/min', 450),
('hl075', 'yoga', 13, 50, 1200, 0.0, 'N/A', 160),

-- Profile user016
('hl076', 'running', 29, 25, 2900, 3.3, '10:00 min/mile', 310),
('hl077', 'walking', 15, 45, 3100, 1.5, '21:00 min/mile', 195),
('hl078', 'cycling', 37, 60, 5000, 15.5, '13:30 mph', 560),
('hl079', 'swimming', 30, 30, 2100, 1.2, '30 strokes/min', 320),
('hl080', 'yoga', 10, 55, 1000, 0.0, 'N/A', 150),

-- Profile user017
('hl081', 'running', 30, 30, 3000, 3.5, '8:45 min/mile', 310),
('hl082', 'walking', 14, 45, 3200, 1.8, '20:30 min/mile', 240),
('hl083', 'cycling', 36, 65, 4500, 15.0, '12:15 mph', 540),
('hl084', 'swimming', 31, 40, 2200, 1.1, '35 strokes/min', 390),
('hl085', 'yoga', 9, 60, 800, 0.0, 'N/A', 150),

-- Profile user018
('hl086', 'running', 26, 40, 2600, 3.0, '10:00 min/mile', 280),
('hl087', 'walking', 12, 45, 2900, 1.5, '20:00 min/mile', 230),
('hl088', 'cycling', 34, 60, 4500, 14.5, '13:00 mph', 480),
('hl089', 'swimming', 29, 55, 2000, 0.9, '40 strokes/min', 360),
('hl090', 'yoga', 11, 50, 950, 0.0, 'N/A', 150),

-- Profile user019
('hl091', 'running', 31, 35, 3100, 3.8, '9:30 min/mile', 390),
('hl092', 'walking', 14, 55, 3300, 1.7, '19:00 min/mile', 260),
('hl093', 'cycling', 38, 70, 4800, 16.0, '12:30 mph', 540),
('hl094', 'swimming', 34, 45, 2100, 1.1, '30 strokes/min', 410),
('hl095', 'yoga', 12, 60, 1000, 0.0, 'N/A', 130),

-- Profile user020
('hl096', 'running', 30, 20, 3000, 3.5, '8:30 min/mile', 300),
('hl097', 'walking', 15, 30, 3000, 1.4, '20:00 min/mile', 200),
('hl098', 'cycling', 36, 50, 4700, 15.0, '12:00 mph', 500),
('hl099', 'swimming', 28, 45, 1900, 1.0, '30 strokes/min', 290),
('hl100', 'yoga', 9, 55, 900, 0.0, 'N/A', 120);


INSERT INTO coaching_plan (coaching_plan, google_id, post_workout_feedback, future_workout_recommendation, AHA_recommendations) VALUES
-- Profile user001
('cp001', 'user001', 'Great job on your running today! Keep pushing your pace.', 'Consider adding interval training next week.', 'Aim for at least 150 minutes of moderate exercise per week.'),
('cp002', 'user001', 'Walking session was steady; nice pace!', 'Try to increase your distance slightly.', 'Focus on stretching post-walk to improve flexibility.'),
('cp003', 'user001', 'Cycling was intense; well done!', 'Incorporate hill climbs into your next ride.', 'Ensure to hydrate well before and after rides.'),
('cp004', 'user001', 'Swimming form was excellent!', 'Add more laps in your next session.', 'Work on breathing technique for better endurance.'),
('cp005', 'user001', 'Yoga practice was calming; keep it up!', 'Try a more challenging class next time.', 'Practice mindfulness to enhance relaxation.'),

-- Profile user002
('cp006', 'user002', 'Good pace during your run; keep it consistent.', 'Incorporate speed work into your routine.', 'Stay hydrated throughout your workouts.'),
('cp007', 'user002', 'Your walking session was effective!', 'Aim for longer distances to build endurance.', 'Focus on maintaining good posture while walking.'),
('cp008', 'user002', 'Cycling was great; well done!', 'Try a group ride for motivation.', 'Include strength training for overall fitness.'),
('cp009', 'user002', 'Nice swimming session; good effort!', 'Increase your swim distance gradually.', 'Practice drills to improve your stroke efficiency.'),
('cp010', 'user002', 'Your yoga session was peaceful; great job!', 'Explore different yoga styles for variety.', 'Use breath control to enhance relaxation.'),

-- Profile user003
('cp011', 'user003', 'Excellent running today! You pushed hard.', 'Incorporate tempo runs for speed.', 'Make sure to rest adequately between workouts.'),
('cp012', 'user003', 'Walking was solid; nice work!', 'Add interval walks to challenge yourself.', 'Consider walking on varied terrain for added benefits.'),
('cp013', 'user003', 'Cycling was fantastic; impressive speed!', 'Join a cycling group for social motivation.', 'Focus on core strength for better stability.'),
('cp014', 'user003', 'Swimming was strong; great effort!', 'Work on your endurance by increasing laps.', 'Incorporate drills to enhance speed.'),
('cp015', 'user003', 'Yoga practice was beneficial; well done!', 'Try a workshop to deepen your practice.', 'Emphasize breathwork for relaxation.'),

-- Profile user004
('cp016', 'user004', 'Running was well-paced; keep it up!', 'Try hill workouts for strength.', 'Monitor your heart rate for optimal performance.'),
('cp017', 'user004', 'Good walking session; consistent pace!', 'Aim to walk longer distances each week.', 'Incorporate more walking into daily activities.'),
('cp018', 'user004', 'Cycling was invigorating; great job!', 'Consider varying your routes for excitement.', 'Maintain a balanced diet to support your cycling.'),
('cp019', 'user004', 'Nice swimming session; well done!', 'Add intervals for speed improvement.', 'Practice breathing drills for better technique.'),
('cp020', 'user004', 'Yoga was relaxing; keep it going!', 'Explore different yoga styles for variety.', 'Incorporate balance poses for stability.'),

-- Profile user005
('cp021', 'user005', 'Great running today! Steady effort.', 'Include longer runs on weekends.', 'Ensure proper nutrition for recovery.'),
('cp022', 'user005', 'Walking was effective; good pace!', 'Try walking on uneven surfaces for variety.', 'Focus on engaging your core while walking.'),
('cp023', 'user005', 'Cycling was energetic; well done!', 'Add some sprint intervals for intensity.', 'Check your bike for proper fit and adjustments.'),
('cp024', 'user005', 'Swimming was enjoyable; nice job!', 'Gradually increase your distance.', 'Consider open water swimming for a new challenge.'),
('cp025', 'user005', 'Yoga practice was rejuvenating; great!', 'Incorporate more challenging poses.', 'Use a foam roller for muscle recovery.'),

-- Profile user006
('cp026', 'user006', 'Nice run today! Keep improving your pace.', 'Consider adding variety with different routes.', 'Stay consistent with your training schedule.'),
('cp027', 'user006', 'Good walking session; great consistency!', 'Challenge yourself with interval walking.', 'Maintain a healthy diet to support your activity.'),
('cp028', 'user006', 'Cycling was impressive; good speed!', 'Join a cycling club for motivation.', 'Remember to stretch post-ride to avoid stiffness.'),
('cp029', 'user006', 'Swimming was refreshing; nice job!', 'Incorporate distance swims for endurance.', 'Focus on kick drills for better propulsion.'),
('cp030', 'user006', 'Yoga session was grounding; well done!', 'Explore different classes for variety.', 'Incorporate breathing exercises for relaxation.'),

-- Profile user007
('cp031', 'user007', 'Great job on your run today! Keep the pace.', 'Add tempo runs to your routine.', 'Prioritize recovery days between workouts.'),
('cp032', 'user007', 'Walking was steady; nice pace!', 'Increase your walk duration over time.', 'Incorporate more walking into your daily routine.'),
('cp033', 'user007', 'Fantastic cycling session; well done!', 'Challenge yourself with hill climbs.', 'Focus on proper hydration during rides.'),
('cp034', 'user007', 'Nice swimming effort; good technique!', 'Gradually increase your swim distance.', 'Work on your flip turns for better flow.'),
('cp035', 'user007', 'Yoga was relaxing; keep it up!', 'Try a different style for variety.', 'Emphasize relaxation poses to relieve stress.'),

-- Profile user008
('cp036', 'user008', 'Good run today; nice effort!', 'Incorporate speed work into your training.', 'Monitor your progress regularly.'),
('cp037', 'user008', 'Walking session was effective; keep it going!', 'Consider adding intervals to your walks.', 'Stay active on rest days with light activities.'),
('cp038', 'user008', 'Great cycling; keep pushing yourself!', 'Join group rides for motivation.', 'Check your nutrition for optimal energy levels.'),
('cp039', 'user008', 'Swimming was enjoyable; well done!', 'Increase your lap count gradually.', 'Work on your breathing technique for better performance.'),
('cp040', 'user008', 'Yoga was peaceful; great job!', 'Explore advanced poses for a challenge.', 'Practice mindfulness during sessions.'),

-- Profile user009
('cp041', 'user009', 'Nice run today! Consistent pacing.', 'Try to increase your distance gradually.', 'Stay focused on your training goals.'),
('cp042', 'user009', 'Walking was steady; good work!', 'Aim for longer distances each week.', 'Incorporate strength training to support walking.'),
('cp043', 'user009', 'Cycling was energetic; great job!', 'Consider hill training for strength.', 'Hydrate well before and after rides.'),
('cp044', 'user009', 'Swimming was strong; keep it up!', 'Increase distance for endurance.', 'Work on your strokes to improve efficiency.'),
('cp045', 'user009', 'Yoga session was calming; great!', 'Try a workshop to enhance your practice.', 'Incorporate restorative poses for relaxation.'),

-- Profile user010
('cp046', 'user010', 'Excellent running today! Keep challenging yourself.', 'Consider adding speed intervals.', 'Rest adequately between sessions.'),
('cp047', 'user010', 'Walking was effective; nice work!', 'Increase duration to build endurance.', 'Focus on posture and alignment while walking.'),
('cp048', 'user010', 'Cycling was fun; good effort!', 'Explore different routes for variety.', 'Include strength training for overall fitness.'),
('cp049', 'user010', 'Swimming was enjoyable; great job!', 'Gradually increase your swim distance.', 'Practice breathing drills for better performance.'),
('cp050', 'user010', 'Yoga was restorative; well done!', 'Experiment with different styles for variety.', 'Incorporate balance poses for stability.'),

-- Profile user011
('cp051', 'user011', 'Great run today! Steady pace.', 'Add distance to your next run.', 'Ensure you’re following a balanced diet.'),
('cp052', 'user011', 'Walking was good; nice effort!', 'Aim for longer durations next week.', 'Consider walking with a friend for motivation.'),
('cp053', 'user011', 'Cycling was energetic; nice work!', 'Try longer rides on weekends.', 'Stay hydrated during your rides.'),
('cp054', 'user011', 'Swimming was refreshing; keep it up!', 'Increase your distance gradually.', 'Practice drills for better speed.'),
('cp055', 'user011', 'Yoga practice was beneficial; good job!', 'Try a different class for variety.', 'Incorporate deep breathing into your practice.'),

-- Profile user012
('cp056', 'user012', 'Nice running session! Keep pushing your pace.', 'Incorporate speed work into your runs.', 'Rest days are important for recovery.'),
('cp057', 'user012', 'Walking was steady; great effort!', 'Challenge yourself with varied terrain.', 'Consider walking for errands to increase steps.'),
('cp058', 'user012', 'Cycling was excellent; well done!', 'Join a local cycling club for motivation.', 'Hydrate well before and after rides.'),
('cp059', 'user012', 'Swimming was strong; nice job!', 'Work on endurance by increasing distance.', 'Practice breathing drills for efficiency.'),
('cp060', 'user012', 'Yoga was relaxing; keep it up!', 'Explore new classes for variety.', 'Focus on flexibility to enhance your practice.'),

-- Profile user013
('cp061', 'user013', 'Good run today! Keep that momentum going.', 'Try adding longer runs into your schedule.', 'Stay consistent with your training.'),
('cp062', 'user013', 'Walking session was effective; nice pace!', 'Aim for longer walks in the coming weeks.', 'Incorporate more walking into your daily routine.'),
('cp063', 'user013', 'Cycling was fantastic; great job!', 'Consider varying your routes for excitement.', 'Check your bike for proper fit and adjustments.'),
('cp064', 'user013', 'Swimming was enjoyable; well done!', 'Increase your lap count gradually.', 'Work on your strokes for improved efficiency.'),
('cp065', 'user013', 'Yoga practice was grounding; keep it up!', 'Explore different yoga styles for variety.', 'Incorporate breathing exercises for relaxation.'),

-- Profile user014
('cp066', 'user014', 'Excellent running today! Keep improving.', 'Consider speed workouts for better pace.', 'Hydrate well during workouts.'),
('cp067', 'user014', 'Walking was solid; great effort!', 'Aim for longer distances next week.', 'Focus on maintaining good posture.'),
('cp068', 'user014', 'Cycling was invigorating; good job!', 'Join a cycling group for support.', 'Ensure you stretch post-ride to avoid soreness.'),
('cp069', 'user014', 'Nice swimming session; keep it going!', 'Gradually increase your distance.', 'Practice drills to enhance speed.'),
('cp070', 'user014', 'Yoga was calming; well done!', 'Explore new poses for a challenge.', 'Use a foam roller for muscle recovery.'),

-- Profile user015
('cp071', 'user015', 'Great run today! Keep the pace.', 'Add distance for your next run.', 'Prioritize recovery and nutrition.'),
('cp072', 'user015', 'Walking was effective; good job!', 'Challenge yourself with interval walking.', 'Incorporate more movement into daily life.'),
('cp073', 'user015', 'Cycling was energetic; great effort!', 'Consider hill training for strength.', 'Stay hydrated during and after rides.'),
('cp074', 'user015', 'Swimming was strong; keep it up!', 'Gradually increase distance.', 'Work on your breathing for endurance.'),
('cp075', 'user015', 'Yoga was rejuvenating; excellent!', 'Try different styles for variety.', 'Incorporate balance poses for stability.'),

-- Profile user016
('cp076', 'user016', 'Good running session! Nice effort!', 'Incorporate tempo runs into your training.', 'Rest days are key for recovery.'),
('cp077', 'user016', 'Walking was steady; keep it going!', 'Aim for longer distances over time.', 'Consider walking in nature for a change of scenery.'),
('cp078', 'user016', 'Cycling was impressive; well done!', 'Join group rides for support and motivation.', 'Monitor your hydration throughout rides.'),
('cp079', 'user016', 'Swimming was refreshing; nice job!', 'Increase your lap count gradually.', 'Work on your stroke efficiency for speed.'),
('cp080', 'user016', 'Yoga practice was calming; great job!', 'Explore different classes for new experiences.', 'Incorporate breathing techniques for relaxation.'),

-- Profile user017
('cp081', 'user017', 'Nice run today! Good pacing.', 'Add distance on longer runs.', 'Stay consistent with your training schedule.'),
('cp082', 'user017', 'Walking session was effective; great!', 'Challenge yourself with interval walking.', 'Maintain a balanced diet to support activity.'),
('cp083', 'user017', 'Cycling was fantastic; good speed!', 'Join a cycling group for motivation.', 'Stay hydrated before and after rides.'),
('cp084', 'user017', 'Swimming was strong; nice job!', 'Increase your distance gradually.', 'Work on your breathing technique for better endurance.'),
('cp085', 'user017', 'Yoga was relaxing; well done!', 'Try a new style for variety.', 'Emphasize relaxation poses for stress relief.'),

-- Profile user018
('cp086', 'user018', 'Great running session! Keep it up!', 'Incorporate speed intervals for improvement.', 'Rest adequately between workouts.'),
('cp087', 'user018', 'Walking was steady; nice work!', 'Aim for longer durations in the coming weeks.', 'Consider walking during lunch breaks.'),
('cp088', 'user018', 'Cycling was invigorating; good job!', 'Explore different routes for excitement.', 'Ensure you hydrate well during rides.'),
('cp089', 'user018', 'Nice swimming session; keep it going!', 'Increase your lap count gradually.', 'Practice drills for speed enhancement.'),
('cp090', 'user018', 'Yoga practice was grounding; great!', 'Explore various yoga styles for diversity.', 'Incorporate deep breathing exercises for relaxation.'),

-- Profile user019
('cp091', 'user019', 'Excellent run today! Keep challenging yourself.', 'Add tempo runs to improve speed.', 'Ensure you have proper recovery time.'),
('cp092', 'user019', 'Walking was effective; great job!', 'Aim for longer distances each week.', 'Incorporate more walking into daily activities.'),
('cp093', 'user019', 'Cycling was fantastic; good effort!', 'Join a cycling club for motivation and support.', 'Stay hydrated during your rides.'),
('cp094', 'user019', 'Swimming was strong; well done!', 'Gradually increase your distance for endurance.', 'Focus on your stroke technique for better efficiency.'),
('cp095', 'user019', 'Yoga session was calming; excellent!', 'Try new classes for variety.', 'Incorporate restorative poses for recovery.'),

-- Profile user020
('cp096', 'user020', 'Good running session! Nice pace.', 'Consider adding longer runs to your schedule.', 'Stay consistent with your training goals.'),
('cp097', 'user020', 'Walking was steady; great effort!', 'Aim for longer distances next week.', 'Incorporate more walking into your daily routine.'),
('cp098', 'user020', 'Cycling was energetic; good job!', 'Challenge yourself with hill climbs.', 'Monitor hydration during rides.'),
('cp099', 'user020', 'Swimming was refreshing; keep it up!', 'Gradually increase your swim distance.', 'Practice breathing drills for better efficiency.'),
('cp100', 'user020', 'Yoga practice was rejuvenating; well done!', 'Explore different yoga styles for variety.', 'Incorporate mindfulness into your practice.');


INSERT INTO recommendation (recommendation_id, health_log_id, coaching_plan) VALUES
-- Profile user001
('rec001', 'hl001', 'cp001'),
('rec002', 'hl002', 'cp002'),
('rec003', 'hl003', 'cp003'),
('rec004', 'hl004', 'cp004'),
('rec005', 'hl005', 'cp005'),

-- Profile user002
('rec006', 'hl006', 'cp006'),
('rec007', 'hl007', 'cp007'),
('rec008', 'hl008', 'cp008'),
('rec009', 'hl009', 'cp009'),
('rec010', 'hl010', 'cp010');

INSERT INTO recommendation (recommendation_id, health_log_id, coaching_plan) VALUES
-- Profile user003
('rec011', 'hl011', 'cp011'),
('rec012', 'hl012', 'cp012'),
('rec013', 'hl013', 'cp013'),
('rec014', 'hl014', 'cp014'),
('rec015', 'hl015', 'cp015'),

-- Profile user004
('rec016', 'hl016', 'cp016'),
('rec017', 'hl017', 'cp017'),
('rec018', 'hl018', 'cp018'),
('rec019', 'hl019', 'cp019'),
('rec020', 'hl020', 'cp020');

INSERT INTO recommendation (recommendation_id, health_log_id, coaching_plan) VALUES
-- Profile user005
('rec021', 'hl021', 'cp021'),
('rec022', 'hl022', 'cp022'),
('rec023', 'hl023', 'cp023'),
('rec024', 'hl024', 'cp024'),
('rec025', 'hl025', 'cp025'),

-- Profile user006
('rec026', 'hl026', 'cp026'),
('rec027', 'hl027', 'cp027'),
('rec028', 'hl028', 'cp028'),
('rec029', 'hl029', 'cp029'),
('rec030', 'hl030', 'cp030'),

-- Profile user007
('rec031', 'hl031', 'cp031'),
('rec032', 'hl032', 'cp032'),
('rec033', 'hl033', 'cp033'),
('rec034', 'hl034', 'cp034'),
('rec035', 'hl035', 'cp035'),

-- Profile user008
('rec036', 'hl036', 'cp036'),
('rec037', 'hl037', 'cp037'),
('rec038', 'hl038', 'cp038'),
('rec039', 'hl039', 'cp039'),
('rec040', 'hl040', 'cp040');

INSERT INTO recommendation (recommendation_id, health_log_id, coaching_plan) VALUES
-- Profile user009
('rec041', 'hl041', 'cp041'),
('rec042', 'hl042', 'cp042'),
('rec043', 'hl043', 'cp043'),
('rec044', 'hl044', 'cp044'),
('rec045', 'hl045', 'cp045'),

-- Profile user010
('rec046', 'hl046', 'cp046'),
('rec047', 'hl047', 'cp047'),
('rec048', 'hl048', 'cp048'),
('rec049', 'hl049', 'cp049'),
('rec050', 'hl050', 'cp050'),

-- Profile user011
('rec051', 'hl051', 'cp051'),
('rec052', 'hl052', 'cp052'),
('rec053', 'hl053', 'cp053'),
('rec054', 'hl054', 'cp054'),
('rec055', 'hl055', 'cp055'),

-- Profile user012
('rec056', 'hl056', 'cp056'),
('rec057', 'hl057', 'cp057'),
('rec058', 'hl058', 'cp058'),
('rec059', 'hl059', 'cp059'),
('rec060', 'hl060', 'cp060');

INSERT INTO recommendation (recommendation_id, health_log_id, coaching_plan) VALUES
-- Profile user013
('rec061', 'hl061', 'cp061'),
('rec062', 'hl062', 'cp062'),
('rec063', 'hl063', 'cp063'),
('rec064', 'hl064', 'cp064'),
('rec065', 'hl065', 'cp065'),

-- Profile user014
('rec066', 'hl066', 'cp066'),
('rec067', 'hl067', 'cp067'),
('rec068', 'hl068', 'cp068'),
('rec069', 'hl069', 'cp069'),
('rec070', 'hl070', 'cp070'),

-- Profile user015
('rec071', 'hl071', 'cp071'),
('rec072', 'hl072', 'cp072'),
('rec073', 'hl073', 'cp073'),
('rec074', 'hl074', 'cp074'),
('rec075', 'hl075', 'cp075'),

-- Profile user016
('rec076', 'hl076', 'cp076'),
('rec077', 'hl077', 'cp077'),
('rec078', 'hl078', 'cp078'),
('rec079', 'hl079', 'cp079'),
('rec080', 'hl080', 'cp080');

INSERT INTO recommendation (recommendation_id, health_log_id, coaching_plan) VALUES
-- Profile user017
('rec081', 'hl081', 'cp081'),
('rec082', 'hl082', 'cp082'),
('rec083', 'hl083', 'cp083'),
('rec084', 'hl084', 'cp084'),
('rec085', 'hl085', 'cp085'),

-- Profile user018
('rec086', 'hl086', 'cp086'),
('rec087', 'hl087', 'cp087'),
('rec088', 'hl088', 'cp088'),
('rec089', 'hl089', 'cp089'),
('rec090', 'hl090', 'cp090'),

-- Profile user019
('rec091', 'hl091', 'cp091'),
('rec092', 'hl092', 'cp092'),
('rec093', 'hl093', 'cp093'),
('rec094', 'hl094', 'cp094'),
('rec095', 'hl095', 'cp095'),

-- Profile user020
('rec096', 'hl096', 'cp096'),
('rec097', 'hl097', 'cp097'),
('rec098', 'hl098', 'cp098'),
('rec099', 'hl099', 'cp099'),
('rec100', 'hl100', 'cp100');


INSERT INTO notification (notification_id, goal_list_id, recommendation_id, device_id, sequence_number) VALUES
('notif001', 'goal001', 'rec001', 'device001', 1),
('notif002', 'goal002', 'rec002', 'device002', 1),
('notif003', 'goal003', 'rec003', 'device003', 1),
('notif004', 'goal004', 'rec004', 'device004', 1),
('notif005', 'goal005', 'rec005', 'device005', 1),
('notif006', 'goal006', 'rec006', 'device006', 1),
('notif007', 'goal007', 'rec007', 'device007', 1),
('notif008', 'goal008', 'rec008', 'device008', 1),
('notif009', 'goal009', 'rec009', 'device009', 1),
('notif010', 'goal010', 'rec010', 'device010', 1),
('notif011', 'goal011', 'rec011', 'device011', 1),
('notif012', 'goal012', 'rec012', 'device012', 1),
('notif013', 'goal013', 'rec013', 'device013', 1),
('notif014', 'goal014', 'rec014', 'device014', 1),
('notif015', 'goal015', 'rec015', 'device015', 1),
('notif016', 'goal016', 'rec016', 'device016', 1),
('notif017', 'goal017', 'rec017', 'device017', 1),
('notif018', 'goal018', 'rec018', 'device018', 1),
('notif019', 'goal019', 'rec019', 'device019', 1),
('notif020', 'goal020', 'rec020', 'device020', 1);




