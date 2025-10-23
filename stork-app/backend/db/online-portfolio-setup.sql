-- ============================================
-- 1️⃣  Create a new subset table in the original DB
-- ============================================
-- CREATE SCHEMA IF NOT EXISTS migration_data;

-- -- ============================================
-- -- 2️⃣  Deduplicate and calculate deterministic sampling rate
-- -- ============================================
CREATE TABLE migration_data.stork_data_subset AS
WITH
filtered_base AS (
    SELECT *
    FROM migration_data.stork_data
    WHERE sql_distance IS NOT NULL
      AND sql_heading IS NOT NULL
),
deduped AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY individual_local_identifier,
                         timestamp,
                         location_lat,
                         location_long
            ORDER BY timestamp
        ) AS rn
    FROM filtered_base
),
filtered_deduped AS (
    SELECT *
    FROM deduped
    WHERE rn = 1
),
calc_rate AS (
    SELECT CEIL(COUNT(*) / 100000.0) AS sample_rate
    FROM filtered_deduped
),
sampled AS (
    SELECT fd.*
    FROM filtered_deduped fd
    CROSS JOIN calc_rate cr
    WHERE MOD(record_id, cr.sample_rate) = 0
)
SELECT *
FROM sampled;

-- ============================================
-- 3️⃣  Reorder by bird and timestamp
-- ============================================
CREATE TABLE migration_data.stork_data_subset_ordered AS
SELECT *
FROM migration_data.stork_data_subset
ORDER BY individual_local_identifier, timestamp;

DROP TABLE migration_data.stork_data_subset;

ALTER TABLE migration_data.stork_data_subset_ordered
RENAME TO stork_data_subset;


-- ============================================
-- 4️⃣  Reset record_id sequentially
-- ============================================
ALTER TABLE migration_data.stork_data_subset
DROP COLUMN IF EXISTS record_id;

ALTER TABLE migration_data.stork_data_subset
ADD COLUMN record_id BIGSERIAL PRIMARY KEY;