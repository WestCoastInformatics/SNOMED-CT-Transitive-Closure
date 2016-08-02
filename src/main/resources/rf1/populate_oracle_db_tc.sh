#!/bin/sh -f

#
# Database connection parameters
# Please edit these variables to reflect your environment
#
ORACLE_HOME=/app/oracle/product/12.1.0/dbhome_1
export ORACLE_HOME
user=snomed
password=snomed
tns_name=global
NLS_LANG=AMERICAN_AMERICA.UTF8
export NLS_LANG

/bin/rm -f oracle.log
touch oracle.log
ef=0

echo "See oracle.log for output"
echo "----------------------------------------" >> oracle.log 2>&1
echo "Starting ... `/bin/date`" >> oracle.log 2>&1
echo "----------------------------------------" >> oracle.log 2>&1
echo "ORACLE_HOME = $ORACLE_HOME" >> oracle.log 2>&1
echo "user =        $user" >> oracle.log 2>&1
echo "tns_name =    $tns_name" >> oracle.log 2>&1

echo "    Create tables ... `/bin/date`" >> oracle.log 2>&1
echo "@oracle_tc_table.sql"|$ORACLE_HOME/bin/sqlplus $user/$password@$tns_name  >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
 
if [ $ef -ne 1 ]; then
echo "    Load transitive closure table ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="transitiveclosure.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat concept.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Create views ... `/bin/date`" >> oracle.log 2>&1
echo "@oracle_tc_view.sql"|$ORACLE_HOME/bin/sqlplus $user/$password@$tns_name  >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
fi

echo "----------------------------------------" >> oracle.log 2>&1
if [ $ef -eq 1 ]
then
  echo "There were one or more errors." >> oracle.log 2>&1
  retval=-1
else
  echo "Completed without errors." >> oracle.log 2>&1
  retval=0
fi
echo "Finished ... `/bin/date`" >> oracle.log 2>&1
echo "----------------------------------------" >> oracle.log 2>&1
exit $retval
