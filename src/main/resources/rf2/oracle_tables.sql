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


-- Concept file.
EXECUTE drop_table('concept');
CREATE TABLE concept (
    id NUMERIC(18) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    definitionStatusId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (definitionStatusId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Description file.
EXECUTE drop_table('description');
CREATE TABLE description (
    id NUMERIC(18) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    conceptId NUMERIC(18) NOT NULL,
    languageCode CHAR(2) NOT NULL,
    typeId NUMERIC(18) NOT NULL,
    term VARCHAR2(255) NOT NULL,
    caseSignificanceId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (conceptId) REFERENCES concept(id),
    FOREIGN KEY (typeId) REFERENCES concept(id),
    FOREIGN KEY (caseSignificanceId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Identifier file.
EXECUTE drop_table('identifier');
CREATE TABLE identifier (
    identifierSchemeId NUMERIC(18) NOT NULL,
    alternateIdentifier VARCHAR2(255) NOT NULL,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Relationship file.
EXECUTE drop_table('relationship');
CREATE TABLE relationship (
    id NUMERIC(18) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    sourceId NUMERIC(18) NOT NULL,
    destinationId NUMERIC(18) NOT NULL,
    relationshipGroup INT NOT NULL,
    typeId NUMERIC(18) NOT NULL,
    characteristicTypeId NUMERIC(18) NOT NULL,
    modifierId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (sourceId) REFERENCES concept(id),
    FOREIGN KEY (destinationId) REFERENCES concept(id),
    FOREIGN KEY (typeId) REFERENCES concept(id),
    FOREIGN KEY (characteristicTypeId) REFERENCES concept(id),
    FOREIGN KEY (modifierId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Stated Relationship file.
EXECUTE drop_table('statedrelationship');
CREATE TABLE statedrelationship (
    id NUMERIC(18) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    sourceId NUMERIC(18) NOT NULL,
    destinationId NUMERIC(18) NOT NULL,
    relationshipGroup INT NOT NULL,
    typeId NUMERIC(18) NOT NULL,
    characteristicTypeId NUMERIC(18) NOT NULL,
    modifierId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (sourceId) REFERENCES concept(id),
    FOREIGN KEY (destinationId) REFERENCES concept(id),
    FOREIGN KEY (typeId) REFERENCES concept(id),
    FOREIGN KEY (characteristicTypeId) REFERENCES concept(id),
    FOREIGN KEY (modifierId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Text Definition file.
EXECUTE drop_table('textdefinition');
CREATE TABLE textdefinition (
    id NUMERIC(18) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    conceptId NUMERIC(18) NOT NULL,
    languageCode CHAR(2) NOT NULL,
    typeId NUMERIC(18) NOT NULL,
    term VARCHAR2(1024) NOT NULL,
    caseSignificanceId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (conceptId) REFERENCES concept(id),
    FOREIGN KEY (typeId) REFERENCES concept(id),
    FOREIGN KEY (caseSignificanceId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Association Reference refset file.
EXECUTE drop_table('associationreference');
CREATE TABLE associationreference (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    targetComponent NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id)
    -- TODO: FOREIGN KEY targetComponent?
)
PCTFREE 10 PCTUSED 80;


-- Attribute Value refset file.
EXECUTE drop_table('attributevalue');
CREATE TABLE attributevalue (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    valueId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id),
    FOREIGN KEY (valueId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Simple refset file.
EXECUTE drop_table('simple');
CREATE TABLE simple (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Complex Map refset file.
EXECUTE drop_table('complexmap');
CREATE TABLE complexmap (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    mapGroup INT NOT NULL,
    mapPriority INT NOT NULL,
    mapRule VARCHAR2(4000),
    mapAdvice VARCHAR2(4000),
    mapTarget VARCHAR2(100),
    correlationId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id),
    FOREIGN KEY (correlationId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Extended Map refset file.
EXECUTE drop_table('extendedmap');
CREATE TABLE extendedmap (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    mapGroup INT NOT NULL,
    mapPriority INT NOT NULL,
    mapRule VARCHAR2(4000),
    mapAdvice VARCHAR2(4000),
    mapTarget VARCHAR2(100),
    correlationId NUMERIC(18) NOT NULL,
    mapCategoryId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id),
    FOREIGN KEY (correlationId) REFERENCES concept(id),
    FOREIGN KEY (mapCategoryId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Simple Map refset file.
EXECUTE drop_table('simplemap');
CREATE TABLE simplemap (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    mapTarget VARCHAR2(100) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Lanuage refset file.
EXECUTE drop_table('language');
CREATE TABLE language (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    acceptabilityId NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id),
    FOREIGN KEY (acceptabilityId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Refset Descriptor refset file.
EXECUTE drop_table('refsetdescriptor');
CREATE TABLE refsetdescriptor (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    attributeDescription NUMERIC(18) NOT NULL,
    attributeType NUMERIC(18) NOT NULL,
    attributeOrder NUMERIC(18) NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Description Type refset file.
EXECUTE drop_table('descriptiontype');
CREATE TABLE descriptiontype (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    descriptionFormat NUMERIC(18) NOT NULL,
    descriptionLength INT NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Module Dependency refset file.
EXECUTE drop_table('moduledependency');
CREATE TABLE moduledependency (
    id CHAR(52) NOT NULL PRIMARY KEY,
    effectiveTime DATE NOT NULL,
    active NUMERIC(1) NOT NULL,
    moduleId NUMERIC(18) NOT NULL,
    refsetId NUMERIC(18) NOT NULL,
    referencedComponentId NUMERIC(18) NOT NULL,
    sourceEffectiveTime DATE NOT NULL,
    targetEffectiveTime DATE NOT NULL,
    FOREIGN KEY (moduleId) REFERENCES concept(id),
    FOREIGN KEY (refsetId) REFERENCES concept(id)
)
PCTFREE 10 PCTUSED 80;


-- Clean up helper procedures.
DROP PROCEDURE drop_table;
