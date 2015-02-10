-- Show warnings after every statement.
\W

-- transitive closure table
-- NOTE: this assumes conceptpreferredname has already been created 
--       via the standard RF2 load scripts
DROP VIEW IF EXISTS transitiveclosurewithnames;
CREATE VIEW transitiveclosurewithnames AS
SELECT superTypeId, cpn1.preferredName superTypeName, 
       subTypeId, cpn2.preferredName subTypeName
FROM transitiveclosure a,
    conceptpreferredname cpn1,
    conceptpreferredname cpn2
WHERE a.superTypeId = cpn1.conceptId
  AND a.subTypeId = cpn2.conceptId;





