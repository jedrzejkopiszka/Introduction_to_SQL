--SQL part 5. Using multiple tables. Basic joints.

--1. If employee works in a department, display department name and address
SELECT employees.name as name, employees.surname as surname 
    departments.dept_name as dept_name, departments.address as address
FROM employees INNER JOIN departments
    ON employees.dept_id = departments.dept_id
WHERE employees.dept_id IS NOT NULL
ORDER BY employees.surname


--2. Transoform previous query to produce the following sentences.
SELECT 'Employee ' || employees.name || ' ' || employees.surname || 
    ' works in ' || departments.dept_name || ' located at ' 
    || departments.address as sentence
FROM employees INNER JOIN departments ON
    employees.dept_id = departments.dept_id
WHERE employees.dept_id IS NOT NULL
ORDER BY employees.surname


--3. Find surnames and salaries of employees working at department located at 47TH STR.
SELECT employees.surname as surname, employees.salary as sentence
FROM employees INNER JOIN departments
    ON employees.dept_id = departments.dept_id
WHERE departments.address = '47TH STR'
ORDER BY employees.surname 


--4. Modify query above, count employees working at 47TH STR. Find average salary
SELECT COUNT(*) as employees_at_47th_str, ROUND(AVG(employees.salary), 2) as avg_salary
FROM employees INNER JOIN departments
    ON departments.dept_id = employees.dept_id
WHERE departments.address = '47TH STR'


--5. surname, job, salary, minimum salary for this type of job, job_max_salary
SELECT employees.surname as surname, employees.job as job,
    employees.salary as salary, 
    jobs.min_salary as job_min_salary, jobs.max_salary as job_max_salary
FROM employees INNER JOIN jobs
    ON employees.job = jobs.name
ORDER BY employees.surname


--6. Check if employees' salaries are not in the min-max range defined in JOBS
SELECT employees.surname as surname, employees.job as job,
    employees.salary as salary, jobs.min_salary as job_min_salary,
    jobs.max_salary as job_max_salary
FROM employees INNER JOIN jobs
    ON employees.job = jobs.name
WHERE eployees.salary < jobs.min_salary OR employees.salary > jobs.max_salary
ORDER BY employees.surname


--7. Find employees with salary range for assistants - NOT DONE!!!!!!!!!!!!!!
SELECT employees.surname as surname, employees.job as job,
    employees.salary as salary, jobs.min_salary as job_min_salary,
    jobs.max_salary as job_max_salary 
FROM employees INNER JOIN jobs
    ON employees.job 
    BETWEEN jobs.min_salary 
    AND jobs.max_salary
WHERE jobs.name = 'ASSISTANT'


--8. For every department find number of employees and sum of salaries
SELECT departments.dept_name as department,
    COUNT(employees.emp_id) as employees_at_dept,
    SUM(employees.salary) as salaries_at_dept
FROM employees INNER JOIN departments
    ON employees.dept_id = departments.dept_id
GROUP BY departments.dept_name
ORDER BY departments.dept_name 


--9. Query from above with min 2 people working at dept - DOES NOT WORK
SELECT departments.dept_name as department,
    COUNT(*) as employes_at_dept,
    SUM(employees.salary) as salaries_at_dept
FROM employees INNER JOIN departments
    ON employees.dept_id = departments.dept_id
WHERE COUNT(*) >= 2
GROUP BY departments.dept_name
ORDER BY departments.dept_name 


--10. Label depts - 2 people = "small", 3-6 =" medium", >7 = big - NOT DONE
SELECT departments.dept_name as department,
    CASE
        WHEN COUNT(employees.emp_id) <=2 THEN 'small'
        WHEN COUNT(employees.emp_id) <=6 AND COUNT(employees.emp_id) >=3  THEN 'medium'
        WHEN COUNT(employees.emp_id) >=7 THEN 'big'
    END as label
FROM employees INNER JOIN departments
    ON employees.dept_id = departments.dept_id
GROUP BY departments.dept_name
ORDER BY departments.dept_name
