
SELECT * FROM primary_sector;
SELECT * FROM classification_type;
SELECT * FROM classification_value;
SELECT * FROM experience_classification;

-- EXEC sp_rename 'dbo.projects', 'employee_project_experience';

-- DROP TABLE IF EXISTS employee_project_experience;
-- DROP TABLE IF EXISTS projects;

-- ### 0  EXTRA ADD MISSING COLUMN TO EACH

ALTER TABLE primary_sector
ADD data_origin VARCHAR(20) NOT NULL
    CONSTRAINT DF_primary_sector_data_origin DEFAULT 'temp';

ALTER TABLE classification_type
ADD data_origin VARCHAR(20) NOT NULL
    CONSTRAINT DF_classification_type_data_origin DEFAULT 'temp';

ALTER TABLE classification_value
ADD data_origin VARCHAR(20) NOT NULL
    CONSTRAINT DF_classification_value_data_origin DEFAULT 'temp';

ALTER TABLE experience_classification
ADD data_origin VARCHAR(20) NOT NULL
    CONSTRAINT DF_experience_classification_data_origin DEFAULT 'temp';


DROP TABLE IF EXISTS experience_classification;



--     ### 1 CHECK INITIALLY FOR DATA IN FINAL TABLE ###

SELECT * FROM primary_sector;
SELECT * FROM classification_type;
SELECT * FROM classification_value;
SELECT * FROM experience_classification;

--     ### 2 CREATE STAGING TABLE ###

DROP TABLE IF EXISTS dbo.classification_type_staging;
-- GO

CREATE TABLE primary_sector_staging (
    ps_name VARCHAR(150) NULL,
    data_origin VARCHAR(20) NULL
);

CREATE TABLE classification_type_staging (
    staging_id INT IDENTITY(1,1),
    ct_name VARCHAR(100),
    data_origin VARCHAR(20)
);

CREATE TABLE classification_value_staging (
    staging_id INT IDENTITY(1,1),
    ct_id INT NOT NULL,            -- FK to classification_type
    type_name VARCHAR(150) NOT NULL,
    data_origin VARCHAR(20) NOT NULL DEFAULT 'temp'
);


CREATE TABLE experience_classification_staging (
    epe_id INT NOT NULL,                     -- link to employee_project_experience
    cv_id INT NOT NULL,                      -- link to classification_value
    data_origin VARCHAR(20) DEFAULT 'temp'   -- same as entity
);


SELECT * FROM primary_sector_staging;
SELECT * FROM classification_type_staging;
SELECT * FROM classification_value_staging;
SELECT * FROM experience_classification_staging;

--     ### 3 CHECK TABLE HAS BEEN CREATED ###


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


BULK INSERT dbo.primary_sector_staging
FROM 'primary_sector.csv'
WITH (
    DATA_SOURCE = 'MyBlobStorage',
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

BULK INSERT dbo.classification_type_staging
FROM 'classification_type.csv'
WITH (
    DATA_SOURCE = 'MyBlobStorage',
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIELDQUOTE = '"',
    CODEPAGE = '65001'
);





BULK INSERT dbo.classification_value_staging
FROM 'classification_value.csv'
WITH (
    DATA_SOURCE = 'MyBlobStorage',
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

BULK INSERT dbo.experience_classification_staging
FROM 'experience_classification.csv'
WITH (
    DATA_SOURCE = 'MyBlobStorage',
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);


--     ### 9 CHECK DATA HAS BEEN LOADED INTO STAGING TABLE ###


SELECT COUNT(*) FROM primary_sector_staging;
SELECT COUNT(*) FROM classification_type_staging;
SELECT COUNT(*) FROM classification_value_staging;
SELECT COUNT(*) FROM experience_classification_staging;

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
-- TRUNCATE TABLE primary_sector;


INSERT INTO primary_sector (ps_name, data_origin)
SELECT DISTINCT
    LTRIM(RTRIM(ps_name)),
    data_origin
FROM primary_sector_staging
WHERE ps_name IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM primary_sector p
      WHERE p.ps_name = LTRIM(RTRIM(primary_sector_staging.ps_name))
  );


SELECT * FROM primary_sector_staging;
SELECT * FROM primary_sector;


TRUNCATE TABLE classification_type_staging;

DELETE FROM classification_type;
DBCC CHECKIDENT ('classification_type', RESEED, 0);

-- INSERT INTO classification_type (ct_name, data_origin)
-- SELECT DISTINCT
--     LTRIM(RTRIM(ct_name)) AS ct_name,
--     COALESCE(data_origin, 'temp') AS data_origin
-- FROM classification_type_staging
-- WHERE ct_name IS NOT NULL
-- ORDER BY (SELECT NULL);  -- preserves CSV order in absence of an ID column

INSERT INTO classification_type (ct_name, data_origin)
SELECT ct_name, data_origin
FROM classification_type_staging
ORDER BY staging_id;



SELECT * FROM classification_type_staging;
SELECT * FROM classification_type;

INSERT INTO classification_value (ct_id, type_name, data_origin)
SELECT ct_id, type_name, data_origin
FROM classification_value_staging;

SELECT * FROM classification_value_staging;
SELECT * FROM classification_value;

DELETE FROM classification_value;
DBCC CHECKIDENT ('classification_value', RESEED, 0);

INSERT INTO experience_classification (epe_id, cv_id, data_origin)
SELECT epe_id, cv_id, data_origin
FROM experience_classification_staging;

SELECT * FROM experience_classification_staging;

SELECT * FROM experience_classification;

--     ### 11 CHECK DATA HAS BEEN INSERTED INTO FINAL TABLE ###

SELECT * FROM cpd
ORDER BY cpd_id;


-- ### CHECK RECORD COUNTS IN STAGING AND FINAL TABLES ###  
SELECT COUNT(*) FROM dbo.staging_cpd;
SELECT COUNT(*) FROM dbo.cpd;

--     ### 12 CLEAR STAGING TABLE ###
TRUNCATE TABLE dbo.staging_cpd;
--     ### 13 CHECK STAGING TABLE IS EMPTY ###

SELECT * FROM staging_cpd;