-- Employee active cascade trigger
CREATE TRIGGER trg_employee_active_cascade
ON dbo.employee
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Only process rows where e_active actually changed
    IF NOT UPDATE(e_active)
        RETURN;

    -- Deactivate related records
    UPDATE q
    SET q.q_active = e.e_active
    FROM dbo.qualifications q
    INNER JOIN inserted e ON q.e_id = e.e_id
    INNER JOIN deleted  d ON d.e_id = e.e_id
    WHERE e.e_active <> d.e_active;

    UPDATE p
    SET p.p_active = e.e_active
    FROM dbo.projects p
    INNER JOIN inserted e ON p.e_id = e.e_id
    INNER JOIN deleted  d ON d.e_id = e.e_id
    WHERE e.e_active <> d.e_active;

    UPDATE c
    SET c.cpd_active = e.e_active
    FROM dbo.cpd c
    INNER JOIN inserted e ON c.e_id = e.e_id
    INNER JOIN deleted  d ON d.e_id = e.e_id
    WHERE e.e_active <> d.e_active;

    UPDATE eh
    SET eh.eh_active = e.e_active
    FROM dbo.employment_history eh
    INNER JOIN inserted e ON eh.e_id = e.e_id
    INNER JOIN deleted  d ON d.e_id = e.e_id
    WHERE e.e_active <> d.e_active;

    UPDATE cm
    SET cm.cm_active = e.e_active
    FROM dbo.category_match cm
    INNER JOIN inserted e ON cm.e_id = e.e_id
    INNER JOIN deleted  d ON d.e_id = e.e_id
    WHERE e.e_active <> d.e_active;
END;
GO

-- Verify trigger creation
SELECT
    t.name AS trigger_name,
    OBJECT_NAME(t.parent_id) AS table_name,
    t.is_disabled
FROM sys.triggers t
WHERE t.name = 'trg_employee_active_cascade';

-- Qualifications enforcement trigger
CREATE TRIGGER trg_qualifications_institution
ON dbo.qualifications
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.qualifications AS target
    USING (
        SELECT
            q_id,
            e_id,
            q_type,
            CASE
                WHEN q_type = 'Professional' THEN 'N/A'
                ELSE q_institution
            END AS q_institution,
            q_active
        FROM inserted
    ) AS src
    ON target.q_id = src.q_id

    WHEN MATCHED THEN
        UPDATE SET
            target.e_id = src.e_id,
            target.q_type = src.q_type,
            target.q_institution = src.q_institution,
            target.q_active = src.q_active

    WHEN NOT MATCHED THEN
        INSERT (e_id, q_type, q_institution, q_active)
        VALUES (src.e_id, src.q_type, src.q_institution, src.q_active);
END;
GO

