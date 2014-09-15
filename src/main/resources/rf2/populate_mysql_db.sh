#!/bin/sh -f

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

echo "    Create and load tables ... `/bin/date`" >> mysql.log 2>&1
"$MYSQL_HOME/bin/mysql" -vvv -u $user -p$password $db_name < mysql_tables.sql >> mysql.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi

if [ $ef -ne 1 ]; then
echo "    Create views ... `/bin/date`" >> mysql.log 2>&1
"$MYSQL_HOME/bin/mysql" -vvv -u $user -p$password $db_name < mysql_views.sql >> mysql.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
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
