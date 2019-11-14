
-- Transitive closure table.
DROP TABLE IF EXISTS transitiveclosure CASCADE;
CREATE TABLE transitiveclosure (
    superTypeId NUMERIC(18) NOT NULL,
    subTypeId NUMERIC(18) NOT NULL,
    depth INT NOT NULL,
    PRIMARY KEY (superTypeId, subTypeId),
    FOREIGN KEY (superTypeId) REFERENCES concept(id),
    FOREIGN KEY (subTypeId) REFERENCES concept(id)
);

\copy transitiveclosure FROM 'Snapshot/Terminology/sct2_TransitiveClosure_Snapshot_${editionLabel}_${editionVersion}.txt' WITH DELIMITER E'\t' QUOTE E'\\' ENCODING 'UTF8' CSV HEADER;

