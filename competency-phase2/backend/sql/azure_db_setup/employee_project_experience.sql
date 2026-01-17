
SELECT * FROM projects;

-- EXEC sp_rename 'dbo.projects', 'employee_project_experience';

-- DROP TABLE IF EXISTS employee_project_experience;
-- DROP TABLE IF EXISTS projects;



--     ### 1 CHECK INITIALLY FOR DATA IN FINAL TABLE ###

SELECT * FROM employee_project_experience;
SELECT * FROM project_master;

--     ### 2 CREATE STAGING TABLE ###




-- DROP TABLE IF EXISTS dbo.staging_employment_history;
-- GO

-- CREATE TABLE dbo.staging_cpd (
--     e_id INT NOT NULL,
--     cpd_name VARCHAR(100) NOT NULL,
--     cpd_year INT NOT NULL,
--     data_origin VARCHAR(20) NOT NULL
-- );

CREATE TABLE stg_project_master (
    pm_name        NVARCHAR(150),
    pm_location    NVARCHAR(150),
    pm_client      NVARCHAR(150),
    pm_notes       NVARCHAR(MAX),
    data_origin    VARCHAR(20)
);


CREATE TABLE stg_employee_project_experience (
    e_id                   INT NOT NULL,
    pm_id                  INT NULL,
    ps_id                  INT NULL,
    epe_service            NVARCHAR(150) NOT NULL,
    epe_start              INT NOT NULL,
    epe_end                INT NULL,
    epe_contract_value     INT NULL,
    epe_stages             NVARCHAR(50) NULL,
    epe_high_risk          BIT NULL,
    epe_contract_type      NVARCHAR(150) NULL,
    epe_gia                NVARCHAR(150) NULL,
    epe_description_1      NVARCHAR(MAX) NULL,
    epe_description_2      NVARCHAR(MAX) NULL,
    epe_description_3      NVARCHAR(MAX) NULL,
    epe_notes              NVARCHAR(MAX) NULL,
    data_origin            NVARCHAR(20) NULL,
    temp_sort              INT NULL
);





SELECT * FROM stg_project_master;
SELECT * FROM stg_employee_project_experience;

--     ### 3 CHECK TABLE HAS BEEN CREATED ###

SELECT * FROM staging_cpd;

--     ### DONE ALREADY IGNORE - 4 CHECK IF DATABASE MASTER KEY EXISTS ###

-- SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##';

--     ### DONE ALREADY IGNORE - 5 IF NO MASTER KEY, CREATE ONE ###

-- CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'IwCDeBtD08!';

--     ### DONE ALREADY IGNORE - 6 IF NOT DONE SO ALREADY CREATE DATABASE SCOPED CREDENTIAL FOR AZURE BLOB STORAGE ###

-- ALTER DATABASE SCOPED CREDENTIAL AzureBlobCredential
-- WITH
--     IDENTITY = 'SHARED ACCESS SIGNATURE',
--     SECRET = 'sp=r&st=2026-01-07T20:16:13Z&se=2026-03-31T03:31:13Z&spr=https&sv=2024-11-04&sr=c&sig=bQE1ynvgLU8e6gtxIOf9ZR4FQFSfJIKRbA%2B6BjLxbcQ%3D';

--     ### DONE ALREADY IGNORE - 7 CREATE EXTERNAL DATA SOURCE FOR AZURE BLOB STORAGE ###

-- CREATE EXTERNAL DATA SOURCE MyBlobStorage
-- WITH (
--     TYPE = BLOB_STORAGE,
--     LOCATION = 'https://competencydataset.blob.core.windows.net/dataset-files',
--     CREDENTIAL = AzureBlobCredential
-- );

--     ### 8 BULK INSERT DATA FROM CSV FILE IN BLOB STORAGE TO STAGING TABLE ###

-- ALTER TABLE dbo.employment_history
-- ALTER COLUMN eh_role VARCHAR(100) NOT NULL;

-- ALTER TABLE dbo.staging_employment_history
-- ALTER COLUMN eh_role VARCHAR(100) NOT NULL;

-- TRUNCATE TABLE dbo.staging_employment_history;

-- ALTER TABLE dbo.staging_cpd
-- ALTER COLUMN cpd_name VARCHAR(255) NOT NULL;

-- ALTER TABLE dbo.cpd
-- ALTER COLUMN cpd_name VARCHAR(255) NOT NULL;



-- BULK INSERT dbo.staging_cpd
-- FROM 'cpd.csv'
-- WITH (
--     DATA_SOURCE = 'MyBlobStorage',
--     FORMAT = 'CSV',
--     FIRSTROW = 2,
--     FIELDTERMINATOR = ',',
--     ROWTERMINATOR = '\n',
--     TABLOCK
-- );

BULK INSERT stg_project_master
FROM 'project_master.csv'
WITH (
    DATA_SOURCE = 'MyBlobStorage',
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- ROWTERMINATOR = '0x0a',
-- ROWTERMINATOR = '0x0d0a'

BULK INSERT stg_employee_project_experience
FROM 'employee_project_experience.csv'
WITH (
    DATA_SOURCE = 'MyBlobStorage',
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',  -- or 0x0d0a if it’s CRLF
    FIELDQUOTE = '"',
    CODEPAGE = '65001',       -- UTF-8
    TABLOCK
);

--     ### 9 CHECK DATA HAS BEEN LOADED INTO STAGING TABLE ###

SELECT * FROM staging_cpd;

-- check for null or empty discipline names
-- SELECT *
-- FROM staging_discipline
-- WHERE
--     d_name IS NULL
--     OR LTRIM(RTRIM(d_name)) = '';

-- -- remove null or empty discipline names
-- DELETE
-- FROM staging_discipline
-- WHERE
--     d_name IS NULL
--     OR LTRIM(RTRIM(d_name)) = '';


--     ### 10 INSERT NEW RECORDS FROM STAGING TABLE TO FINAL TABLE ###




INSERT INTO dbo.cpd (
    e_id,
    cpd_name,
    cpd_year,
    data_origin
)
SELECT
    e_id,
    cpd_name,
    cpd_year,
    data_origin
FROM dbo.staging_cpd;



INSERT INTO project_master (
    pm_name,
    pm_location,
    pm_client,
    pm_notes,
    data_origin
)
SELECT
    pm_name,
    pm_location,
    pm_client,
    pm_notes,
    data_origin
FROM stg_project_master;


-- DELETE FROM employee_project_experience;
-- DBCC CHECKIDENT ('employee_project_experience', RESEED, 0);

INSERT INTO employee_project_experience (
    ps_id,
    epe_service,
    epe_start,
    epe_end,
    epe_contract_value,
    epe_stages,
    epe_high_risk,
    epe_contract_type,
    epe_gia,
    epe_description_1,
    epe_description_2,
    epe_description_3,
    epe_notes,
    data_origin,
    e_id,
    pm_id,
    temp_sort
)
SELECT
    ps_id,
    epe_service,
    CAST(epe_start AS INT),
    CAST(epe_end AS INT),
    CAST(epe_contract_value AS INT),
    epe_stages,
    CASE WHEN epe_high_risk IN ('TRUE','true','1') THEN 1 ELSE 0 END,
    epe_contract_type,
    epe_gia,
    epe_description_1,
    epe_description_2,
    epe_description_3,
    epe_notes,
    data_origin,
    e_id,
    pm_id,
    temp_sort
FROM stg_employee_project_experience
ORDER BY temp_sort;






SELECT * FROM employee_project_experience;
SELECT * FROM project_master;


--     ### 11 CHECK DATA HAS BEEN INSERTED INTO FINAL TABLE ###

SELECT * FROM cpd
ORDER BY cpd_id;


-- ### CHECK RECORD COUNTS IN STAGING AND FINAL TABLES ###  
SELECT COUNT(*) FROM dbo.stg_project_master;
SELECT COUNT(*) FROM dbo.project_master;

--     ### 12 CLEAR STAGING TABLE ###
TRUNCATE TABLE dbo.stg_project_master;
--     ### 13 CHECK STAGING TABLE IS EMPTY ###

SELECT * FROM staging_cpd;



--     ### 13 CHECK ALL TABLE TO ENSURE THEY CONTAIN DATA ###
SELECT * FROM employee_project_experience;
SELECT * FROM project_master;
SELECT * FROM cpd;
SELECT * FROM experience_classification;
SELECT * FROM classification_value;
SELECT * FROM classification_type;
SELECT * FROM primary_sector;
SELECT * FROM legal_entity;
SELECT * FROM discipline;
SELECT * FROM employee;
SELECT * FROM employment_history;
SELECT * FROM qualifications;

