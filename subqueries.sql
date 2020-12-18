--SQL part 6. Basic subqueries

--1. Surnames, jobs of those who work in the same department as Johnson (don't display him)
SELECT surname, job
FROM employees
WHERE dept_id = (SELECT dept_id FROM employees WHERE surname='Johnson')
    AND surname != 'Johnson'
ORDER BY surname


--2. add deaprtments' names to the previous query
SELECT employees.surname, employees.job, departments.dept_name
FROM employees INNER JOIN departments
    ON employees.dept_id = departments.dept_id
WHERE employees.dept_id = 
    (SELECT dept_id FROM employees WHERE surname='Johnson')
    AND employees.surname != 'Johnson'
ORDER BY employees.surname


--3. Find the longest-employed lecturer
SELECT surname, job, hire_date
FROM employees
WHERE (hire_date, job) = (SELECT MIN(hire_date), 'LECTURER'
                                FROM employees WHERE job = 'LECTURER')
                                

--4. For every department find shortest-employed employee
SELECT departments.dept_name, employees.surname , employees.hire_date
FROM employees INNER JOIN departments
    ON employees.dept_id = departments.dept_id
WHERE (employees.dept_id, employees.hire_date) IN
    (SELECT dept_id, MAX(hire_date)
     FROM employees 
     WHERE dept_id IS NOT NULL
     GROUP BY dept_id)
ORDER BY departments.dept_name


--5. Find departments without employees
SELECT dept_id, dept_name, address
FROM departments
WHERE dept_id NOT IN
    (SELECT DISTINCT dept_id FROM employees WHERE dept_id IS NOT NULL)


--6. Professors with no phd students - DOES NOT WORK AS IT SHOULD
SELECT surname, job, salary
FROM employees
WHERE emp_id IN
    (SELECT boss_id
    FROM employees
    WHERE job != 'PHD STUDENT' AND boss_id IS NOT NULL)
AND job = 'PROFESSOR'


--7. Find departments which employ more employees than department "ADMINISTRATION"
SELECT departments.dept_name, COUNT(employees.emp_id) as num_of_empl
FROM departments INNER JOIN employees
    ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name
HAVING COUNT(employees.emp_id)>
    ( SELECT COUNT(employees.emp_id) 
      FROM employees INNER JOIN departments
        ON employees.dept_id = departments.dept_id
      WHERE departments.dept_name = 'ADMINISTRATION' )
    

--8. Year of hiring the higest number of professors
SELECT EXTRACT(YEAR FROM hire_date) as year, COUNT(*) as number_of_professors
FROM employees
WHERE job = 'PROFESSOR'
GROUP  BY EXTRACT(YEAR FROM hire_date)


--9. Department with highest salary (take into accout add_salary as salary) - DOES NOT WORK

SELECT departments.dept_name, SUM(employees.salary + COALESCE(employees.add_salary, 0))
FROM employees INNER JOIN departments
    ON employees.dept_id = departments.dept_id
GROUP BY departments.dept_name
