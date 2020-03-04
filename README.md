SNOMED CT TRANSITIVE CLOSURE
============================
Code to build a transitive closure table from an RF2, snapshot, 
inferred SNOMED CT relationships file.  Additionally includes scripts 
to create and populate a Postgres, Oracle, or MySQL (and MariaDB) database 
with this data.  To download a package built for the latest US or International 
edition, visit:
http://www.westcoastinformatics.com/resources.html

*New feature: a "depth" flag is now computed as well where 0 means "self",
1 means "child", and >1 means "non-child descendant".  This enables asking
queries about "child of", "descendant of", and "descendant or self of".

Minimum Specification
---------------------
- Java 1.7
- MYSQL v5.6.+, MySQL v8.+, MariaDB 10.+
  - MySQL v8 requires the server to run with "--local_infile=ON"  
- Oracle v11.+
- Postgres v9.+, v10.+, v11.+, v12.+

Prerequisites
-------------
If loading transitive closure table into a database, first load SNOMED in RF2
using the database load scripts you can also find at the URL above.  This is
important because it creates a view that allows for denormalization of preferred
concept names, thus making the transitive closure table more useful.

Installation
------------
* See HOWTO.txt file to understand how to load the transitive closure table into a database

See Also
--------
src/main/resources/LICENSE.txt
src/main/resources/README.txt
src/main/resources/HOWTO.txt

   
