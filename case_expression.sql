-- SQL part 3. CASE expression. Eliminating duplicates. Set operators.


--1. Assing labels based on salaries
SELECT surname, salary,
    CASE 
        WHEN salary < 1500 THEN 'low paid'
        WHEN salary < 3000 THEN 'average paid'
        ELSE 'well paid'
    END as label
FROM employees
ORDER BY surname


--2. Display identifiers of employees who are bosses of other employees
SELECT emp_id
FROM employees 
    WHERE emp_id in 
        (SELECT boss_id FROM employees)
ORDER BY emp_id


--3. For each department list jobs the department hires. Skip jobs with no department
SELECT DISTINCT dept_id, job
FROM employees
    WHERE dept_id IS NOT NULL
ORDER BY dept_id


--4. Years when employees were hired. Skip duplicates.
SELECT DISTINCT EXTRACT(YEAR FROM hire_date) as years
FROM employees
ORDER BY years


--5. Departments with no employees
SELECT dept_id FROM departments
    MINUS
SELECT dept_id FROM employees


--6. Assign labels like in ex1 but without using CASE expression
SELECT surname, salary, 'low paid' as label
FROM employees
WHERE salary < 1500
UNION
SELECT surname, salary, 'average paid' as label
FROM employees
WHERE salary>=1500 and salary<3000
UNION
SELECT surname, salary, 'well paid' as label
FROM employees
WHERE salary>3000
ORDER BY surname
