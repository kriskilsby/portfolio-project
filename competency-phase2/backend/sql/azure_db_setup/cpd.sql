--     ### 1 CHECK INITIALLY FOR DATA IN FINAL TABLE ###

SELECT * FROM cpd;

--     ### 2 CREATE STAGING TABLE ###




-- DROP TABLE IF EXISTS dbo.staging_employment_history;
-- GO

CREATE TABLE dbo.staging_cpd (
    e_id INT NOT NULL,
    cpd_name VARCHAR(100) NOT NULL,
    cpd_year INT NOT NULL,
    data_origin VARCHAR(20) NOT NULL
);




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



BULK INSERT dbo.staging_cpd
FROM 'cpd.csv'
WITH (
    DATA_SOURCE = 'MyBlobStorage',
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
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