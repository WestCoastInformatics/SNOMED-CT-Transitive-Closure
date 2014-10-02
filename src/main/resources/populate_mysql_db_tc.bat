::
:: Database connection parameters
:: Please edit these variables to reflect your environment
::
set MYSQL_HOME=C:\Program Files\MySQL\MySQL Server 5.6
set user=root
set password=admin
set db_name=snomed

del mysql.log
echo. > mysql.log
echo ---------------------------------------- >> mysql.log 2>&1
echo Starting ...  >> mysql.log 2>&1
date /T >> mysql.log 2>&1
time /T >> mysql.log 2>&1
echo ---------------------------------------- >> mysql.log 2>&1
echo MYSQL_HOME = %MYSQL_HOME% >> mysql.log 2>&1
echo user =       %user% >> mysql.log 2>&1
echo db_name =    %db_name% >> mysql.log 2>&1
set error=0

echo     Create and load tables >> mysql.log 2>&1
"%MYSQL_HOME%\bin\mysql" -vvv -u %user% -p%password% --local-infile=1 %db_name%  < mysql_tc_table.sql >> mysql.log 2>&1
IF %ERRORLEVEL% NEQ 0 (set error=1
goto trailer)

echo     Create views >> mysql.log 2>&1
"%MYSQL_HOME%\bin\mysql" -vvv -u %user% -p%password% --local-infile=1 %db_name% < mysql_tc_view.sql >> mysql.log 2>&1
IF %ERRORLEVEL% NEQ 0 (set error=1
goto trailer)

:trailer
echo ---------------------------------------- >> mysql.log 2>&1
IF %error% NEQ 0 (
echo There were one or more errors.  Please reference the mysql.log file for details. >> mysql.log 2>&1
set retval=-1
) else (
echo Completed without errors. >> mysql.log 2>&1
set retval=0
)
echo Finished ...  >> mysql.log 2>&1
date /T >> mysql.log 2>&1
time /T >> mysql.log 2>&1
echo ---------------------------------------- >> mysql.log 2>&1
pause
exit %retval%
