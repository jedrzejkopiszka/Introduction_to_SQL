--SQL part 9. DDL - part 1. Creating tables

--1. Create Projects
CREATE TABLE projects(
    project_id integer GENERATED ALWAYS AS IDENTITY,
    project_name character varying(200),
    description character varying(1000),
    start_date date DEFAULT CURRENT_DATE,
    end_date date,
    budget numeric(10,2));

--2. Add rows to Projects


INSERT INTO projects(project_name, description, start_date, end_date, budget)
VALUES ('New Technology Survey',
        'A project aimed at reviewing the area of advanced database technologies.',
        TO_DATE('01/01/2018', 'DD/MM/YYYY'),
        NULL,
        1500000);
     
INSERT INTO projects(project_name, description, start_date, end_date, budget)
VALUES ('Advanced Data Analysis',
        'Analyzing data obtained from various organizations',
        TO_DATE('20/09/2017', 'DD/MM/YYYY'),
        TO_DATE('01/10/2018', 'DD/MM/YYYY'),
        2750000);


--3. add one more row with 55 in project_id column. Why no success?
INSERT INTO projects(project_id, project_name, description, start_date, end_date, budget)
VALUES (55, 'Creating backbone network',
        'Expanding the organization''s network infrastructure.',
        TO_DATE('01/06/2019', 'DD/MM/YYYY'),
        TO_DATE('31/05/2020', 'DD/MM/YYYY'),
        5000000);
-- We got error - can't declare project_id as it is generated automatically


--4. Insert row from example above. 
INSERT INTO projects(project_name, description, start_date, end_date, budget)
VALUES ('Creating backbone network',
        'Expanding the organization''s network infrastructure.',
        TO_DATE('01/06/2019', 'DD/MM/YYYY'),
        TO_DATE('31/05/2020', 'DD/MM/YYYY'),
        5000000);
        
SELECT project_id, project_name
FROM projects;


--5. Try changing project_id for row 3. Success?
UPDATE projects
SET project_id = 100
WHERE project_name = 'Creating backbone network'
-- No success. You cant modify generated id


--6. Create new table - copy of projects
CREATE TABLE projects_copy AS
    SELECT *
    FROM projects;
    
SELECT *
FROM projects_copy;


--7. Add row to projects_copy
INSERT INTO projects_copy(project_id, project_name, 
                          description, start_date, end_date, budget)
VALUES (100, 
        'Creating mobile network', 
        'Expanding the organization''s network infrastructure – part 2.',
        TO_DATE('01/07/2020', 'DD/MM/YYYY'),
        TO_DATE('31/05/2021', 'DD/MM/YYYY'),
        4000000);

-- Works, as this is a simple copy of Projects table and does not contain restrictions


--8. Delete row from projects_copy
DELETE FROM projects_copy
WHERE project_name = 'Creating backbone network';

SELECT *
FROM projects_copy


--9. Add new columnnumber_of_emp with type numeric(3). Increase en of string in description to 1500
ALTER TABLE projects
ADD number_of_emp numeric(3);

ALTER TABLE projects
MODIFY description varchar(1500);

SELECT *
FROM projects;


--10. Find length of the longest name. Then shorten the varchar of project_name
SELECT MAX(LENGTH(project_name))
FROM projects;

ALTER TABLE projects
MODIFY project_name varchar(25);

SELECT project_name
FROM projects;


-- 11. Rename column budget to project_budget
ALTER TABLE projects
RENAME COLUMN budget TO project_budget;


--12. Drop table projects_copy
DROP TABLE projects_copy;