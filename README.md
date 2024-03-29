# DEPRECATED - see https://github.com/WestCoastInformatics/SNOMED-DB-Load-Scripts

The functionality of this project has been fullyl  merged into SNOMED-DB-Load-Scripts



SNOMED CT TRANSITIVE CLOSURE
============================
Code to build a transitive closure table from an RF2, snapshot,
inferred SNOMED CT relationships file.  Additionally includes scripts
to create and populate a Postgres, Oracle, or MySQL (and MariaDB) database
with this data.  To download a package built for the latest US or International
edition, visit:
https://www.westcoastinformatics.com/products/db-load-scripts

*New feature: a "depth" flag is now computed as well where 0 means "self",
1 means "child", and >1 means "non-child descendant".  This enables asking
queries about "child of", "descendant of", and "descendant or self of".

Minimum Specification
---------------------
- Java 1.8
- MYSQL v5.7.+, MySQL v8.+, MariaDB 10.+
  - MySQL v8 requires the server to run with "--local_infile=ON"
- Oracle v12.+
- Postgres v11.+, v12.+, v13.+, v14.+, v15.+

Prerequisites
-------------
If loading transitive closure table into a database, first load SNOMED in RF2
using the database load scripts you can also find at the URL above.  This is
important because it creates a view that allows for denormalization of preferred
concept names, thus making the transitive closure table more useful.

Installation
------------
* See [HOWTO.txt](src/main/resources/HOWTO.txt) file to understand how to load the transitive closure table into a database

See Also
--------
* [src/main/resources/LICENSE.txt](src/main/resources/LICENSE.txt)
* [src/main/resources/README.txt](src/main/resources/README.txt)
* [src/main/resources/HOWTO.txt](src/main/resources/HOWTO.txt)
* [src/main/perl/transitiveClosure.pl](src/main/perl/transitiveClosure.pl) - this is just a pure Perl script for generating transitive closure from a SNOMED relationships file.
```
$ ./transitiveClosure.pl
This script has the following usage:
transitiveClosure.pl <relsFile> <outputFile>
```
