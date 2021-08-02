#!/bin/sh -f

#
# Database connection parameters
# Please edit these variables to reflect your environment
#   - Tested with docker postgres 10, 11, 12, 13 (using docker postgres server and client)
#     - PGHOST=host.docker.internal
#   - Tested on Windows with "Git Bash" as a shell
#   - and psql in the path
#
export PGHOST=localhost
export PGUSER=postgres
export PGPASSWORD=
export PGDATABASE=snomed

/bin/rm -f postgres.log
touch postgres.log
ef=0

echo "See postgres.log for output"

echo "----------------------------------------" >> postgres.log 2>&1
echo "Starting ... `/bin/date`" >> postgres.log 2>&1
echo "----------------------------------------" >> postgres.log 2>&1
echo "user =       $PGUSER" >> postgres.log 2>&1
echo "db_name =    $PGDATABASE" >> postgres.log 2>&1

if [ "${password}" != "" ]; then
  password="-p${password}"
fi

echo "    Create and load tables ... `/bin/date`" >> postgres.log 2>&1
psql < psql_tc_table.sql >> postgres.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi

if [ $ef -ne 1 ]; then
echo "    Create views ... `/bin/date`" >> postgres.log 2>&1
psql < psql_tc_view.sql >> postgres.log 2>&1
if [ $? -ne 0 ]; then ef=1; fi
fi

echo "----------------------------------------" >> postgres.log 2>&1
if [ $ef -eq 1 ]
then
  echo "There were one or more errors." >> postgres.log 2>&1
  retval=-1
else
  echo "Completed without errors." >> postgres.log 2>&1
  retval=0
fi
echo "Finished ... `/bin/date`" >> postgres.log 2>&1
echo "----------------------------------------" >> postgres.log 2>&1
exit $retval
