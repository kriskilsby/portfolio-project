--     ### 1 CHECK INITIALLY FOR DATA IN FINAL TABLE ###

SELECT * FROM qualifications;

--     ### 2 CREATE STAGING TABLE ###


-- DROP TABLE dbo.staging_qualifications;

CREATE TABLE dbo.staging_qualifications (
    e_id INT NOT NULL,            -- Employee ID from CSV
    q_type VARCHAR(20) NOT NULL,  -- 'Academic','Professional','Other'
    q_name VARCHAR(150) NOT NULL,
    q_institution VARCHAR(100) NOT NULL, -- Put 'N/A' for Professional in CSV
    q_year INT NOT NULL,
    data_origin VARCHAR(20) NOT NULL     -- e.g., 'demo'
);



--     ### 3 CHECK TABLE HAS BEEN CREATED ###

SELECT * FROM staging_qualifications;

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

BULK INSERT dbo.staging_qualifications
FROM 'qualifications.csv'             -- just the file name qualifications
WITH (
    DATA_SOURCE = 'MyBlobStorage',  -- the external data source object in your DB
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

--     ### 9 CHECK DATA HAS BEEN LOADED INTO STAGING TABLE ###

SELECT * FROM staging_qualifications;

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




INSERT INTO dbo.qualifications 
    (e_id, q_type, q_name, q_institution, q_year, data_origin)
SELECT 
    s.e_id, s.q_type, s.q_name, s.q_institution, s.q_year, s.data_origin
FROM dbo.staging_qualifications s
LEFT JOIN dbo.qualifications q
    ON s.e_id = q.e_id
   AND s.q_name = q.q_name
   AND s.q_year = q.q_year
WHERE q.q_id IS NULL;




--     ### 11 CHECK DATA HAS BEEN INSERTED INTO FINAL TABLE ###

SELECT * FROM qualifications
ORDER BY q_id;


-- ### CHECK RECORD COUNTS IN STAGING AND FINAL TABLES ###  
SELECT COUNT(*) FROM dbo.staging_qualifications;
SELECT COUNT(*) FROM dbo.qualifications;

--     ### 12 CLEAR STAGING TABLE ###
TRUNCATE TABLE dbo.staging_qualifications;

--     ### 13 CHECK STAGING TABLE IS EMPTY ###

SELECT * FROM staging_qualifications;