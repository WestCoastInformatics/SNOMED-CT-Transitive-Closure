::
:: Database connection parameters
:: Please edit these variables to reflect your environment
::
set psql=C:/PostgreSQL/pg96/bin/psql.exe
set PGHOST=localhost
set PGUSER=postgres
set PGPASSWORD=
set PGDATABASE=snomed

del postgres.log
echo. > postgres.log
echo ---------------------------------------- >> postgres.log 2>&1
echo Starting ...  >> postgres.log 2>&1
date /T >> postgres.log 2>&1
time /T >> postgres.log 2>&1
echo ---------------------------------------- >> postgres.log 2>&1
echo user =       %PGUSER% >> postgres.log 2>&1
echo db_name =    %PGDATABASE% >> postgres.log 2>&1
set error=0

echo     Create and load tables >> postgres.log 2>&1
"%psql%" < psql_tc_table.sql >> postgres.log 2>&1
IF %ERRORLEVEL% NEQ 0 (set error=1
goto trailer)

echo     Create views >> postgres.log 2>&1
"%psql%" < psql_tc_view.sql >> postgres.log 2>&1
IF %ERRORLEVEL% NEQ 0 (set error=1
goto trailer)

:trailer
echo ---------------------------------------- >> postgres.log 2>&1
IF %error% NEQ 0 (
echo There were one or more errors.  Please reference the postgres.log file for details. >> postgres.log 2>&1
set retval=-1
) else (
echo Completed without errors. >> postgres.log 2>&1
set retval=0
)
echo Finished ...  >> postgres.log 2>&1
date /T >> postgres.log 2>&1
time /T >> postgres.log 2>&1
echo ---------------------------------------- >> postgres.log 2>&1
pause
exit %retval%
