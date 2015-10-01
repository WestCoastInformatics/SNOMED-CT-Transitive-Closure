-- Show warnings after every statement.
\W

-- Disable foreign key checks so tables can be dropped/created in any order.
SET FOREIGN_KEY_CHECKS = 0;


-- Concept file.
DROP TABLE IF EXISTS transitiveclosure;
CREATE TABLE transitiveclosure (
    superTypeId NUMERIC(18) UNSIGNED NOT NULL,
    subTypeId NUMERIC(18) UNSIGNED NOT NULL,
    depth INT NOT NULL,
    PRIMARY KEY (superTypeId, subTypeId),
    FOREIGN KEY (superTypeId) REFERENCES concept(id),
    FOREIGN KEY (subTypeId) REFERENCES concept(id)
) CHARACTER SET utf8;

LOAD DATA LOCAL INFILE 'Snapshot/Terminology/sct2_TransitiveClosure_Snapshot_${editionLabel}_${editionVersion}.txt' INTO TABLE transitiveclosure LINES TERMINATED BY '\r\n' IGNORE 1 LINES
(@superTypeId,@subTypeId)
SET superTypeId = @superTypeId,
subTypeId = @subTypeId;

-- Restore foreign key checks to enforce referential integrity.
SET FOREIGN_KEY_CHECKS = 1;
