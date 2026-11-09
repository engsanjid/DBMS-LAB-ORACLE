DROP TABLE employee;

CREATE TABLE employee(
    id NUMBER,
    name VARCHAR2(30),
    dept VARCHAR2(20),
    salary NUMBER,
    city VARCHAR2(30)
);

INSERT INTO employee
VALUES (101, 'rahim', 'IT', 50000, 'Dhaka');

INSERT INTO employee
VALUES (102, 'karim', 'HR', 45000, 'Dhaka');

INSERT INTO employee
VALUES (103, 'hasan', 'IT', 60000, 'Chittagong');

INSERT INTO employee
VALUES (104, 'sakib', 'Sales', 55000, 'Dhaka');

INSERT INTO employee
VALUES (105, 'nabil', 'IT', 70000, 'Dhaka');

COMMIT;

SELECT *
FROM employee;

SELECT *
FROM employee
WHERE dept = 'IT';

SELECT *
FROM employee
WHERE dept = 'IT' AND salary > 50000;

select * from employee;
-- select e_id as SID ,e_name as Name,salary from employee
-- where salary in (select salary from employee where dept='IT')
-- group by city
-- having 
-- order by city desc;
-- create table Student(
--     studentID INT
--     name varchar2(23)
--     dept varchar2(22)
--     mark int
-- );
