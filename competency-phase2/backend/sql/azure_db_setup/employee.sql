--     ### 1 CHECK INITIALLY FOR DATA IN FINAL TABLE ###

SELECT * FROM employee;

--     ### 2 CREATE STAGING TABLE ###

CREATE TABLE staging_employee (
    e_norseid     VARCHAR(50),
    le_id         INT NOT NULL,
    d_id          INT NULL,
    e_fname       VARCHAR(100) NOT NULL,
    e_lname       VARCHAR(100) NOT NULL,
    e_job         VARCHAR(150) NOT NULL,
    e_start       DATE NULL,
    e_email       VARCHAR(255) NOT NULL,
    e_contactno   VARCHAR(50) NOT NULL,
    e_note        NVARCHAR(MAX),
    data_origin   VARCHAR(20)
);

--     ### 3 CHECK TABLE HAS BEEN CREATED ###

SELECT * FROM staging_employee;

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

BULK INSERT dbo.staging_employee
FROM 'employee.csv'             -- just the file name
WITH (
    DATA_SOURCE = 'MyBlobStorage',  -- the external data source object in your DB
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

--     ### 9 CHECK DATA HAS BEEN LOADED INTO STAGING TABLE ###

SELECT * FROM staging_employee;

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

INSERT INTO dbo.employee (
    e_norseid,
    le_id,
    d_id,
    e_fname,
    e_lname,
    e_job,
    e_start,
    e_email,
    e_contactno,
    e_note,
    data_origin
)
SELECT
    s.e_norseid,
    s.le_id,
    s.d_id,
    s.e_fname,
    s.e_lname,
    s.e_job,
    s.e_start,
    s.e_email,
    s.e_contactno,
    s.e_note,
    s.data_origin
FROM dbo.staging_employee s
LEFT JOIN dbo.employee e
    ON s.e_norseid = e.e_norseid
WHERE
    e.e_norseid IS NULL
    AND s.e_fname IS NOT NULL
    AND s.e_lname IS NOT NULL;



--     ### 11 CHECK DATA HAS BEEN INSERTED INTO FINAL TABLE ###

SELECT * FROM employee
ORDER BY e_id;


-- ### CHECK RECORD COUNTS IN STAGING AND FINAL TABLES ###  
SELECT COUNT(*) FROM dbo.staging_employee;
SELECT COUNT(*) FROM dbo.employee;

--     ### 12 CLEAR STAGING TABLE ###
TRUNCATE TABLE dbo.staging_employee;


--     ### 13 CHECK STAGING TABLE IS EMPTY ###

SELECT * FROM staging_employee;