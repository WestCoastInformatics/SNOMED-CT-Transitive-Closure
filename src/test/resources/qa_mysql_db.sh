#!/bin/sh -f

##### This script is a work in progress.
##### Its intention is to eventually QA the import scripts.


#
# Database connection parameters
# Please edit these variables to reflect your environment
#
MYSQL_HOME="C:\\Program Files\\MySQL\\MySQL Server 5.6"
user=root
password=admin
db_name=snomed

/bin/rm -f mysql.log
touch mysql.log
ef=0

echo "See mysql.log for output"

echo "----------------------------------------" >> mysql.log 2>&1
echo "Starting ... `/bin/date`" >> mysql.log 2>&1
echo "----------------------------------------" >> mysql.log 2>&1
echo "MYSQL_HOME = $MYSQL_HOME" >> mysql.log 2>&1
echo "user =       $user" >> mysql.log 2>&1
echo "db_name =    $db_name" >> mysql.log 2>&1

echo "    Export tables ... `/bin/date`" >> mysql.log 2>&1
"$MYSQL_HOME/bin/mysql" -vvv -u $user -p$password $db_name < export_mysql.sql >> mysql.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi


# Function to test if two numbers match
function expect {
    if [ $1 -ne $2 ]; then
        echo "Counts do not match."
        ef=1
    else
        echo "Counts match."
    fi
}


if [ $ef -ne 1 ]; then
echo "    Compare line counts ... `/bin/date`" >> mysql.log 2>&1

# TODO: Implement.
in=$(wc -l Snapshot/Terminology/sct2_Concept_Snapshot_INT_20140131.txt | cut -d ' ' -f 1)
out=$(wc -l c:/TEMP/Concept.txt | cut -d ' ' -f 1)
expect $out $[$in - 1]

fi

echo "----------------------------------------" >> mysql.log 2>&1
if [ $ef -eq 1 ]
then
  echo "There were one or more errors." >> mysql.log 2>&1
  retval=-1
else
  echo "Completed without errors." >> mysql.log 2>&1
  retval=0
fi
echo "Finished ... `/bin/date`" >> mysql.log 2>&1
echo "----------------------------------------" >> mysql.log 2>&1
exit $retval
