::
:: Database connection parameters
:: Please edit these variables to reflect your environment
::
set ORACLE_HOME=D:\app\oracle\product\12.1.0\dbhome_1
set user=snomed
set password=snomed
set tns_name=global
set NLS_LANG=AMERICAN_AMERICA.UTF8

del oracle.log
echo. > oracle.log
echo ---------------------------------------- >> oracle.log 2>&1
echo Starting ...  >> oracle.log 2>&1
date /T >> oracle.log 2>&1
time /T >> oracle.log 2>&1
echo ---------------------------------------- >> oracle.log 2>&1
echo ORACLE_HOME = %ORACLE_HOME% >> oracle.log 2>&1
echo user =        %user% >> oracle.log 2>&1
echo tns_name =    %tns_name% >> oracle.log 2>&1
set error=0

echo     Create tables >> oracle.log 2>&1
echo @oracle_tc_table.sql|%ORACLE_HOME%\bin\sqlplus %user%/%password%@%tns_name%  >> oracle.log 2>&1
IF %ERRORLEVEL% NEQ 0 (set error=1
goto trailer)

echo     Load transitive closure table >> oracle.log 2>&1
%ORACLE_HOME%\bin\sqlldr %user%/%password%@%tns_name% control="transitiveclosure.ctl" >> oracle.log 2>&1
IF %ERRORLEVEL% NEQ 0 (set error=1)
type concept.log >> oracle.log

echo     Create views >> oracle.log 2>&1
echo @oracle_tc_view.sql|%ORACLE_HOME%\bin\sqlplus %user%/%password%@%tns_name%  >> oracle.log 2>&1
IF %ERRORLEVEL% NEQ 0 (set error=1
goto trailer)

:trailer
echo ---------------------------------------- >> oracle.log 2>&1
IF %error% NEQ 0 (
echo There were one or more errors. >> oracle.log 2>&1
set retval=-1
) else (
echo Completed without errors. >> oracle.log 2>&1
set retval=0
)
echo Finished ...  >> oracle.log 2>&1
date /T >> oracle.log 2>&1
time /T >> oracle.log 2>&1
echo ---------------------------------------- >> oracle.log 2>&1
pause
exit %retval%
