WHENEVER SQLERROR EXIT -1
SET ECHO ON


-- Session settings.
ALTER SESSION SET NLS_LENGTH_SEMANTICS='CHAR';


-- Define helper procedure to drop views.
BEGIN
    EXECUTE IMMEDIATE 'DROP PROCEDURE drop_view';
EXCEPTION
    WHEN OTHERS THEN
        -- If procedure doesn't exist, it can't be dropped,
        -- so an exception will be thrown.  Ignore it.
        IF SQLCODE != -4043 THEN
            RAISE;
        END IF;
END;
/
CREATE PROCEDURE drop_view (view_name IN VARCHAR2) IS
BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW ' || view_name || ' CASCADE CONSTRAINTS';
EXCEPTION
    -- If view doesn't exist, it can't be dropped,
    -- so an exception will be thrown.  Ignore it.
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- transitive closure table
-- NOTE: this assumes conceptpreferredname has already been created 
--       via the standard RF2 load scripts
EXECUTE drop_view('transitiveclosurewithnames');
CREATE VIEW transitiveclosurewithnames AS
SELECT superTypeId, cpn1.preferredName superTypeName, 
       subTypeId, cpn2.preferredName subTypeName
FROM transitiveclosure a,
    conceptpreferredname cpn1,
    conceptpreferredname cpn2
WHERE a.superTypeId = cpn1.conceptId 
  AND a.subTypeId = cpn2.conceptId;

-- Clean up helper procedures.
DROP PROCEDURE drop_view;
