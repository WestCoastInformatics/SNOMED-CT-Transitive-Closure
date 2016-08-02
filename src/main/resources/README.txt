Welcome to SNOMED CT transitive closure and database load scripts
http://www.wcinformatics.com/resources.html

Go to the above link for documentation, and additional downloads.

Important Notes
---------------
* This code is configured to work with the ${editionVersion}
  SNOMEDCT ${editionLabel} Edition.
* NOTE: RF1 and RF2 produce different results mostly due to
        the differing use of metadata concepts between the
        two formats.  For RF1, relationships for inactive
        concepts are left out of the computation.

Key Features
------------
* Builds transitive closure table from an RF1 or an RF2, 
  snapshot, inferred, SNOMED file.
* Support for Oracle and MySQL
* Views with denormalized concept preferred names

Developer Notes
---------------
https://github.com/bcarlsenca/SNOMED-CT-Transitive-Closure.git
