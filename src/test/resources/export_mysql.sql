-- Show warnings after every statement.
\W

-- Concept file.
SELECT * FROM CONCEPT
INTO OUTFILE '/TEMP/Concept.txt'
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\r\n';

-- Description file.
SELECT * FROM DESCRIPTION
INTO OUTFILE '/TEMP/Description.txt'
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\r\n';


-- Identifier file.


-- Relationship file.


-- Stated Relationship file.


-- Text Definition file.


-- Association Reference refset file.


-- Attribute Value refset file.


-- Simple refset file.


-- Complex Map refset file.


-- Extended Map refset file.


-- Simple Map refset file.


-- Language refset file.


-- Refset Descriptor refset file.


-- Description Type refset file.


-- Module Dependency refset file.
