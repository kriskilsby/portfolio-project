-----------------------------------------------------------------
-- ####################### SCHEMA SETUP ########################
-----------------------------------------------------------------

-- Create schema if not exists
CREATE SCHEMA IF NOT EXISTS competency_data;
SET search_path TO competency_data;


-----------------------------------------------------------------
-- ####################### TABLE SETUP ########################
-----------------------------------------------------------------

-- Create legal_entity table
CREATE TABLE legal_entity (
    le_id SERIAL PRIMARY KEY,
    le_name VARCHAR(50) NOT NULL UNIQUE,
    le_addDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    le_active BOOLEAN DEFAULT TRUE,
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);

-- Create discipline table
CREATE TABLE discipline (
    d_id SERIAL PRIMARY KEY,
    d_name VARCHAR(100) NOT NULL UNIQUE,
    d_addDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    d_active BOOLEAN DEFAULT TRUE,
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);

-- Create employee table
CREATE TABLE employee (
    e_id SERIAL PRIMARY KEY,

    e_norseid VARCHAR(50) UNIQUE,

    le_id INT NOT NULL REFERENCES legal_entity(le_id),
    d_id INT REFERENCES discipline(d_id),

    e_fname VARCHAR(100) NOT NULL,
    e_lname VARCHAR(100) NOT NULL,
    e_job VARCHAR(150) NOT NULL,

    e_start DATE,

    e_email VARCHAR(255) NOT NULL
        CHECK (e_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),

    e_contactno VARCHAR(50) NOT NULL
        CHECK (e_contactno ~ '^[0-9]{10,11}$'),

    e_note TEXT,

    e_addDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    e_eReview TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    e_mReview TIMESTAMP,
    e_active BOOLEAN NOT NULL DEFAULT TRUE,  -- Soft delete flag
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);

-- Create business_categories table
CREATE TABLE business_categories (
    bc_id SERIAL PRIMARY KEY,
    bc_name VARCHAR(255) NOT NULL UNIQUE,
    bc_addDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    bc_active BOOLEAN DEFAULT TRUE,
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);

-- Create category_match table
CREATE TABLE category_match (
    cm_id SERIAL PRIMARY KEY,

    e_id INT NOT NULL REFERENCES employee(e_id),
    bc_id INT NOT NULL REFERENCES business_categories(bc_id),

    cm_addDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    cm_eReview TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cm_mReview TIMESTAMP,
    cm_active BOOLEAN NOT NULL DEFAULT TRUE,  -- Soft delete flag
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp',

    CONSTRAINT unique_employee_category UNIQUE (e_id, bc_id)
);

-- Create qualifications table
CREATE TABLE qualifications (
    q_id SERIAL PRIMARY KEY,

    e_id INT NOT NULL REFERENCES employee(e_id),

    q_type VARCHAR(20) NOT NULL
        CHECK (q_type IN ('Academic','Professional','Other')),

    q_name VARCHAR(150) NOT NULL,
    q_institution VARCHAR(100) NOT NULL, -- trigger will enforce N/A for Professional
    q_year INT NOT NULL CHECK (q_year BETWEEN 1950 AND 2100),

    q_addDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    q_eReview TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    q_mReview TIMESTAMP,
    q_active BOOLEAN NOT NULL DEFAULT TRUE,
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);

-- Create employment_history table
CREATE TABLE employment_history (
    eh_id SERIAL PRIMARY KEY,

    e_id INT NOT NULL REFERENCES employee(e_id),

    eh_company VARCHAR(100) NOT NULL,
    eh_location VARCHAR(100) NOT NULL,
    eh_role VARCHAR(50) NOT NULL,

    eh_start INT NOT NULL CHECK (eh_start BETWEEN 1950 AND 2100),
    eh_end INT CHECK (eh_end BETWEEN 1950 AND 2100),

    eh_addDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    eh_eReview TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    eh_mReview TIMESTAMP,

    eh_active BOOLEAN NOT NULL DEFAULT TRUE,-- Soft delete flag
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp',

    CONSTRAINT chk_employment_history_dates
        CHECK (eh_end IS NULL OR eh_end >= eh_start)
);

-- Create projects table
-- Rename table to employee_project_experience to make it clear they are not distinct projects
CREATE TABLE projects (
    p_id SERIAL PRIMARY KEY,

    e_id INT NOT NULL REFERENCES employee(e_id),

    p_client VARCHAR(100) NOT NULL,
    p_name VARCHAR(100) NOT NULL,
    p_service VARCHAR(150) NOT NULL,

    p_start INT NOT NULL CHECK (p_start BETWEEN 1950 AND 2100),
    p_end   INT NOT NULL CHECK (p_end   BETWEEN 1950 AND 2100),

    p_sector VARCHAR(100) NOT NULL,

    p_conValue INT,
    p_stages VARCHAR(50),
    p_hRisk BOOLEAN NOT NULL DEFAULT FALSE,
    p_conType VARCHAR(150) NOT NULL,

    p_GIA VARCHAR(50) NOT NULL DEFAULT 'TBC',
    p_description_1 TEXT NOT NULL DEFAULT 'TBC',
    p_description_2 TEXT NOT NULL DEFAULT 'TBC',
    p_description_3 TEXT NOT NULL DEFAULT 'TBC',
    p_note TEXT,

    p_addDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    p_eReview TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    p_mReview TIMESTAMP,
    p_active BOOLEAN NOT NULL DEFAULT TRUE, -- Soft delete flag
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);

-- Create cpd table
CREATE TABLE cpd (
    cpd_id SERIAL PRIMARY KEY,

    e_id INT NOT NULL REFERENCES employee(e_id),

    cpd_name VARCHAR(100) NOT NULL,
    cpd_year INT NOT NULL CHECK (cpd_year BETWEEN 1950 AND 2100),

    cpd_addDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    cpd_eReview TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cpd_mReview TIMESTAMP,
    cpd_active BOOLEAN NOT NULL DEFAULT TRUE, -- Soft delete flag
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);

-- Create manager table
CREATE TABLE manager (
    m_id SERIAL PRIMARY KEY,

    m_norseid VARCHAR(50) UNIQUE,

    m_fname VARCHAR(100) NOT NULL,
    m_lname VARCHAR(100) NOT NULL,
    m_job VARCHAR(150) NOT NULL,
    m_email VARCHAR(255) NOT NULL
        CHECK (m_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),

    le_id INT REFERENCES legal_entity(le_id),
    d_id INT REFERENCES discipline(d_id),
    m_active BOOLEAN NOT NULL DEFAULT TRUE, -- Soft delete flag
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);

-- Create reviewLog table
CREATE TABLE reviewLog (
    rl_id SERIAL PRIMARY KEY,

    e_id INT NOT NULL REFERENCES employee(e_id),   -- employee who owns the record
    table_name VARCHAR(50) NOT NULL,              -- table updated: 'employee', 'qualifications', 'cpd', etc.
    record_id INT NOT NULL,                        -- primary key of the updated record
    section VARCHAR(50) NOT NULL,                 -- column/field updated

    old_value TEXT,
    new_value TEXT;

    updated_by VARCHAR(50) NOT NULL,             -- who made the update (employee.norseid or manager.norseid)
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- when update happened

    review_by VARCHAR(50),                        -- manager id/name who reviewed
    review_at TIMESTAMP,                          -- when manager reviewed

    review_status VARCHAR(20) NOT NULL DEFAULT 'Pending',  -- 'Pending', 'Reviewed'

    comment TEXT,                                  -- optional notes/comments
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);

---------------------------------------------------------------------------
-- ############## INDEX PERFORMANCE OPTIMISATION ##############
---------------------------------------------------------------------------

--- Indexes for performance optimisation
-- Foreign keys
CREATE INDEX idx_employee_le_id ON employee(le_id);
CREATE INDEX idx_employee_d_id ON employee(d_id);
CREATE INDEX idx_qualifications_e_id ON qualifications(e_id);
CREATE INDEX idx_employment_history_e_id ON employment_history(e_id);
CREATE INDEX idx_projects_e_id ON projects(e_id);
CREATE INDEX idx_cpd_e_id ON cpd(e_id);
CREATE INDEX idx_category_match_e_id ON category_match(e_id);
CREATE INDEX idx_category_match_bc_id ON category_match(bc_id);

-- reviewLog lookups
CREATE INDEX idx_reviewlog_e_id ON reviewLog(e_id);
CREATE INDEX idx_reviewlog_record_id ON reviewLog(record_id);
CREATE INDEX idx_reviewlog_table_name ON reviewLog(table_name);
CREATE INDEX idx_reviewlog_updated_by ON reviewLog(updated_by);
CREATE INDEX idx_reviewlog_review_status ON reviewLog(review_status);

-- composite index for common queries
CREATE INDEX idx_reviewlog_table_record_status 
ON reviewLog(table_name, record_id, review_status);


-- Indexes for soft delete (_active) columns
CREATE INDEX idx_employee_active ON employee(e_active);
CREATE INDEX idx_legal_entity_active ON legal_entity(le_active);
CREATE INDEX idx_discipline_active ON discipline(d_active);
CREATE INDEX idx_business_categories_active ON business_categories(bc_active);
CREATE INDEX idx_category_match_active ON category_match(cm_active);
CREATE INDEX idx_qualifications_active ON qualifications(q_active);
CREATE INDEX idx_employment_history_active ON employment_history(eh_active);
CREATE INDEX idx_projects_active ON projects(p_active);
CREATE INDEX idx_cpd_active ON cpd(cpd_active);


---------------------------------------------------------------------------
-- ########## EMPLOYEE ACTIVE TOGGLE FUNCTION & TRIGGER CASCADE ###########
---------------------------------------------------------------------------

-- Trigger function for cascading soft-delete/reactivation
CREATE OR REPLACE FUNCTION cascade_employee_active()
RETURNS TRIGGER AS $$
BEGIN
    -- Only run when e_active actually changes
    IF NEW.e_active = OLD.e_active THEN
        RETURN NEW;
    END IF;

    -- Cascade deactivate
    IF NEW.e_active = FALSE THEN
        UPDATE qualifications      SET q_active = FALSE WHERE e_id = NEW.e_id;
        UPDATE projects            SET p_active = FALSE WHERE e_id = NEW.e_id;
        UPDATE cpd                 SET cpd_active = FALSE WHERE e_id = NEW.e_id;
        UPDATE employment_history  SET eh_active = FALSE WHERE e_id = NEW.e_id;
        UPDATE category_match      SET cm_active = FALSE WHERE e_id = NEW.e_id;

    -- Cascade reactivate
    ELSE
        UPDATE qualifications      SET q_active = TRUE WHERE e_id = NEW.e_id;
        UPDATE projects            SET p_active = TRUE WHERE e_id = NEW.e_id;
        UPDATE cpd                 SET cpd_active = TRUE WHERE e_id = NEW.e_id;
        UPDATE employment_history  SET eh_active = TRUE WHERE e_id = NEW.e_id;
        UPDATE category_match      SET cm_active = TRUE WHERE e_id = NEW.e_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--- Trigger to handle soft delete cascading on employee table
CREATE TRIGGER trg_employee_active_cascade
AFTER UPDATE OF e_active ON employee
FOR EACH ROW
EXECUTE FUNCTION cascade_employee_active();


---------------------------------------------------------------------------
-- ############## OTHER TRIGGERS ##############
---------------------------------------------------------------------------

-- 1) FUNCTION
CREATE OR REPLACE FUNCTION enforce_professional_institution()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.q_type = 'Professional' THEN
        NEW.q_institution := 'N/A';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2) TRIGGER
CREATE TRIGGER trg_qualifications_institution
BEFORE INSERT OR UPDATE ON qualifications
FOR EACH ROW
EXECUTE FUNCTION enforce_professional_institution();


---------------------------------------------------------------------------
-- ############## PROPOSED ADDITIONAL TABLE DESIGN ##############
---------------------------------------------------------------------------

-- One off run to rename projects table
ALTER TABLE projects
RENAME TO employee_project_experience;

-- Maybe change the projects attribute names to something like this:
epe_id SERIAL PRIMARY KEY

-- OR alternatively, drop and recreate the table:
DROP TABLE IF EXISTS employee_project_experience CASCADE;

-- New proposed employee_project_experience table to replace projects table

CREATE TABLE employee_project_experience (
    epe_id SERIAL PRIMARY KEY,

    e_id INT NOT NULL REFERENCES employee(e_id),

    -- Optional link to canonical project (future-proofing)
    pm_id INT REFERENCES project_master(pm_id),

    epe_client VARCHAR(100) NOT NULL,
    epe_project_name VARCHAR(150) NOT NULL,
    epe_service VARCHAR(150) NOT NULL,

    epe_start INT NOT NULL CHECK (epe_start BETWEEN 1950 AND 2100),
    epe_end   INT CHECK (epe_end BETWEEN 1950 AND 2100),

    epe_contract_value INT,
    epe_stages VARCHAR(50),
    epe_high_risk BOOLEAN NOT NULL DEFAULT FALSE,
    epe_contract_type VARCHAR(150) NOT NULL,

    epe_gia VARCHAR(50) NOT NULL DEFAULT 'TBC',
    epe_description_1 TEXT NOT NULL DEFAULT 'TBC',
    epe_description_2 TEXT NOT NULL DEFAULT 'TBC',
    epe_description_3 TEXT NOT NULL DEFAULT 'TBC',
    epe_notes TEXT,

    epe_added_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    epe_employee_reviewed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    epe_manager_reviewed_at TIMESTAMP,

    epe_active BOOLEAN NOT NULL DEFAULT TRUE, -- soft delete / historical flag
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp',

    -- Logical consistency
    CONSTRAINT epe_end_after_start_check
        CHECK (epe_end IS NULL OR epe_end >= epe_start)
);

-- defines what kinds of classifications exist
CREATE TABLE classification_type (
    ct_id SERIAL PRIMARY KEY,
    ct_code VARCHAR(30) UNIQUE NOT NULL,
    ct_description TEXT
);

-- defines allowed values for each type of classification
CREATE TABLE classification_value (
    cv_id SERIAL PRIMARY KEY,
    ct_id INT NOT NULL REFERENCES classification_type(ct_id),
    cv_value VARCHAR(50) NOT NULL,
    UNIQUE (ct_id, cv_value)
);

-- Link projects to classifications
CREATE TABLE project_classification (
    pc_id SERIAL PRIMARY KEY,
    epe_id INT NOT NULL REFERENCES employee_project_experience(epe_id),
    cv_id INT NOT NULL REFERENCES classification_value(cv_id),
    UNIQUE (epe_id, cv_id)
);

-- Canonical project_master table representing known, confirmed projects
CREATE TABLE project_master (
    pm_id SERIAL PRIMARY KEY,
    pm_name VARCHAR(150) NOT NULL,
    pm_location VARCHAR(150),
    pm_client VARCHAR(150),
    pm_notes TEXT,
    pm_active BOOLEAN NOT NULL DEFAULT TRUE
);


-- Link employee experience → canonical project
ALTER TABLE employee_project_experience
ADD COLUMN pm_id INT REFERENCES project_master(pm_id);



---------------------------------------------------------------------------
-- ############## REMOVED AUTOMATIC LOGGING TRIGGERS ##############
---------------------------------------------------------------------------

-- -- Auto-detect logging function for all tables, to insert into reviewLog
-- CREATE OR REPLACE FUNCTION reviewlog_capture()
-- RETURNS TRIGGER AS $$
-- DECLARE
--     primary_key TEXT;     -- primary key column name (argument #1)
--     pk_value INT;         -- value of NEW.<primary_key>
--     col TEXT;             -- column name being checked
--     old_val TEXT;
--     new_val TEXT;
-- BEGIN
--     -- 1) Read primary key column name from first trigger argument
--     primary_key := TG_ARGV[0];

--     -- 2) Get the value of NEW.<primary_key>
--     EXECUTE format('SELECT ($1).%I', primary_key)
--     INTO pk_value
--     USING NEW;

--     -- 3) Loop through all columns listed in TG_ARGV (arguments after the primary key)
--     FOREACH col IN ARRAY TG_ARGV[1:]
--     LOOP
--         -- Get OLD and NEW values for this column
--         EXECUTE format('SELECT ($1).%I', col)
--         INTO old_val
--         USING OLD;

--         EXECUTE format('SELECT ($1).%I', col)
--         INTO new_val
--         USING NEW;

--         -- 4) Only insert a log entry if value changed
--         IF old_val IS DISTINCT FROM new_val THEN
--             INSERT INTO reviewLog (
--                 e_id,
--                 table_name,
--                 record_id,
--                 section,
--                 updated_by
--             )
--             VALUES (
--                 NEW.e_id,        -- owner of the record
--                 TG_TABLE_NAME,   -- e.g. 'employee', 'qualifications'
--                 pk_value,        -- primary key value
--                 col,             -- the column that changed
--                 NEW.updated_by   -- provided by your app
--             );
--         END IF;

--     END LOOP;

--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- --- Trigger to log updates on the employee table
-- CREATE TRIGGER trg_employee_log
-- AFTER UPDATE ON employee
-- FOR EACH ROW
-- EXECUTE FUNCTION reviewlog_capture('e_id', 
--     'e_norseid', 
--     'le_id', 
--     'd_id', 
--     'e_fname', 
--     'e_lname', 
--     'e_job', 
--     'e_start', 
--     'e_email', 
--     'e_contactno', 
--     'e_note',
--     'e_active'
-- );

-- --- Trigger to log updates on the business_categories table
-- CREATE TRIGGER trg_business_categories_update
-- AFTER UPDATE ON business_categories
-- FOR EACH ROW
-- EXECUTE FUNCTION reviewlog_capture('bc_id',
--     'bc_name',
--     'bc_active'
-- );

-- --- Trigger to log updates on the category_match table
-- CREATE TRIGGER trg_category_match_update
-- AFTER UPDATE ON category_match
-- FOR EACH ROW
-- EXECUTE FUNCTION reviewlog_capture('cm_id',
--     'e_id',
--     'bc_id',
--     'cm_eReview',
--     'cm_mReview',
--     'cm_active'
-- );

-- --- Trigger to log updates on the qualifications table
-- CREATE TRIGGER trg_qualification_update
-- AFTER UPDATE ON qualifications
-- FOR EACH ROW
-- EXECUTE FUNCTION reviewlog_capture('q_id',
--     'q_type',
--     'q_name',
--     'q_institution',
--     'q_year',
--     'q_active'
-- );

-- --- Trigger to log updates on the employment_history table
-- CREATE TRIGGER trg_employment_history_update
-- AFTER UPDATE ON employment_history
-- FOR EACH ROW
-- EXECUTE FUNCTION reviewlog_capture('eh_id',
--     'eh_company',
--     'eh_location',
--     'eh_role',
--     'eh_start',
--     'eh_end',
--     'eh_active'
-- );

-- --- Trigger to log updates on the projects table
-- CREATE TRIGGER trg_projects_update
-- AFTER UPDATE ON projects
-- FOR EACH ROW
-- EXECUTE FUNCTION reviewlog_capture('p_id',
--     'p_client',
--     'p_name',
--     'p_service',
--     'p_start',
--     'p_end',
--     'p_sector',
--     'p_conValue',
--     'p_stages',
--     'p_hRisk',
--     'p_conType',
--     'p_GIA',
--     'p_description',
--     'p_note',
--     'p_active'
-- );

-- --- Trigger to log updates on the cpd table
-- CREATE TRIGGER trg_cpd_update
-- AFTER UPDATE ON cpd
-- FOR EACH ROW
-- EXECUTE FUNCTION reviewlog_capture('cpd_id',
--     'cpd_name',
--     'cpd_year',
--     'cpd_active'
-- );

-- --- Trigger to log updates on the manager table
-- CREATE TRIGGER trg_manager_update
-- AFTER UPDATE ON manager
-- FOR EACH ROW
-- EXECUTE FUNCTION reviewlog_capture('m_id',
--     'm_norseid',
--     'm_fname',
--     'm_lname',
--     'm_email',
--     'le_id',
--     'd_id',
--     'm_active'
-- );

-- ---------------------------------------------------------------------------
-- End of removed automatic logging triggers
