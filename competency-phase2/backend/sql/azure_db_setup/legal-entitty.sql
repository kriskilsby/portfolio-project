--     ### 1 CHECK INITIALLY FOR DATA IN FINAL TABLE ###

SELECT * FROM legal_entity;

--     ### 2 CREATE STAGING TABLE ###

CREATE TABLE staging_legal_entity (
    le_name VARCHAR(50) NOT NULL,
    data_origin VARCHAR(20) NOT NULL
);

--     ### 3 CHECK TABLE HAS BEEN CREATED ###

SELECT * FROM staging_legal_entity;

--     ### DONE ALREADY IGNORE - 4 CHECK IF DATABASE MASTER KEY EXISTS ###

-- SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##';

--     ### DONE ALREADY IGNORE - 5 IF NO MASTER KEY, CREATE ONE ###

-- CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'IwCDeBtD08!';

--     ### DONE ALREADY IGNORE - 6 IF NOT DONE SO ALREADY CREATE DATABASE SCOPED CREDENTIAL FOR AZURE BLOB STORAGE ###

-- CREATE DATABASE SCOPED CREDENTIAL AzureBlobCredential
-- WITH
--     IDENTITY = 'SHARED ACCESS SIGNATURE',
--     SECRET = 'sp=r&st=2026-01-06T17:40:23Z&se=2026-01-07T01:55:23Z&spr=https&sv=2024-11-04&sr=b&sig=3jNdrIEQ0qPIGo0RKU8%2BXFX18MIYU4LvONmDgaUUlL8%3D';

--     ### DONE ALREADY IGNORE - 7 CREATE EXTERNAL DATA SOURCE FOR AZURE BLOB STORAGE ###

-- CREATE EXTERNAL DATA SOURCE MyBlobStorage
-- WITH (
--     TYPE = BLOB_STORAGE,
--     LOCATION = 'https://competencydataset.blob.core.windows.net/dataset-files',
--     CREDENTIAL = AzureBlobCredential
-- );

--     ### 8 BULK INSERT DATA FROM CSV FILE IN BLOB STORAGE TO STAGING TABLE ###

BULK INSERT dbo.staging_legal_entity
FROM 'legal-entity.csv'             -- just the file name
WITH (
    DATA_SOURCE = 'MyBlobStorage',  -- the external data source object in your DB
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

--     ### 9 CHECK DATA HAS BEEN LOADED INTO STAGING TABLE ###

SELECT * FROM staging_legal_entity;

--     ### 10 INSERT NEW RECORDS FROM STAGING TABLE TO FINAL TABLE ###

INSERT INTO dbo.legal_entity (le_name, data_origin)
SELECT s.le_name, s.data_origin
FROM dbo.staging_legal_entity s
LEFT JOIN dbo.legal_entity e
  ON s.le_name = e.le_name
WHERE e.le_name IS NULL;

--     ### 11 CHECK DATA HAS BEEN INSERTED INTO FINAL TABLE ###

SELECT * FROM legal_entity;

--     ### 12 CLEAR STAGING TABLE ###

TRUNCATE TABLE dbo.staging_legal_entity;

--     ### 13 CHECK STAGING TABLE IS EMPTY ###

SELECT * FROM staging_legal_entity;