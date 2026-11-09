SET DEFINE OFF;
-- ============================================================
--  DENTAL CLINIC MANAGEMENT SYSTEM
--  DBMS Lab Project - Oracle SQL
--  Student : Md Sanjid Islam
--  Dept.   : CSE, Dhaka International University (Batch D-98, Roll 21)
--  Run in  : Oracle SQL*Plus / Oracle Live SQL / SQL Developer


-- ============================================================
--  SECTION 1 : DDL - TABLE MANAGEMENT
--  CREATE TABLE, Data Types (NUMBER, VARCHAR2, CHAR, DATE),
--  PRIMARY KEY, FOREIGN KEY, NOT NULL, CHECK
-- ============================================================

DROP TABLE Payment     CASCADE CONSTRAINTS;
DROP TABLE Appointment CASCADE CONSTRAINTS;
DROP TABLE Doctor      CASCADE CONSTRAINTS;
DROP TABLE Treatment   CASCADE CONSTRAINTS;
DROP TABLE Patient     CASCADE CONSTRAINTS;
DROP TABLE Chamber     CASCADE CONSTRAINTS;

CREATE TABLE Chamber (
    Chamber_ID   NUMBER(4)    PRIMARY KEY,
    Chamber_Name VARCHAR2(50) NOT NULL,
    Area         VARCHAR2(30) NOT NULL,
    City         VARCHAR2(30) DEFAULT 'Dhaka',
    Phone        VARCHAR2(15)
);

CREATE TABLE Doctor (
    Doctor_ID       NUMBER(4)    PRIMARY KEY,
    Doctor_Name     VARCHAR2(60) NOT NULL,
    Specialization  VARCHAR2(40) NOT NULL,
    Qualification   VARCHAR2(60),
    Gender          CHAR(1)      CHECK (Gender IN ('M', 'F')),
    Phone           VARCHAR2(15),
    Consultation_Fee NUMBER(8,2) CHECK (Consultation_Fee > 0),
    Chamber_ID      NUMBER(4),
    CONSTRAINT fk_doctor_chamber
        FOREIGN KEY (Chamber_ID) REFERENCES Chamber(Chamber_ID)
);

CREATE TABLE Patient (
    Patient_ID    NUMBER(5)    PRIMARY KEY,
    Patient_Name  VARCHAR2(60) NOT NULL,
    Date_of_Birth DATE,
    Gender        CHAR(1)      CHECK (Gender IN ('M', 'F', 'O')),
    Phone         VARCHAR2(15) NOT NULL,
    Area          VARCHAR2(30),
    City          VARCHAR2(30) DEFAULT 'Dhaka'
);

CREATE TABLE Treatment (
    Treatment_ID   NUMBER(4)    PRIMARY KEY,
    Treatment_Name VARCHAR2(50) NOT NULL,
    Category       VARCHAR2(30),
    Base_Fee       NUMBER(8,2)  CHECK (Base_Fee > 0),
    Duration_Min   NUMBER(3)    CHECK (Duration_Min > 0)
);

CREATE TABLE Appointment (
    Appointment_ID   NUMBER(6)    PRIMARY KEY,
    Patient_ID       NUMBER(5)    NOT NULL,
    Doctor_ID        NUMBER(4)    NOT NULL,
    Treatment_ID     NUMBER(4)    NOT NULL,
    Appointment_Date DATE         NOT NULL,
    Status           VARCHAR2(12) DEFAULT 'Scheduled'
                     CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),
    CONSTRAINT fk_app_patient
        FOREIGN KEY (Patient_ID)   REFERENCES Patient(Patient_ID),
    CONSTRAINT fk_app_doctor
        FOREIGN KEY (Doctor_ID)    REFERENCES Doctor(Doctor_ID),
    CONSTRAINT fk_app_treatment
        FOREIGN KEY (Treatment_ID) REFERENCES Treatment(Treatment_ID)
);

-- PAYMENT is a WEAK ENTITY: no single key of its own.
-- Its Primary Key = Parent key (Appointment_ID) + Payment_No
CREATE TABLE Payment (
    Appointment_ID NUMBER(6)    NOT NULL,
    Payment_No     NUMBER(2)    NOT NULL,
    Payment_Date   DATE,
    Amount_Paid    NUMBER(8,2)  CHECK (Amount_Paid >= 0),
    Discount       NUMBER(8,2)  DEFAULT 0,
    Payment_Method VARCHAR2(15) CHECK (Payment_Method IN ('Cash', 'bKash', 'Card')),
    CONSTRAINT pk_payment PRIMARY KEY (Appointment_ID, Payment_No),
    CONSTRAINT fk_payment_app
        FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
);

-- DESCRIBE - show the structure (schema) of a table
DESCRIBE Chamber;
DESCRIBE Doctor;
DESCRIBE Patient;
DESCRIBE Treatment;
DESCRIBE Appointment;
DESCRIBE Payment;

-- ============================================================
--  SECTION 2 : DDL - ALTER TABLE
--  ADD, MODIFY, RENAME COLUMN, DROP COLUMN,
--  TRUNCATE TABLE, DROP TABLE
-- ============================================================

-- ADD a new column
ALTER TABLE Patient ADD (Email VARCHAR2(60));

-- ADD a temporary column (dropped below, only for demo)
ALTER TABLE Patient ADD (Temp_Note VARCHAR2(20));

-- MODIFY a column (increase size of Phone)
ALTER TABLE Patient MODIFY (Phone VARCHAR2(20));

-- RENAME COLUMN (Oracle syntax)
ALTER TABLE Patient RENAME COLUMN Temp_Note TO Visit_Note;

-- DROP COLUMN
ALTER TABLE Patient DROP COLUMN Visit_Note;

-- TRUNCATE + DROP TABLE demo on a throwaway table
CREATE TABLE Temp_Log (
    Log_ID   NUMBER(4),
    Log_Text VARCHAR2(50)
);
INSERT INTO Temp_Log VALUES (1, 'test row');
TRUNCATE TABLE Temp_Log;   -- removes all rows, keeps structure, faster than DELETE
DROP TABLE Temp_Log;       -- removes the table completely

COMMIT;

-- ============================================================
--  SECTION 3 : DML - DATA MANIPULATION
--  INSERT INTO, UPDATE, DELETE, TO_DATE()
-- ============================================================

-- INSERT INTO Chamber (parent table first)
INSERT INTO Chamber VALUES (1, 'Laser Dental Care',    'Uttara',    'Dhaka', '01711940185');
INSERT INTO Chamber VALUES (2, 'Smile Care Dental',    'Mirpur',    'Dhaka', '01811223344');
INSERT INTO Chamber VALUES (3, 'City Dental Hospital', 'Dhanmondi', 'Dhaka', '01922334455');

-- INSERT INTO Doctor
INSERT INTO Doctor VALUES (101, 'Dr. Saima Akter',    'General Dentist',  'BDS, MDS', 'F', '01711000001',  800, 1);
INSERT INTO Doctor VALUES (102, 'Dr. Shakhawat Hossain','Oral Surgeon',   'BDS, FCPS','M', '01711000002', 1200, 1);
INSERT INTO Doctor VALUES (103, 'Dr. Rafea Oishee',   'Cosmetic Dentist', 'BDS, PGT', 'F', '01711000003', 1000, 2);
INSERT INTO Doctor VALUES (104, 'Dr. Ibrahim Khalil', 'Orthodontist',     'BDS, MS',  'M', '01711000004', 1500, 2);
INSERT INTO Doctor VALUES (105, 'Dr. A. S. Sarfuddin','General Dentist',  'BDS, MPH', 'M', '01711000005',  800, 3);

-- INSERT INTO Patient (TO_DATE converts text to DATE - Oracle)
INSERT INTO Patient VALUES (1001, 'Rahim Uddin',    TO_DATE('12-03-1995','DD-MM-YYYY'), 'M', '01720111222', 'Uttara',    'Dhaka', 'rahim@mail.com');
INSERT INTO Patient VALUES (1002, 'Fatema Begum',   TO_DATE('25-07-2000','DD-MM-YYYY'), 'F', '01820333444', 'Mirpur',    'Dhaka', 'fatema@mail.com');
INSERT INTO Patient VALUES (1003, 'Karim Islam',    TO_DATE('05-11-1988','DD-MM-YYYY'), 'M', '01920555666', 'Dhanmondi', 'Dhaka', NULL);
INSERT INTO Patient VALUES (1004, 'Ayesha Siddika', TO_DATE('18-01-2010','DD-MM-YYYY'), 'F', '01720777888', 'Uttara',    'Dhaka', 'ayesha@mail.com');
INSERT INTO Patient VALUES (1005, 'Tanvir Hasan',   TO_DATE('30-09-1999','DD-MM-YYYY'), 'M', '01620111999', 'Mirpur',    'Dhaka', NULL);
INSERT INTO Patient VALUES (1006, 'Nusrat Jahan',   TO_DATE('14-02-1997','DD-MM-YYYY'), 'F', '01520222111', 'Banani',    'Dhaka', 'nusrat@mail.com');
INSERT INTO Patient VALUES (1007, 'Sabbir Ahmed',   TO_DATE('09-06-2005','DD-MM-YYYY'), 'M', '01320333222', 'Uttara',    'Dhaka', 'sabbir@mail.com');
INSERT INTO Patient VALUES (1008, 'Sharmin Akter',  TO_DATE('21-12-1992','DD-MM-YYYY'), 'F', '01420444333', 'Dhanmondi', 'Dhaka', NULL);

-- INSERT INTO Treatment
INSERT INTO Treatment VALUES (201, 'Scaling and Polishing', 'Cleaning',    1500, 30);
INSERT INTO Treatment VALUES (202, 'Root Canal',          'Surgery',     8000, 60);
INSERT INTO Treatment VALUES (203, 'Tooth Filling',       'Restorative', 2500, 40);
INSERT INTO Treatment VALUES (204, 'Braces Consultation', 'Orthodontics',1000, 20);
INSERT INTO Treatment VALUES (205, 'Teeth Whitening',     'Cosmetic',    6000, 45);
INSERT INTO Treatment VALUES (206, 'Tooth Extraction',    'Surgery',     3000, 30);

-- INSERT INTO Appointment (Appointment_ID, Patient, Doctor, Treatment, Date, Status)
INSERT INTO Appointment VALUES (5001, 1001, 101, 201, TO_DATE('02-11-2026','DD-MM-YYYY'), 'Completed');
INSERT INTO Appointment VALUES (5002, 1002, 103, 205, TO_DATE('03-11-2026','DD-MM-YYYY'), 'Completed');
INSERT INTO Appointment VALUES (5003, 1003, 102, 202, TO_DATE('03-11-2026','DD-MM-YYYY'), 'Completed');
INSERT INTO Appointment VALUES (5004, 1004, 101, 203, TO_DATE('04-11-2026','DD-MM-YYYY'), 'Completed');
INSERT INTO Appointment VALUES (5005, 1005, 104, 204, TO_DATE('05-11-2026','DD-MM-YYYY'), 'Completed');
INSERT INTO Appointment VALUES (5006, 1006, 105, 206, TO_DATE('06-11-2026','DD-MM-YYYY'), 'Scheduled');
INSERT INTO Appointment VALUES (5007, 1007, 101, 201, TO_DATE('07-11-2026','DD-MM-YYYY'), 'Scheduled');
INSERT INTO Appointment VALUES (5008, 1008, 103, 205, TO_DATE('08-11-2026','DD-MM-YYYY'), 'Scheduled');
INSERT INTO Appointment VALUES (5009, 1001, 102, 206, TO_DATE('09-11-2026','DD-MM-YYYY'), 'Cancelled');
INSERT INTO Appointment VALUES (5010, 1002, 101, 203, TO_DATE('10-11-2026','DD-MM-YYYY'), 'Scheduled');
INSERT INTO Appointment VALUES (5011, 1003, 104, 204, TO_DATE('10-11-2026','DD-MM-YYYY'), 'Scheduled');
INSERT INTO Appointment VALUES (5012, 1005, 105, 201, TO_DATE('11-11-2026','DD-MM-YYYY'), 'Scheduled');

-- INSERT INTO Payment (paid against completed appointments only)
-- Appointment 5006 is Scheduled, so it has NO payment row yet.
INSERT INTO Payment VALUES (5001, 1, TO_DATE('02-11-2026','DD-MM-YYYY'), 2300, 0,   'Cash');
INSERT INTO Payment VALUES (5002, 1, TO_DATE('03-11-2026','DD-MM-YYYY'), 7000, 0,   'bKash');
INSERT INTO Payment VALUES (5003, 1, TO_DATE('03-11-2026','DD-MM-YYYY'), 5000, 500, 'Card');
INSERT INTO Payment VALUES (5003, 2, TO_DATE('05-11-2026','DD-MM-YYYY'), 4000, 0,   'Cash');
INSERT INTO Payment VALUES (5004, 1, TO_DATE('04-11-2026','DD-MM-YYYY'), 3300, 0,   'bKash');
INSERT INTO Payment VALUES (5005, 1, TO_DATE('05-11-2026','DD-MM-YYYY'), 2500, 0,   'Cash');

COMMIT;

-- UPDATE - change one row
UPDATE Appointment
SET    Status = 'Completed'
WHERE  Appointment_ID = 5007;

-- UPDATE with a calculated value (10% fee increase for surgeons)
UPDATE Doctor
SET    Consultation_Fee = Consultation_Fee * 1.10
WHERE  Specialization = 'Oral Surgeon';

-- DELETE - remove the cancelled appointment permanently
DELETE FROM Appointment
WHERE  Appointment_ID = 5009;

COMMIT;



-- ============================================================
--  SECTION 4 : SELECT & FILTERING
-- ============================================================

-- Q1. SELECT * - all columns, all patients
SELECT * FROM Patient;

-- Q2. Specific columns only
SELECT Patient_ID, Patient_Name, Phone, City FROM Patient;

-- Q3. DISTINCT - list each area only once (no duplicate)
SELECT DISTINCT Area FROM Patient;

-- Q4. AS / Alias + Calculated Field (total charge of a treatment)
SELECT Treatment_Name AS Treatment,
       Base_Fee      AS "Fee (BDT)",
       Base_Fee + 500 AS "Fee With X-Ray"
FROM   Treatment;

-- Q5. WHERE + Comparison Operators (fee greater than 2000)
SELECT Doctor_Name, Specialization, Consultation_Fee
FROM   Doctor
WHERE  Consultation_Fee > 1000;

-- Q6. AND / OR
SELECT Patient_Name, Area, Gender
FROM   Patient
WHERE  Area = 'Uttara' AND Gender = 'F';

SELECT Patient_Name, Area
FROM   Patient
WHERE  Area = 'Mirpur' OR Area = 'Banani';

-- Q7. BETWEEN / NOT BETWEEN
SELECT Treatment_Name, Base_Fee
FROM   Treatment
WHERE  Base_Fee BETWEEN 2000 AND 7000;

SELECT Treatment_Name, Base_Fee
FROM   Treatment
WHERE  Base_Fee NOT BETWEEN 2000 AND 7000;

-- Q8. IN / NOT IN
SELECT Patient_Name, Area
FROM   Patient
WHERE  Area IN ('Uttara', 'Mirpur', 'Banani');

SELECT Doctor_Name, Specialization
FROM   Doctor
WHERE  Specialization NOT IN ('General Dentist');

-- Q9. LIKE - pattern matching (% = any characters, _ = one character)
SELECT Patient_Name, Phone
FROM   Patient
WHERE  Phone LIKE '017%';

SELECT Patient_Name
FROM   Patient
WHERE  Patient_Name LIKE '%Akter';

-- Q10. IS NULL / IS NOT NULL (patients who gave no email)
SELECT Patient_Name, Phone
FROM   Patient
WHERE  Email IS NULL;

SELECT Patient_Name, Email
FROM   Patient
WHERE  Email IS NOT NULL;

-- ============================================================
--  SECTION 5 : SORTING & AGGREGATE FUNCTIONS
--  ORDER BY, COUNT, SUM, AVG, MIN, MAX, NVL
-- ============================================================

-- Q11. ORDER BY ASC / DESC
SELECT Doctor_Name, Consultation_Fee
FROM   Doctor
ORDER BY Consultation_Fee DESC;

SELECT Patient_Name, Area
FROM   Patient
ORDER BY Patient_Name ASC;

-- Q12. Multiple-column ORDER BY (Area A-Z, then Name A-Z)
SELECT Patient_Name, Area, City
FROM   Patient
ORDER BY Area ASC, Patient_Name ASC;

-- Q13. Aggregate functions on the whole table
SELECT COUNT(*)          AS Total_Appointments,
       SUM(Amount_Paid)  AS Total_Collection,
       AVG(Amount_Paid)  AS Average_Payment,
       MIN(Amount_Paid)  AS Smallest_Payment,
       MAX(Amount_Paid)  AS Largest_Payment
FROM   Payment;

-- Q14. COUNT on a filtered set
SELECT COUNT(*) AS Completed_Appointments
FROM   Appointment
WHERE  Status = 'Completed';

-- Q15. NVL - replace NULL with a value
-- NVL(Amount, 0): if no payment is recorded, show 0 instead of blank
SELECT a.Appointment_ID,
       a.Status,
       NVL(p.Amount_Paid, 0) AS Paid_Amount
FROM   Appointment a
LEFT JOIN Payment p ON p.Appointment_ID = a.Appointment_ID
ORDER BY a.Appointment_ID;

-- ============================================================
--  SECTION 6 : ADVANCED SQL QUERIES
--  GROUP BY, HAVING, WHERE vs HAVING, Subquery,
--  IN with Subquery, Aggregate Subquery, Correlated Subquery
-- ============================================================

-- Q16. GROUP BY - how many appointments per doctor
SELECT Doctor_ID, COUNT(*) AS Total_Appointments
FROM   Appointment
GROUP BY Doctor_ID
ORDER BY Doctor_ID;

-- Q17. GROUP BY + SUM - total collection per payment method
SELECT Payment_Method, COUNT(*) AS Times_Used, SUM(Amount_Paid) AS Total
FROM   Payment
GROUP BY Payment_Method;

-- Q18. HAVING - filter AFTER grouping
-- Doctors who handled more than 1 appointment
SELECT Doctor_ID, COUNT(*) AS Total_Appointments
FROM   Appointment
GROUP BY Doctor_ID
HAVING COUNT(*) > 1;

-- Q19. WHERE vs HAVING in one query
-- WHERE  filters rows BEFORE grouping (only Completed rows count)
-- HAVING filters groups AFTER grouping (keep groups with total > 1)
SELECT Doctor_ID, COUNT(*) AS Completed_Count
FROM   Appointment
WHERE  Status = 'Completed'          -- WHERE: row filter
GROUP BY Doctor_ID
HAVING COUNT(*) > 1                  -- HAVING: group filter
ORDER BY Doctor_ID;

-- Q20. Subquery (single value) - doctors charging above average fee
SELECT Doctor_Name, Consultation_Fee
FROM   Doctor
WHERE  Consultation_Fee > (SELECT AVG(Consultation_Fee) FROM Doctor);

-- Q21. IN with Subquery - patients who have a Completed appointment
SELECT Patient_Name, Area
FROM   Patient
WHERE  Patient_ID IN (
           SELECT Patient_ID FROM Appointment WHERE Status = 'Completed'
       );

-- Q22. Aggregate Subquery - treatments costlier than the average treatment
SELECT Treatment_Name, Base_Fee
FROM   Treatment
WHERE  Base_Fee > (SELECT AVG(Base_Fee) FROM Treatment);

-- Q23. Correlated Subquery - the subquery uses a value from the
-- outer row (d.Doctor_ID), so it runs once for every doctor.
-- Doctors whose appointment count is above the average count per doctor.
SELECT d.Doctor_Name,
       (SELECT COUNT(*) FROM Appointment a
         WHERE a.Doctor_ID = d.Doctor_ID) AS My_Appointments
FROM   Doctor d
WHERE  (SELECT COUNT(*) FROM Appointment a
         WHERE a.Doctor_ID = d.Doctor_ID)
       >
       (SELECT AVG(cnt) FROM (
           SELECT COUNT(*) AS cnt FROM Appointment GROUP BY Doctor_ID
       ));

-- Q24. Correlated Subquery (EXISTS) - patients who never paid anything
SELECT p.Patient_Name, p.Phone
FROM   Patient p
WHERE  EXISTS (
           SELECT 1 FROM Appointment a
           WHERE  a.Patient_ID = p.Patient_ID
       )
AND NOT EXISTS (
           SELECT 1
           FROM   Appointment a
           JOIN   Payment pay ON pay.Appointment_ID = a.Appointment_ID
           WHERE  a.Patient_ID = p.Patient_ID
       );

-- Q25. Full report - patient, doctor, treatment, fee and amount paid
SELECT p.Patient_Name                     AS Patient,
       d.Doctor_Name                      AS Doctor,
       t.Treatment_Name                   AS Treatment,
       t.Base_Fee + d.Consultation_Fee    AS Total_Bill,
       NVL(SUM(pay.Amount_Paid), 0)       AS Paid,
       (t.Base_Fee + d.Consultation_Fee)
         - NVL(SUM(pay.Amount_Paid), 0)   AS Balance_Due
FROM   Appointment a
JOIN   Patient   p   ON p.Patient_ID   = a.Patient_ID
JOIN   Doctor    d   ON d.Doctor_ID    = a.Doctor_ID
JOIN   Treatment t   ON t.Treatment_ID = a.Treatment_ID
LEFT JOIN Payment pay ON pay.Appointment_ID = a.Appointment_ID
GROUP BY p.Patient_Name, d.Doctor_Name, t.Treatment_Name,
         t.Base_Fee, d.Consultation_Fee
ORDER BY Balance_Due DESC;

-- ============================================================
--  END OF SCRIPT

