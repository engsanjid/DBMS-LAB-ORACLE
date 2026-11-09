-- =========================================================
-- TABLE CREATION
-- =========================================================

-- Q1. Create an EMPLOYEE table with the following columns:
-- emp_id, emp_name, emp_salary, emp_dept, gender and city.
-- emp_id should be Primary Key, emp_name and emp_dept should be NOT NULL,
-- salary should be greater than 0, and gender should be either M or F.

create table employee(
    emp_id number primary key,
    emp_name varchar2(20) not null,
    emp_salary number check(emp_salary > 0),
    emp_dept varchar2(20) not null,
    gender char(1) check(gender in ('M','F')),
    city varchar2(20)
);


-- =========================================================
-- INSERT DATA
-- =========================================================

-- Q2. Insert 10 employee records into the EMPLOYEE table.

insert into employee values(1,'John',50000,'IT','M','New York');
insert into employee values(2,'Jane',60000,'HR','F','Los Angeles'); 
insert into employee values(3,'Mike',55000,'IT','M','Chicago');
insert into employee values(4,'Emily',70000,'Finance','F','Houston');
insert into employee values(5,'David',65000,'HR','M','Phoenix');
insert into employee values(6,'Sarah',75000,'Finance','F','Philadelphia');
insert into employee values(7,'Robert',80000,'IT','M','San Antonio');
insert into employee values(8,'Linda',72000,'HR','F','San Diego');
insert into employee values(9,'james',68000,'Finance','M','Dallas');
insert into employee values(10,'Patricia',59000,'IT','F','San Jose');


-- =========================================================
-- SELECT
-- =========================================================

-- Q3. Display all information of all employees.

select * from employee;


-- Q4. Display the name and salary of all employees.

select emp_name,emp_salary from employee;


-- Q5. Display all unique departments from the EMPLOYEE table.

select distinct emp_dept from employee;


-- =========================================================
-- CALCULATED FIELD / ALIAS
-- =========================================================

-- Q6. Display employee name and salary after adding 5000 to
-- each employee's salary. Name the calculated column NEW_SALARY.

select emp_name,emp_salary + 5000 as new_salary
from employee;


-- =========================================================
-- WHERE + COMPARISON OPERATOR
-- =========================================================

-- Q7. Display the name and salary of employees whose salary
-- is greater than 60000.

select emp_name,emp_salary
from employee
where emp_salary > 60000;


-- =========================================================
-- WHERE + AND
-- =========================================================

-- Q8. Display the name, department and salary of employees
-- who work in the IT department AND have salary greater than 50000.

select emp_name,emp_dept,emp_salary
from employee
where emp_dept = 'IT'
AND emp_salary > 50000;


-- =========================================================
-- BETWEEN
-- =========================================================

-- Q9. Display the name and salary of employees whose salary
-- is between 50000 and 70000.

select emp_name,emp_salary
from employee
where emp_salary between 50000 and 70000;


-- =========================================================
-- IN
-- =========================================================

-- Q10. Display the name and department of employees who work
-- in IT, HR or Sales department.

select emp_name,emp_dept
from employee
where emp_dept in ('IT','HR','Sales');


-- =========================================================
-- LIKE
-- =========================================================

-- Q11. Display all employees whose city name starts with the letter 'D'.

select *
from employee
where city like 'D%';


-- =========================================================
-- ORDER BY
-- =========================================================

-- Q12. Display all employees in descending order of salary.

select *
from employee
order by emp_salary desc;


-- Q13. Display employees first by department in ascending order
-- and then by salary in descending order.

select *
from employee
order by emp_dept asc, emp_salary desc;


-- =========================================================
-- AGGREGATE FUNCTIONS
-- =========================================================

-- Q14. Find the highest salary, lowest salary and average salary
-- of all employees.

select max(emp_salary) as highest_salary,
       min(emp_salary) as lowest_salary,
       avg(emp_salary) as average_salary
from employee;


-- =========================================================
-- GROUP BY + COUNT
-- =========================================================

-- Q15. Display each department and the total number of employees
-- working in that department.

select emp_dept,
       count(*) as total_employees
from employee
group by emp_dept;


-- =========================================================
-- GROUP BY + HAVING
-- =========================================================

-- Q16. Display each department and its average salary.
-- Show only those departments whose average salary is greater than 60000.

select emp_dept,
       avg(emp_salary) as average_salary
from employee
group by emp_dept
having avg(emp_salary) > 60000;


-- =========================================================
-- NVL + AVG
-- =========================================================

-- Q17. Find the average salary of all employees.
-- If any employee's salary is NULL, treat it as 0.

SELECT AVG(NVL(emp_salary, 0)) AS average_salary
FROM employee;


-- =========================================================
-- SUBQUERY / CORRELATED SUBQUERY
-- =========================================================

-- Q18. Display the ID, name, salary and department of employees
-- whose salary is greater than the average salary of their
-- own department.

SELECT emp_id, emp_name, emp_salary, emp_dept
FROM employee e
WHERE emp_salary > (
    SELECT AVG(emp_salary)
    FROM employee
    WHERE emp_dept = e.emp_dept
);