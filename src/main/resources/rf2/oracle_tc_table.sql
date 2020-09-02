WHENEVER SQLERROR EXIT -1
SET ECHO ON


-- Session settings.
ALTER SESSION SET NLS_LENGTH_SEMANTICS='CHAR';


-- Define helper procedure to drop tables.
BEGIN
    EXECUTE IMMEDIATE 'DROP PROCEDURE drop_table';
EXCEPTION
    WHEN OTHERS THEN
        -- If procedure doesn't exist, it can't be dropped,
        -- so an exception will be thrown.  Ignore it.
        IF SQLCODE != -4043 THEN
            RAISE;
        END IF;
END;
/
CREATE PROCEDURE drop_table (table_name IN VARCHAR2) IS
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ' || table_name || ' CASCADE CONSTRAINTS';
EXCEPTION
    -- If table doesn't exist, it can't be dropped,
    -- so an exception will be thrown.  Ignore it.
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- Transitive closure table
EXECUTE drop_table('transitiveclosure');
CREATE TABLE transitiveclosure (
    superTypeId NUMERIC(20) NOT NULL,
    subTypeId NUMERIC(20) NOT NULL,
    depth INTEGER NOT NULL,
    PRIMARY KEY (superTypeId, subTypeId),
    FOREIGN KEY (superTypeId) REFERENCES concept(id),
    FOREIGN KEY (subTypeId) REFERENCES concept(id)
) 
PCTFREE 10 PCTUSED 80;


-- Clean up helper procedures.
DROP PROCEDURE drop_table;
