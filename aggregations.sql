--SQL part 4. Aggregations

--1. Min and max salary. Difference Max-Min
SELECT MIN(salary) as minimum_salary, MAX(salary) as maximum_salary, 
    MAX(salary)- Min(salary) as difference
FROM employees


--2. Number of employees with no department
SELECT COUNT(*) as employees_without_dept
FROM employees
WHERE dept_id is NULL


--3. Count professors
SELECT COUNT(emp_id) as professors
FROM employees
WHERE job ='PROFESSOR'


--4. Average salary for each job
SELECT job, ROUND(AVG(salary), 2) as job_average_salary
FROM employees
GROUP BY job
ORDER BY job_average_salary DESC


--5. Use query from ex4 but include additional_salary, count employees for each job
SELECT job, ROUND(AVG(salary + COALESCE(add_salary, 0)), 2) as job_average_salary,
    COUNT(*) as employees
FROM employees
GROUP BY job
ORDER BY job_average_salary DESC


--6. Use query from above, skip jobs with only one employee
SELECT job, ROUND(AVG(salary + COALESCE(add_salary, 0)), 2) as job_average_salary, 
    COUNT(*) as employees
FROM employees
GROUP BY job
HAVING COUNT(*) > 1
ORDER BY job_average_salary DESC


--7. For each department cout employees that earn additional salary. Skip employees with no dept_id
SELECT dept_id, COUNT(*) as employees_with_add_salary
FROM employees
WHERE add_salary IS NOT NULL and dept_id IS NOT NULL
GROUP BY dept_id
ORDER BY dept_id


--8. Use query from above, computer average add_salary in department and sum of add_salary
SELECT dept_id, COUNT(*) as employees_with_add_salary,
    AVG(add_salary) as avg_add_salary, SUM(add_salary) as sum_of_add_salaries
FROM employees
WHERE dept_id IS NOT NULL and add_salary IS NOT NULL
GROUP BY dept_id
ORDER BY dept_id


--9. For each boss count their empployees
SELECT boss_id, COUNT(*) as number_of_subordinates
FROM employees
WHERE boss_id IS NOT NULL
GROUP BY boss_id
ORDER BY boss_id


--10. Count employees employed in following years
SELECT EXTRACT(YEAR FROM hire_date) as year_of_employment, 
    COUNT(*) as number_of_employees
FROM employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY year_of_employment ASC


--11. Count surnames according their length
SELECT LENGTH(surname) as surname_length, COUNT(*) as number_of_surnames
FROM employees
GROUP BY LENGTH(surname)
ORDER BY surname_length ASC


--12. Count number of occurances of letter 'a' in surname. Then count letter "A", "c", "E"
SELECT COUNT(*) as surnames_with_a
FROM employees
WHERE INSTR(surname, 'a')>0

SELECT COUNT(*) as surnames_with_a
FROM employees
WHERE INSTR(surname, 'e')>0


--13. Do the same thing using one query
SELECT DISTINCT (SELECT COUNT(*)
        FROM employees
        WHERE INSTR(surname, 'a')>0) as surnames_with_a,
        
        (SELECT COUNT(*) as surnames_with_a
        FROM employees
        WHERE INSTR(surname, 'e')>0) as surnames_with_e
FROM employees