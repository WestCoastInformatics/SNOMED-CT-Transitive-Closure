SNOMED CT TRANSITIVE CLOSURE
============================
Code to build a transitive closure table from an RF2, snapshot, 
inferred SNOMED CT relationships file.  Additionally includes scripts 
to create and populate a MYSQL or Oracle database with this data.
To download a package built for the latest US or International edition, visit
http://www.westcoastinformatics.com/resources.html

*New feature: a "depth" flag is now computed as well where 0 means "self",
1 means "child", and >1 means "non-child descendant".  This enables asking
queries about "child of", "descendant of", and "descendant or self of".

Minimum Specification
---------------------
- Java 1.7
- MYSQL v5.6.x
- Oracle v11.x

Prerequisites
-------------
If loading transitive closure table into a database, first load SNOMED in RF2
using the database load scripts you can also find at the URL above.  This is
important because it creates a view that allows for denormalization of preferred
concept names, thus making the transitive closure table more useful.

Installation
------------
[See the HOWTO.txt file](../master/HOWTO.txt "HOWTO.txt")


Optional Steps - Database Load
------------------------------
PREREQUISITES: The database load script tooling available from 
  http://www.westcoastinformatics.com/resources.html has already been run and the
  database loaded.  This is "add on" functionality to an existing load.

1.  Copy the appropriate installer scripts from rf2/
	and paste them into the RF2Release directory
2.  Set the variables in the script, such as database username/password.
3.  Depending on your platform and database, execute the 
    appropriate "populate" script.  For example:
  * For MySQL on Windows, double-click the 
	  "populate_mysql_db_tc.bat" script.
  * For Oracle on Windows, double-click the 
	  "populate_oracle_db_tc.bat" script.
  * For MySQL on Linux/Unix/MacOS, open a terminal and run the 
	  "populate_mysql_db-tc.sh" script.
  * For Oracle on Linux/Unix/MacOS, open a terminal and run the 
	  "populate_oracle_db-tc.sh" script.
  * Note: a complete log file will appear as "mysql.log" or "oracle.log"


See Also
--------
* src/main/resources/LICENSE.txt
* src/main/resources/README.txt
* src/main/resources/HOWTO.txt

TODO
----
Next Steps:
* Better automated QA to validate file sizes against table sizes
* Better automated QA to validate views have same row count as driving tables
   