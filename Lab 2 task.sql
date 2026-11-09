--task 1
DROP TABLE students;
DROP TABLE courses;

CREATE TABLE students(
    roll NUMBER(4) PRIMARY KEY NOT NULL,
    name VARCHAR2(20),
    enrolment_date DATE
);

CREATE TABLE courses(
    c_id VARCHAR2(10) PRIMARY KEY NOT NULL,
    c_name VARCHAR2(30),
    year NUMBER(1),
    term NUMBER(1)
);

DESCRIBE students;
DESCRIBE courses;

ALTER TABLE students
ADD (address VARCHAR2(15));

ALTER TABLE students
MODIFY (roll NUMBER(10));

ALTER TABLE courses
RENAME COLUMN c_id TO c_no;

DESCRIBE students;
DESCRIBE courses;

INSERT INTO students
VALUES (101, 'Tanvir', TO_DATE('12-01-2025','DD-MM-YYYY'), 'Sylhet');

INSERT INTO students
VALUES (102, 'Sadia', TO_DATE('15-02-2025','DD-MM-YYYY'), 'Chittagong');

INSERT INTO students
VALUES (103, 'Arman', TO_DATE('20-03-2025','DD-MM-YYYY'), 'Rajshahi');

INSERT INTO courses
VALUES ('CSE211', 'Data Structures', 2, 1);

INSERT INTO courses
VALUES ('CSE212', 'Algorithms', 2, 2);

SELECT * FROM students;

SELECT * FROM courses;


--task 2

DROP TABLE Employee;

CREATE TABLE Employee(
    employee_id NUMBER(10) NOT NULL,
    first_name VARCHAR2(25) NOT NULL,
    last_name VARCHAR2(30) NOT NULL
);

ALTER TABLE Employee
MODIFY (employee_id NUMBER(10) PRIMARY KEY);

ALTER TABLE Employee
DROP COLUMN last_name;

INSERT INTO Employee
VALUES (201, 'Tanvir');

INSERT INTO Employee
VALUES (202, 'Sadia');

INSERT INTO Employee
VALUES (203, 'Arman');

DESCRIBE Employee;

SELECT * FROM Employee;