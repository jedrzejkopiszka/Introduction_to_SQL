--SQL part8. Creating new data. Modifying and deleting exisiting data.

--1. Insert information about new employee
INSERT ALL
    INTO employees VALUES (310, 'Cook', 'Robin', 'PROFESSOR', 100,
        TO_DATE('15/09/2016', 'DD/MM/YYYY'), 3500, 1250, 40)
        
    INTO employees VALUES (320, 'Dormand', 'Francis', 'ASSISTANT', 110,
        TO_DATE('01/01/2018', 'DD/MM/YYYY'), 3900, NULL, 40)
        
SELECT 1 FROM DUAL;


--2. Define new department DATABASE SYSTEMS
INSERT INTO departments
    VALUES (70, 'DATABASE SYSTEMS', DEFAULT)


--3. Move new employees to departments DATABASE SYSTEMS
UPDATE employees
SET dept_id = 70
WHERE emp_id IN (300, 310, 320)


--4. Rise for employees of DATABASE SYSTEMS. If employee's add_salary is NULL set it to 100 - DOES NOT WORK
UPDATE employees
SET salary = salary * 1.1,

    add_salary = 
    (SELECT add_salary * 1.2
     FROM employees
     WHERE add_salary IS NOT NULL),
     
    add_salary = 
    (SELECT 100
     FROM employees
     WHERE add_salary IS NULL)


--5. Raise = salary + avg(salary in 'administration')*0.1 to people from 'DATABASE SYSTEMS'
UPDATE employees
SET salary = salary + 
    (SELECT AVG(salary)*0.1
     FROM employees INNER JOIN departments
        ON employees.dept_id = departments.dept_id
     WHERE departments.dept_name = 'ADMINISTRATION')
WHERE dept_id = 
    (SELECT DISTINCT dept_id
    FROM departments
    WHERE dept_name = 'DATABASE SYSTEMS')
    

--6. Try to delete DATABASE SYSTEMS. Why it fails to execute?
DELETE FROM departments
WHERE dept_name = 'DATABASE SYSTEMS'

--child record found -> We cannot delete department, because other databases are related to it (employees are assigned to 'Database systems' department)


--7. Delete people from DATABASE SYSTEMS who earn less than 5000.
DELETE FROM employees
WHERE salary < 2000 AND dept_id = (SELECT DISTINCT dept_id
                                   FROM departments 
                                   WHERE dept_name = 'DATABASE SYSTEMS');
    
UPDATE employees
SET dept_id = Null
WHERE dept_id = (SELECT DISTINCT dept_id
                 FROM departments
                 WHERE dept_name = 'DATABASE SYSTEMS');


--8. Once again try to delete DATABASE SYSTEMS 
DELETE FROM departments
WHERE dept_name = 'DATABASE SYSTEMS'


--9. Delete Jack Snow
DELETE FROM employees
WHERE surname = 'Bell'