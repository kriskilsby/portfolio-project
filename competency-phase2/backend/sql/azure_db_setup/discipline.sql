--     ### 1 CHECK INITIALLY FOR DATA IN FINAL TABLE ###

SELECT * FROM discipline;

--     ### 2 CREATE STAGING TABLE ###

CREATE TABLE staging_discipline (
    d_name VARCHAR(100) NOT NULL,
    data_origin VARCHAR(20) NOT NULL
);

--     ### 3 CHECK TABLE HAS BEEN CREATED ###

SELECT * FROM staging_discipline;

--     ### DONE ALREADY IGNORE - 4 CHECK IF DATABASE MASTER KEY EXISTS ###

-- SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##';

--     ### DONE ALREADY IGNORE - 5 IF NO MASTER KEY, CREATE ONE ###

-- CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'IwCDeBtD08!';

--     ### DONE ALREADY IGNORE - 6 IF NOT DONE SO ALREADY CREATE DATABASE SCOPED CREDENTIAL FOR AZURE BLOB STORAGE ###

ALTER DATABASE SCOPED CREDENTIAL AzureBlobCredential
WITH
    IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = 'sp=r&st=2026-01-07T20:16:13Z&se=2026-03-31T03:31:13Z&spr=https&sv=2024-11-04&sr=c&sig=bQE1ynvgLU8e6gtxIOf9ZR4FQFSfJIKRbA%2B6BjLxbcQ%3D';

--     ### DONE ALREADY IGNORE - 7 CREATE EXTERNAL DATA SOURCE FOR AZURE BLOB STORAGE ###

-- CREATE EXTERNAL DATA SOURCE MyBlobStorage
-- WITH (
--     TYPE = BLOB_STORAGE,
--     LOCATION = 'https://competencydataset.blob.core.windows.net/dataset-files',
--     CREDENTIAL = AzureBlobCredential
-- );

--     ### 8 BULK INSERT DATA FROM CSV FILE IN BLOB STORAGE TO STAGING TABLE ###

BULK INSERT dbo.staging_discipline
FROM 'discipline.csv'             -- just the file name
WITH (
    DATA_SOURCE = 'MyBlobStorage',  -- the external data source object in your DB
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    TABLOCK
);

--     ### 9 CHECK DATA HAS BEEN LOADED INTO STAGING TABLE ###

SELECT * FROM staging_discipline;

-- check for null or empty discipline names
SELECT *
FROM staging_discipline
WHERE
    d_name IS NULL
    OR LTRIM(RTRIM(d_name)) = '';

-- remove null or empty discipline names
DELETE
FROM staging_discipline
WHERE
    d_name IS NULL
    OR LTRIM(RTRIM(d_name)) = '';


--     ### 10 INSERT NEW RECORDS FROM STAGING TABLE TO FINAL TABLE ###

INSERT INTO dbo.discipline (d_name, data_origin)
SELECT
    LTRIM(RTRIM(s.d_name)),
    s.data_origin
FROM dbo.staging_discipline s
LEFT JOIN dbo.discipline d
  ON LTRIM(RTRIM(s.d_name)) = d.d_name
WHERE
    s.d_name IS NOT NULL
    AND LTRIM(RTRIM(s.d_name)) <> ''
    AND d.d_name IS NULL;


--     ### 11 CHECK DATA HAS BEEN INSERTED INTO FINAL TABLE ###

SELECT * FROM discipline;

--     ### 12 CLEAR STAGING TABLE ###

TRUNCATE TABLE dbo.staging_discipline;

--     ### 13 CHECK STAGING TABLE IS EMPTY ###

SELECT * FROM staging_discipline;