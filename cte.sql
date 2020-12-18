-- SQL part 7. CTE. Top-N queries

--1. employees who earn more than average. Use CTE to hold average for each job
WITH
    avg_salary(job_name, job_salary) AS
        (SELECT job, ROUND(AVG(salary), 2)
        FROM employees
        GROUP BY job)
SELECT employees.surname, avg_salary.job_name,
    employees.salary, avg_salary.job_salary
FROM employees INNER JOIN avg_salary
    ON employees.job = avg_salary.job_name
WHERE employees.salary > avg_salary.job_salary
ORDER BY employees.surname


--2. Dept with maximal sum of its employees' salaries. CTE to define sum for dept.
SELECT departments.dept_name, SUM(employees.salary) as sum_of_sal
FROM departments INNER JOIN employees
    ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name
ORDER BY sum_of_sal DESC
FETCH FIRST 1 ROW ONLY


--3. Employees that earn at least 60% of their bosses salaries. CTE for bosses and salaries
WITH
    boss_salary(boss_surname, emp, pay) AS
    (SELECT surname, emp_id, salary
     FROM employees)
SELECT employees.surname, employees.salary,
    boss_salary.boss_surname, boss_salary.pay
FROM employees INNER JOIN boss_salary
    ON employees.boss_id = boss_salary.emp
WHERE employees.salary >= 0.6*boss_salary.pay
ORDER BY employees.surname


--4. Employees with longest work history. Use FETCH clause
SELECT surname, hire_date
FROM employees
ORDER BY hire_date
FETCH FIRST 1 ROW ONLY


--5. USe previous query as CTE. Calculate difference between employee's hire date and longest 
WITH
    longest(surname, hire_date) AS
    (SELECT surname, hire_date
    FROM employees
    ORDER BY hire_date
    FETCH FIRST 1 ROW ONLY)
    
SELECT employees.surname, employees.hire_date- longest.hire_date AS num_of_days
FROM employees, longest
ORDER BY num_of_days


--6. Show how may thousands "grand" each employy earns
WITH
    grands AS
    (SELECT surname, CEIL(salary/1000) as pay
    FROM employees)
SELECT surname ||' earns ' ||
    CASE
        WHEN pay = 5 THEN 'five'
        WHEN pay = 4 THEN 'four'
        WHEN pay = 3 THEN 'three'
        WHEN pay = 2 THEN 'two'
        WHEN pay = 1 THEN 'one'
    END || ' grand' as Sentence
FROM grands
ORDER BY surname


--7. Query with employees hierarchy (recursive query). Pu Smith on top. - DOES NOT WORK
WITH
    emp_hierarchy(emp_id, boss_id,  surname) AS
    (SELECT emp_id, boss_id, surname
     FROM employees
     WHERE job = 'PRINCIPAL'
        UNION ALL
     SELECT e.emp_id, e.boss_id, e.surname
     FROM employees e JOIN emp_hierarchy h
        ON e.boss_id = h.emp_id)
     SEARCH DEPTH
        FIRST BY surname SET sibl_order)
SELECT surname, emp_id, boss_id
FROM emp_hierarchy
ORDER BY sibl_order

