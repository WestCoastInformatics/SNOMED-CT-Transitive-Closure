SNOMED CT TRANSITIVE CLOSURE
============================
Code to build a transitive closure table from an RF2, snapshot, 
inferred SNOMED CT relationships file.  Additionally includes scripts 
to create and populate a MYSQL or Oracle database with this data.
To download a package built for the latest US or International edition, visit
http://www.westcoastinformatics.com/resources.html

Minimum Specification
---------------------
- Java 1.7
- MYSQL v5.5.x
- Oracle v10.x

Prerequisites
-------------
If loading transitive closure table into a database, first load SNOMED in RF2
using the database load scripts you can also find at the URL above.  This is
important because it creates a view that allows for denormalization of preferred
concept names, thus making the transitive closure table more useful.

Installation
------------
1. Download the SNOMED CT International Release files and unzip into a folder
    in ZIP format.  US Users can find the files here:
  * SNOMED CT® US Edition Release Files: 
    * http://www.nlm.nih.gov/research/umls/Snomed/us_edition.html
  * SNOMED CT® International Edition Release Files: 
    * http://www.nlm.nih.gov/research/umls/licensedcontent/snomedctfiles.html
  * SNOMED CT® International Edition Archive Files
    * http://www.nlm.nih.gov/research/umls/licensedcontent/snomedctarchive.html
2. Unzip the transitive closure tools into a folder
3. Edit the transitive_closure script (either .bat or .sh depending on your envrioment)
  * Set the path to the RF2, snapshot, inferred SNOMED CT relationships file
  * Set the path to the output file (if using the database load scripts, make sure the
     output file winds up in the same directory as the input relationships file and
     with a naming convention consistent with that of the other SNOMED files)
4. Run the script and it will generate the transitive closure file.

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

   