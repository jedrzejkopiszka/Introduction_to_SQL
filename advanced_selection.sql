--1. Generate a login
SELECT surname, emp_id, CONCAT(UPPER(SUBSTR(surname,1,2)), TO_NUMBER(emp_id)) as login
FROM employees
ORDER BY surname


--2. Surnames with letters L or l
SELECT surname
FROM employees
WHERE INSTR(surname, 'l') >0 or INSTR(surname, 'L')>0
ORDER BY surname


--3. Surnames with L or l in first half of surname
SELECT surname
FROM employees
WHERE (INSTR(surname, 'l', 1)>0 and INSTR(surname, 'l', 1) <= LENGTH(surname)/2)
    or (INSTR(surname, 'L', 1)>0 and INSTR(surname, 'L', 1) <= LENGTH(surname)/2)
ORDER BY surname


--4. Salaries increased by 15% and rounded
SELECT surname, TRUNC(salary, 2) as originial_salary, ROUND(salary*1.15, 0) as increased_salary
FROM employees
ORDER BY surname


--5. Current day's name


--6. The name of the day which you were born


--7. Hire dates is form 1 September 1992, Tuesday
SELECT surname, TO_CHAR(hire_date, 'FMDD MONTH YYYY, DAY') as hire_date
FROM employees
ORDER BY surname


--8. Calculate work experience on 0.01.2000, sort by work experience (desc) and surname
SELECT surname, job, ( DATE '2000-01-01' - hire_date) YEAR TO MONTH AS experience_in_2000
FROM employees
WHERE job = 'PROFESSOR' or job = 'LECTURER' or job = 'ASSISTANT'
ORDER BY experience_in_2000 DESC, surname


--9. Use query from ex8 and filter rows only with experience longer than 10 years
SELECT surname, job, ( DATE '2000-01-01' - hire_date) YEAR TO MONTH AS experience_in_2000
FROM employees
WHERE (job = 'PROFESSOR' or job = 'LECTURER' or job = 'ASSISTANT') and
    experience_in_2000 >  INTERVAL '+10-0' YEAR TO MONTH
ORDER BY experience_in_2000 DESC, surname;


--10. Get rid of months from previous query
SELECT surname, job, 
    EXTRACT(YEAR FROM ( DATE '2000-01-01' - hire_date) YEAR TO MONTH)
    AS experience_in_2000
FROM employees
WHERE job = 'PROFESSOR' or job = 'LECTURER' or job = 'ASSISTANT'
ORDER BY experience_in_2000 DESC, surname
