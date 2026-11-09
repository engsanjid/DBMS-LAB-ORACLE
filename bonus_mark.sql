CREATE TABLE student(
    student_name VARCHAR2(30),
    gender CHAR(1) CHECK (gender IN ('m','f')),
    class_code VARCHAR2(10),
    test_score NUMBER
);
INSERT INTO student VALUES ('Rahim', 'm', 'CSE1', 75);
INSERT INTO student VALUES ('Karim', 'm', 'CSE1', NULL);
INSERT INTO student VALUES ('Nusrat', 'f', 'CSE1', 85);
INSERT INTO student VALUES ('Sadia', 'f', 'CSE2', 45);
INSERT INTO student VALUES ('Hasan', 'm', 'CSE2', 60);
INSERT INTO student VALUES ('Tanvir', 'm', 'CSE2', NULL);
INSERT INTO student VALUES ('Mim', 'f', 'CSE3', 90);
INSERT INTO student VALUES ('Rafi', 'm', 'CSE3', 40);
INSERT INTO student VALUES ('Jannat', 'f', 'CSE3', 70);

SELECT * FROM student;

SELECT *
FROM student
WHERE gender = 'm'
AND test_score IS NULL;

SELECT student_name, test_score
FROM student
WHERE test_score > 50;

SELECT class_code,
       MIN(test_score) AS minimum_score,
       AVG(test_score) AS average_score,
       MAX(test_score) AS maximum_score
FROM student
GROUP BY class_code;