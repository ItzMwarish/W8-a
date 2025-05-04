-- Question 1: Build a Complete Database Management System
-- Objective:
-- Design and implement a full-featured database using only MySQL.

-- What to do:

-- Choose a real-world use case (e.g., Library Management, Student Records, Clinic Booking System, Inventory Tracking, etc.)

-- Create a well-structured relational database using SQL.

-- Use SQL to create:

-- Tables with proper constraints (PK, FK, NOT NULL, UNIQUE)

-- Relationships (1-1, 1-M, M-M where needed)

-- Deliverables:

-- A single .sql file containing your:

-- CREATE TABLE statements

-- Sample  data


-- HOSPITAL MANAGEMENT SYSTEM
CREATE database hospitalManagement;
use hospitalManagement;
-- patient registration table 
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    pfname VARCHAR(50) NOT NULL,
    psname VARCHAR(50),
    plname VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    sex ENUM('Male', 'Female') NOT NULL,
    residence VARCHAR(100),
    idnumber VARCHAR(20) UNIQUE
);

-- outpatient table
CREATE TABLE outpatient (
    op_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    op_number VARCHAR(20) NOT NULL UNIQUE,
    visit_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

--inpatient table
CREATE TABLE inpatient (
    ip_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    ip_number VARCHAR(20) NOT NULL UNIQUE,
    admission_date DATETIME NOT NULL,
    discharge_date DATETIME,
    room_number VARCHAR(10),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- hospital departments 
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

-- doctors table
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    specialization VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
--appointment table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    dept_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
-- laboratory tests table
CREATE TABLE lab_tests (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    test_type VARCHAR(100),
    test_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    result TEXT,
    doctor_id INT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
--mortuary table
CREATE TABLE morgue_records (
    morgue_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT ,
    date_of_death DATE NOT NULL,
    cause_of_death TEXT,
    released BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- pharmacy table
CREATE TABLE pharmacy (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    medication VARCHAR(100),
    dosage VARCHAR(50),
    prescription_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- billing table
CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    bill_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- insurance table
CREATE TABLE insurance (
    insurance_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    provider_name VARCHAR(100),
    policy_number VARCHAR(50) UNIQUE,
    coverage_amount DECIMAL(10, 2),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- morgue billing table
CREATE TABLE morgue_billing (
    morgue_bill_id INT AUTO_INCREMENT PRIMARY KEY,
    morgue_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    bill_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (morgue_id) REFERENCES morgue_records(morgue_id)
);
-- staff table
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    position VARCHAR(100),
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);


-- sample test data
--  patients
INSERT INTO patients (pfname, psname, plname, dob, sex, residence, idnumber) VALUES
('Taylor', 'A', 'Swift', '1989-12-13', 'Female', 'Nashville, TN', 'TS19891213'),
('Beyoncé', 'G', 'Knowles', '1981-09-04', 'Female', 'Houston, TX', 'BK19810904'),
('Drake', 'A', 'Graham', '1986-10-24', 'Male', 'Toronto, ON', 'DG19861024'),
('Ariana', 'G', 'Grande', '1993-06-26', 'Female', 'Boca Raton, FL', 'AG19930626'),
('Ed', 'C', 'Sheeran', '1991-02-17', 'Male', 'Framlingham, UK', 'ES19910217'),
('Rihanna', 'R', 'Fenty', '1988-02-20', 'Female', 'Saint Michael, Barbados', 'RF19880220'),
('Bruno', 'M', 'Mars', '1985-10-08', 'Male', 'Honolulu, HI', 'BM19851008'),
('Lady', NULL, 'Gaga', '1986-03-28', 'Female', 'New York, NY', 'LG19860328'),
('Justin', 'D', 'Bieber', '1994-03-01', 'Male', 'London, ON', 'JB19940301'),
('Adele', 'L', 'Adkins', '1988-05-05', 'Female', 'Tottenham, UK', 'AA19880505');

-- outpatient
-- Insert outpatient records
INSERT INTO outpatient (patient_id, op_number, visit_date) VALUES
(1, 'OP1001', '2023-01-15 09:30:00'),
(3, 'OP1002', '2023-01-16 10:15:00'),
(5, 'OP1003', '2023-01-17 11:00:00'),
(7, 'OP1004', '2023-01-18 14:45:00'),
(9, 'OP1005', '2023-01-19 16:30:00');

-- inpatient
INSERT INTO inpatient (patient_id, ip_number, admission_date, discharge_date, room_number) VALUES
(2, 'IP2001', '2023-01-10 08:00:00', '2023-01-20 12:00:00', '101A'),
(4, 'IP2002', '2023-01-12 10:30:00', NULL, '205B'),
(6, 'IP2003', '2023-01-14 14:15:00', '2023-01-25 10:00:00', '312C'),
(8, 'IP2004', '2023-01-16 16:45:00', NULL, '104D'),
(10, 'IP2005', '2023-01-18 09:00:00', NULL, '208A');

-- departments
INSERT INTO departments (dept_name) VALUES 
('Cardiology'),
('Neurology'),
('Oncology'),
('Pediatrics'),
('Orthopedics'),
('Emergency'),
('Radiology'),
('General Surgery');

-- doctors
INSERT INTO doctors (fname, lname, specialization, dept_id) VALUES
('Leonardo', 'DiCaprio', 'Cardiologist', 1),
('Jennifer', 'Lawrence', 'Neurologist', 2),
('Tom', 'Hanks', 'Oncologist', 3),
('Emma', 'Watson', 'Pediatrician', 4),
('Dwayne', 'Johnson', 'Orthopedic Surgeon', 5),
('Scarlett', 'Johansson', 'Emergency Physician', 6),
('Robert', 'Downey', 'Radiologist', 7),
('Angelina', 'Jolie', 'General Surgeon', 8);

-- appointments
INSERT INTO appointments (patient_id, doctor_id, dept_id, appointment_date, reason) VALUES
(1, 1, 1, '2023-02-01 10:00:00', 'Heart checkup'),
(2, 2, 2, '2023-02-02 11:30:00', 'Neurological consultation'),
(3, 3, 3, '2023-02-03 14:00:00', 'Cancer screening'),
(4, 4, 4, '2023-02-04 09:15:00', 'Child wellness check'),
(5, 5, 5, '2023-02-05 13:45:00', 'Knee pain evaluation');

-- lab tests

INSERT INTO lab_tests (patient_id, test_type, test_date, result, doctor_id) VALUES
(1, 'Blood Test', '2023-01-15 10:00:00', 'Normal', 1),
(2, 'MRI Scan', '2023-01-11 09:30:00', 'Minor abnormalities detected', 2),
(3, 'Biopsy', '2023-01-17 11:45:00', 'Results pending', 3),
(4, 'Urinalysis', '2023-01-13 14:15:00', 'Normal', 4),
(5, 'X-Ray', '2023-01-19 16:00:00', 'Fracture detected', 5);

--morgue records
INSERT INTO morgue_records (patient_id, date_of_death, cause_of_death, released) VALUES
(NULL, '2023-01-05', 'Unknown', FALSE),
(NULL, '2023-01-12', 'Cardiac arrest', TRUE),
(6, '2023-01-26', 'Respiratory failure', FALSE),
(7, '2023-01-20', 'Accident', TRUE),
(8, '2023-01-30', 'Natural causes', FALSE);

--  pharmacy records
INSERT INTO pharmacy (patient_id, doctor_id, medication, dosage, prescription_date) VALUES
(1, 1, 'Lipitor', '10mg daily', '2023-01-15 10:30:00'),
(2, 2, 'Gabapentin', '300mg 3x daily', '2023-01-11 10:00:00'),
(3, 3, 'Tamoxifen', '20mg daily', '2023-01-17 12:30:00'),
(4, 4, 'Amoxicillin', '250mg 2x daily', '2023-01-13 14:45:00'),
(5, 5, 'Ibuprofen', '400mg every 6 hours', '2023-01-19 16:30:00');

--  billing records
INSERT INTO billing (patient_id, amount, bill_date, status) VALUES
(1, 150.00, '2023-01-15 11:00:00', 'Paid'),
(2, 1200.00, '2023-01-20 13:00:00', 'Unpaid'),
(3, 350.00, '2023-01-17 13:30:00', 'Paid'),
(4, 85.00, '2023-01-13 15:00:00', 'Paid'),
(5, 225.00, '2023-01-19 17:00:00', 'Unpaid');

--  insurance records
INSERT INTO insurance (patient_id, provider_name, policy_number, coverage_amount) VALUES
(1, 'Blue Cross', 'BC12345678', 500000.00),
(2, 'Aetna', 'AE87654321', 1000000.00),
(3, 'United Health', 'UH19283746', 750000.00),
(4, 'Cigna', 'CI56473829', 300000.00),
(5, 'Kaiser', 'KA98765432', 600000.00);

--  morgue billing records
INSERT INTO morgue_billing (morgue_id, amount, bill_date, status) VALUES
(1, 2500.00, '2023-01-06 10:00:00', 'Unpaid'),
(2, 1800.00, '2023-01-13 11:30:00', 'Paid'),
(3, 3000.00, '2023-01-27 09:00:00', 'Unpaid');

-- staff records
INSERT INTO staff (fname, lname, position, hire_date, salary) VALUES
('Chris', 'Hemsworth', 'Nurse', '2020-05-15', 65000.00),
('Gal', 'Gadot', 'Receptionist', '2021-02-10', 45000.00),
('Ryan', 'Reynolds', 'Lab Technician', '2019-11-22', 58000.00),
('Margot', 'Robbie', 'Administrator', '2018-07-30', 75000.00),
('Idris', 'Elba', 'Security', '2022-01-05', 40000.00);