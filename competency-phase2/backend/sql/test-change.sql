SET search_path TO competency_data;

-- 1) Test soft-delete cascading: deactivate Alice (e_id = 1)
UPDATE employee
SET e_active = FALSE
WHERE e_id = 1;

-- Check that related records are also deactivated
SELECT e_id, q_active FROM qualifications WHERE e_id = 1;
SELECT e_id, p_active FROM projects WHERE e_id = 1;
SELECT e_id, cpd_active FROM cpd WHERE e_id = 1;
SELECT e_id, eh_active FROM employment_history WHERE e_id = 1;
SELECT e_id, cm_active FROM category_match WHERE e_id = 1;

-- 2) Reactivate Alice (e_id = 1)
UPDATE employee
SET e_active = TRUE
WHERE e_id = 1;

-- 3) Step A change employee + manually insert review log
UPDATE employee
SET e_fname = 'Alicia', e_job = 'Senior Engineer'
WHERE e_id = 1;

-- Step B — log the change manually (what your frontend will do)
INSERT INTO reviewLog (e_id, table_name, record_id, section, old_value, new_value, updated_by)
VALUES 
    (1, 'employee', 1, 'e_fname', 'Alice', 'Alicia', 'M001'),
    (1, 'employee', 1, 'e_job', 'Engineer', 'Senior Engineer', 'M001');


-- Check the reviewLog entries for Alice
SELECT * FROM reviewLog WHERE e_id = 1 ORDER BY updated_at DESC;

-- 4) Step A: NEW version: update + manual log
UPDATE qualifications
SET q_name = 'MEng Mechanical', q_year = 2019
WHERE q_id = 1;

-- Step B: log the changes manually
INSERT INTO reviewLog (e_id, table_name, record_id, section, old_value, new_value, updated_by)
VALUES
    ((SELECT e_id FROM qualifications WHERE q_id = 1),
        'qualifications', 1, 'q_name', 'BEng Mechanical', 'MEng Mechanical', 'E001'),
    ((SELECT e_id FROM qualifications WHERE q_id = 1),
        'qualifications', 1, 'q_year', '2015', '2019', 'E001');


-- Check reviewLog for qualification changes
SELECT * FROM reviewLog WHERE table_name = 'qualifications' ORDER BY updated_at DESC;

-- 5) Step A: NEW project update + log
UPDATE projects
SET p_name = 'Project Alpha Revised', p_description = 'Updated description'
WHERE p_id = 1;
-- Step B: log the changes manually
INSERT INTO reviewLog (e_id, table_name, record_id, section, old_value, new_value, updated_by)
VALUES
    ((SELECT e_id FROM projects WHERE p_id = 1),
        'projects', 1, 'p_name', 'Project Alpha', 'Project Alpha Revised', 'M001'),
    ((SELECT e_id FROM projects WHERE p_id = 1),
        'projects', 1, 'p_description', 'Initial description', 'Updated description', 'M001');


-- Review the log for this project update
SELECT * FROM reviewLog WHERE table_name = 'projects' ORDER BY updated_at DESC;
