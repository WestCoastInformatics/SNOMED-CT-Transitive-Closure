-- Show warnings after every statement.
\W

-- transitive closure table
-- NOTE: this assumes conceptpreferredname has already been created 
--       via the standard RF2 load scripts
DROP VIEW IF EXISTS transitiveclosurewithnames;
CREATE VIEW transitiveclosurewithnames AS
SELECT superTypeId, superTypeName, subTypeId, subTypeName
FROM transitiveclosure a,
    conceptpreferredname cpn1,
    conceptpreferredname cpn2
WHERE a.superTypeId = cpn1.conceptId
  AND a.superTypeId = cpn2.conceptId;




