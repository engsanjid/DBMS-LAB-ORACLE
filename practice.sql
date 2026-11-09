create table EMPLOYEE(
    fname varchar2(20),
    lname varchar2(20),
    salary number,
    dno number
);
insert into EMPLOYEE values('John','Smith',50000,1);
insert into EMPLOYEE values('Jane','Doe',60000,2);
insert into EMPLOYEE values('Mike','Johnson',55000,1);
insert into EMPLOYEE values('Emily','Davis',70000,3);
insert into EMPLOYEE values('David','Wilson',65000,2);
insert into EMPLOYEE values('Sarah','Miller',75000,3);
insert into EMPLOYEE values('Robert','Brown',80000,1);


-- Q1
select * from EMPLOYEE;

-- Q2
select fname ,salary from EMPLOYEE ;

-- Q3
select lname from EMPLOYEE;

-- Q4. Display all different department numbers.
select distinct dno from EMPLOYEE;

-- Q5. Display all different salaries.
select distinct salary from EMPLOYEE;

-- Q6. Display all different first names.
select distinct fname from EMPLOYEE;

-- Q7. Display fname and salary after adding 5000 to each employee's salary.
select fname ,salary + 5000 as new_salary from EMPLOYEE;

-- Q8. Display fname and yearly salary (salary * 12).
select fname ,salary * 12 as yearly_salary from EMPLOYEE;

-- Q9. Display fname and yearly salary, but give the calculated column the name annual_salary using AS.
select fname ,salary * 12 as annual_salary from EMPLOYEE;

-- Q10. Display all employees whose salary is greater than 60000.
select * from EMPLOYEE where salary > 60000;

-- Q11. Display fname and salary of employees whose salary is less than 70000.
select fname ,salary from EMPLOYEE where salary < 70000;

-- Q12. Display all employees whose salary is equal to 75000.
select * from EMPLOYEE where salary = 75000;

-- Q13. Display fname and dno of employees who belong to department 1.
select fname ,dno from EMPLOYEE where dno = 1;

-- Q14. Display fname and salary of employees who belong to department 1 AND salary is greater than 60000.
select fname ,salary from EMPLOYEE where dno = 1 and salary > 60000;

-- Q15. Display all employees who belong to department 2 OR department 3.
select * from EMPLOYEE where dno in (2,3);
select *  from EMPLOYEE where dno = 2 or dno = 3;

-- Q16. Display fname, dno, and salary of employees whose salary is greater than 60000 AND dno is 2.
select fname,dno ,salary from EMPLOYEE where salary > 60000 and dno = 2;

-- Q17. Display all employees whose salary is less than 55000 OR salary is greater than 70000.
select * from EMPLOYEE where salary < 55000 OR  salary > 70000;

-- Q18. Display all employees whose salary is between 55000 and 70000.
select * from EMPLOYEE where salary between 55000 and 70000;

-- Q19. Display fname and salary of employees whose salary is between 60000 and 75000.
select fname,salary from EMPLOYEE where salary between 60000 and 75000;

-- Q20. Display all employees whose salary is not between 55000 and 70000.
select * from EMPLOYEE where salary not between 55000 and 70000;

--Q21.Display all employees who belong to department 1 or 3.
select * from EMPLOYEE where dno in(1,3);

-- Q22.Display fname and salary of employees who belong to department 2 or 4.
select fname,salary from EMPLOYEE where dno in(2,4);


-- Q23. Display all employees who do not belong to department 1 or 3.
select * from EMPLOYEE where dno not in(1,3);


-- Q24. Display fname and dno of employees whose department number is 1, 2, or 3.
select fname ,dno from EMPLOYEE where dno in (1,2,3);


-- Q25.Display all employees whose department number is not 2, 3, or 4.
select * from EMPLOYEE where dno not in (2,3,4);


-- Q26.Display all employees whose fname starts with 'A'.
select * from EMPLOYEE where fname like 'A%';

-- Q27.Display all employees whose fname ends with 'n'.
select * from EMPLOYEE where fname like '%n';

-- Q28.Display fname and salary of employees whose name contains 'a'.

select fname,salary from EMPLOYEE where fname like '%a%';

-- Q29.Display all employees whose fname has 'a' as the second character.
select * from EMPLOYEE where fname like '_a%';


-- Q30.Display all employees whose fname starts with 'S' and ends with 'n'.
select * from EMPLOYEE where fname like 'S%' and fname like'%n';

-- Q31. Display all employees ordered by salary from lowest to highest.
select * from EMPLOYEE order by salary asc;

-- Q32. Display all employees ordered by salary from highest to lowest.
select * from EMPLOYEE order by salary desc;

-- Q33. Display fname and salary, ordered by fname alphabetically.
select fname ,salary from EMPLOYEE order by fname asc;



-- Q34. Display fname and salary, ordered by salary highest to lowest.
select fname , salary from EMPLOYEE  order by salary desc;


-- Q35. Display all employees whose salary is greater than 50000, ordered by salary lowest to highest.
select * from EMPLOYEE where salary > 50000 order by salary asc;

-- Q36. Display the total number of employees.
select count(*) from EMPLOYEE;

-- Q37. Display the total salary of all employees.
SELECT SUM(salary) as total_salary from EMPLOYEE;

-- Q38. Display the average salary of all employees.
SELECT AVG(salary) as avg_salary from EMPLOYEE;

-- Q39. Display the minimum salary of employees.
SELECT MIN(salary) as minimum_salary from EMPLOYEE;

-- Q40. Display the maximum salary of employees.
SELECT MAX(salary) as maximum_salary from EMPLOYEE;

-- Q41. Display the total number of employees and average salary using a single query.
SELECT COUNT(*) AS TOTAL_EMP,AVG(salary) as avg_salary from EMPLOYEE;

-- Q42. Display the minimum and maximum salary using a single query.
SELECT MIN(salary) as minimum_salary,max(salary) as maximum_salary from EMPLOYEE;

-- Q43. Display the total salary of employees who belong to department 1.
SELECT SUM(salary) from  EMPLOYEE where dno =1;


-- Q44.Display the number of employees in each department.
select count(*) from EMPLOYEE group by dno;


-- Q45.Display the total salary of each department.
select sum(salary) from EMPLOYEE group by dno;


-- Q46.Display the average salary of each department.
select avg(salary) from EMPLOYEE group by dno;



-- Q47.Display the minimum salary of each department.
select min(salary) from EMPLOYEE GROUP BY dno;


-- Q48.Display the maximum salary of each department.
select max(salary) from EMPLOYEE GROUP BY dno;


-- Q49.Display dno and the number of employees in each department, using an alias total_employee.
select dno,count(*) as total_employee from EMPLOYEE GROUP BY dno;


-- Q50. Display the number of employees in each department whose salary is greater than 50000.
select count(*) from EMPLOYEE where salary > 50000 group by dno;


-- Q51.Display the total salary of each department where salary is greater than 50000.
select sum(salary) from EMPLOYEE where salary > 50000 group by dno;


-- Q52.Display the average salary of each department where salary is greater than 60000.
select avg(salary) from EMPLOYEE where salary > 60000 group by dno;


-- Q53.Display the minimum salary of each department where salary is greater than 40000.
select min(salary) from EMPLOYEE where salary > 40000 group by dno;


-- Q54.Display the maximum salary of each department where salary is greater than 50000.
select max(salary) from EMPLOYEE where salary > 50000 group by dno;


-- Q55.Display dno and total employees for employees whose salary is between 50000 and 80000.
select dno ,count(*) as total_emp from EMPLOYEE where salary between 50000 and 80000 GROUP BY dno;


-- Q56.Display departments having more than 2 employees.
select dno, count(*) from EMPLOYEE group by dno having count(*)>2;


-- Q57.Display departments having total salary greater than 150000.
select dno,sum(salary) from EMPLOYEE group by dno having sum(salary)>150000;


-- Q58.Display departments having average salary greater than 60000.
select dno, count(*),avg(salary) from EMPLOYEE group by dno having avg(salary)>60000;


-- Q59.Display departments having minimum salary greater than 40000.
select dno,min(salary) from EMPLOYEE group by dno having min(salary)>40000;


-- Q60.Display departments having maximum salary greater than 70000.
select dno ,max(salary) from EMPLOYEE group by dno having max(salary)>70000;


-- Q61. Display departments where the number of employees is greater than 2 and the employees' salary is greater than 50000.
select dno, count(*) as total_employee
from EMPLOYEE
where salary > 50000
group by dno
having count(*) > 2;

-- Q62.Display fname and salary. If salary is NULL, display 0 instead.
select fname ,nvl(salary, 0) as salary from EMPLOYEE;


-- Q63.Display fname and commission. If commission is NULL, display 0.
select fname ,nvl(commisssion, 0) as commission from EMPLOYEE;


-- Q64.Display fname and total income where total income = salary + commission, treating NULL commission as 0.
select fname ,nvl(salary,0) + nvl(commission,0) as total_income from EMPLOYEE;


-- Q65.Display fname, salary, and commission, replacing NULL salary and NULL commission with 0.
select fname ,nvl(salary, 0) as salary, nvl(commission, 0) as commission from EMPLOYEE;


-- Q66. Display fname and salary + commission as total_income, where NULL commission should be treated as 0.
select fname ,nvl(salary,0) + nvl(commission,0) as total_income from EMPLOYEE;

