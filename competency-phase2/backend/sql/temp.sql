-- Legal Entities
INSERT INTO legal_entity (le_name) VALUES
('Legal Entity A'),
('Legal Entity B');

-- Disciplines
INSERT INTO discipline (d_name) VALUES
('Engineering'),
('Consulting');

-- Employees
INSERT INTO employee (e_norseid, le_id, d_id, e_fname, e_lname, e_job, e_start, e_email, e_contactno)
VALUES
('E001', 1, 1, 'Alice', 'Smith', 'Engineer', '2020-01-15', 'alice.smith@example.com', '07123456789'),
('E002', 1, 2, 'Bob', 'Jones', 'Consultant', '2019-03-20', 'bob.jones@example.com', '07234567890');

-- Managers
INSERT INTO manager (m_norseid, m_fname, m_lname, m_job, m_email, le_id, d_id)
VALUES
('M001', 'Carol', 'White', 'Manager', 'carol.white@example.com', 1, 1),
('M002', 'Dan', 'Brown', 'Manager', 'dan.brown@example.com', 1, NULL);

-- Business Categories
INSERT INTO business_categories (bc_name) VALUES
('Category A'),
('Category B');

-- Category Match
INSERT INTO category_match (e_id, bc_id) VALUES
(1, 1),
(2, 2);

-- Qualifications
INSERT INTO qualifications (e_id, q_type, q_name, q_institution, q_year)
VALUES
(1, 'Academic', 'BEng Mechanical', 'Uni A', 2018),
(2, 'Professional', 'Project Mgmt', 'N/A', 2020);

-- Employment History
INSERT INTO employment_history (e_id, eh_company, eh_location, eh_role, eh_start, eh_end)
VALUES
(1, 'Company X', 'London', 'Junior Engineer', 2018, 2020),
(2, 'Company Y', 'Bristol', 'Consultant', 2017, 2019);

-- Projects
INSERT INTO projects (e_id, p_client, p_name, p_service, p_start, p_end, p_sector, p_conType)
VALUES
(1, 'Client A', 'Project Alpha', 'Engineering Design', 2019, 2020, 'Infrastructure', 'Consultancy'),
(2, 'Client B', 'Project Beta', 'Consulting Services', 2018, 2019, 'Energy', 'Advisory');

-- CPD
INSERT INTO cpd (e_id, cpd_name, cpd_year)
VALUES
(1, 'Safety Training', 2020),
(2, 'Leadership Workshop', 2021);
