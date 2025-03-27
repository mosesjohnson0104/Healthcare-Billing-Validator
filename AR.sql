create database AR;

use AR;

-- Patient Information Table
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    contact_number VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    address TEXT,
    status ENUM('Active', 'Termed') DEFAULT 'Active'
);

-- Hospital Information Table
CREATE TABLE Hospital (
    hospital_id INT PRIMARY KEY AUTO_INCREMENT,
    hospital_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    contact_number VARCHAR(15)
);

-- Medical Services Table
CREATE TABLE Medical_Service (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    hospital_id INT,
    service_date DATE,
    service_description TEXT,
    covered ENUM('Covered', 'Non-Covered'),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id)
);

-- Insurance Information Table
CREATE TABLE Insurance (
    insurance_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    provider_name VARCHAR(100),
    policy_number VARCHAR(50),
    coverage_details TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Insert Patients
INSERT INTO Patient (first_name, last_name, dob, gender, contact_number, email, address, status)
VALUES 
('John', 'Doe', '1985-06-15', 'Male', '1234567890', 'john.doe@email.com', '123 Elm St', 'Active'),
('Jane', 'Smith', '1990-09-21', 'Female', '0987654321', 'jane.smith@email.com', '456 Oak St', 'Active'),
('Robert', 'Brown', '1978-12-05', 'Male', '5551234567', 'robert.b@email.com', '789 Pine St', 'Termed'),
('Emily', 'Clark', '2000-04-17', 'Female', '4449876543', 'emily.c@email.com', '101 Maple St', 'Active'),
('Michael', 'Johnson', '1995-07-30', 'Male', '2224567890', 'michael.j@email.com', '202 Cedar St', 'Termed');

-- Insert Hospitals
INSERT INTO Hospital (hospital_name, location, contact_number)
VALUES 
('General Hospital', 'New York', '1111111111'),
('City Care', 'Los Angeles', '2222222222'),
('Metro Medical', 'Chicago', '3333333333'),
('Wellness Center', 'Houston', '4444444444'),
('Community Hospital', 'Miami', '5555555555');

-- Insert Medical Services Taken
INSERT INTO Medical_Service (patient_id, hospital_id, service_date, service_description, covered)
VALUES
(1, 1, '2023-01-15', 'General Checkup', 'Covered'),
(2, 2, '2023-03-10', 'Dental Cleaning', 'Covered'),
(3, 3, '2022-07-20', 'MRI Scan', 'Non-Covered'),
(4, 4, '2023-09-05', 'Physical Therapy', 'Covered'),
(5, 5, '2022-11-11', 'Surgery Consultation', 'Non-Covered');

-- Insert Insurance Details
INSERT INTO Insurance (patient_id, provider_name, policy_number, coverage_details)
VALUES
(1, 'Blue Cross', 'BC12345', 'Full Medical Coverage'),
(2, 'Aetna', 'AE67890', 'Dental & General Checkup'),
(3, 'United Health', 'UH54321', 'MRI Not Covered'),
(4, 'Cigna', 'CG11223', 'Physical Therapy Covered'),
(5, 'Humana', 'HM98765', 'Surgery Not Covered');

-- 1. Get Patient Personal Information by Patient ID
SELECT * FROM Patient WHERE patient_id = 1;
SELECT * FROM Patient;


-- 2. Get Patient Information from All Tables by Patient ID
SELECT 
    p.patient_id, p.first_name, p.last_name, p.dob, p.gender, p.contact_number, p.email, p.address, p.status,
    h.hospital_name, h.location,
    m.service_date, m.service_description, m.covered,
    i.provider_name, i.policy_number, i.coverage_details
FROM Patient p
LEFT JOIN Medical_Service m ON p.patient_id = m.patient_id
LEFT JOIN Hospital h ON m.hospital_id = h.hospital_id
LEFT JOIN Insurance i ON p.patient_id = i.patient_id
WHERE p.patient_id = 1;

-- 3. Get Services Taken by Patient in a Specific Year & Hospital
SELECT 
    p.patient_id, p.first_name, p.last_name,
    m.service_date, m.service_description,
    h.hospital_name
FROM Patient p
LEFT JOIN (SELECT * FROM Medical_Service) m ON p.patient_id = m.patient_id
JOIN Hospital h ON m.hospital_id = h.hospital_id
WHERE YEAR(m.service_date) = 2023
AND h.hospital_name = 'General Hospital';

-- 4. Update Patient Status (Active/Termed) & Show Updated Column
UPDATE Patient SET status = 'Active' WHERE patient_id = 3;

SELECT patient_id, first_name, last_name, status FROM Patient;

-- 5. Update & Show If a Service is Covered or Not
UPDATE Medical_Service SET covered = 'Covered' WHERE service_id = 5;

SELECT patient_id, service_date, service_description, covered FROM Medical_Service;

-- 6. Validate Service from CMS & AMA Guidelines
-- Create a Validation Table
CREATE TABLE Valid_Services (
    service_description VARCHAR(255) PRIMARY KEY
);

-- Insert CMS & AMA Approved Services
INSERT INTO Valid_Services (service_description)
VALUES 
('General Checkup'),
('Dental Cleaning'),
('Physical Therapy');

-- Query to Validate if the Service is Approved
SELECT 
    m.service_description, 
    CASE 
        WHEN v.service_description IS NOT NULL THEN 'Valid Service'
        ELSE 'Invalid Service'
    END AS validation_status
FROM Medical_Service m
LEFT JOIN Valid_Services v ON m.service_description = v.service_description;
	