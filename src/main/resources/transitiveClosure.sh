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
echo "@oracle_tables.sql"|$ORACLE_HOME/bin/sqlplus $user/$password@$tns_name  >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
 
if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="concept.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat concept.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="description.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat description.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="identifier.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat identifier.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="relationship.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat relationship.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="statedrelationship.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat statedrelationship.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="textdefinition.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat textdefinition.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="associationreference.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat associationreference.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="attributevalue.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat attributevalue.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="simple.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat simple.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="complexmap.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat complexmap.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="extendedmap.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat extendedmap.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="simplemap.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat simplemap.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="language.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat language.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="refsetdescriptor.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat refsetdescriptor.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="descriptiontype.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat descriptiontype.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Load content table data ... `/bin/date`" >> oracle.log 2>&1
$ORACLE_HOME/bin/sqlldr $user/$password@$tns_name control="moduledependency.ctl" >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
cat moduledependency.log >> oracle.log
fi

if [ $ef -ne 1 ]; then
echo "    Create indexes ... `/bin/date`" >> oracle.log 2>&1
echo "@oracle_indexes.sql"|$ORACLE_HOME/bin/sqlplus $user/$password@$tns_name  >> oracle.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
fi

if [ $ef -ne 1 ]; then
echo "    Create views ... `/bin/date`" >> oracle.log 2>&1
echo "@oracle_views.sql"|$ORACLE_HOME/bin/sqlplus $user/$password@$tns_name  >> oracle.log 2>&1
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
