::
:: Configurable parameters
:: Please edit these variables to reflect your environment
::
set relsFile=c:/data/SNOMED/SnomedCT_Release_${editionLabel}_${editionVersion}/RF2Release/Snapshot/Terminology/sct2_Relationship_Snapshot_${editionLabel}_${editionVerision}.txt
set outputFile = c:/data/SNOMED/SnomedCT_Release_${editionLabel}_${editionVersion}/RF2Release/Snapshot/Terminology/sct2_TransitiveClosure_Snapshot_${editionLabel}_${editionVerision}.txt

del transitiveClosure.log
echo. > transitiveClosure.log
echo ---------------------------------------- >> transitiveClosure.log 2>&1
echo Starting ...  >> transitiveClosure.log 2>&1
date /T >> transitiveClosure.log 2>&1
time /T >> transitiveClosure.log 2>&1
echo ---------------------------------------- >> transitiveClosure.log 2>&1
echo relsFile = %relsFile% >> transitiveClosure.log 2>&1
set error=0

:: NOTE: if this fails, make sure java is in the path
::       or edit it to use the full path to java executable
echo     Build transitive closure table >> transitiveClosure.log 2>&1
java -cp . com.wcinformatics.snomed.rf2.TransitiveClosureGenerator %relsFile% %outputFile%
IF %ERRORLEVEL% NEQ 0 (set error=1
goto trailer)

:trailer
echo ---------------------------------------- >> transitiveClosure.log 2>&1
IF %error% NEQ 0 (
echo There were one or more errors. >> transitiveClosure.log 2>&1
set retval=-1
) else (
echo Completed without errors. >> transitiveClosure.log 2>&1
set retval=0
)
echo Finished ...  >> transitiveClosure.log 2>&1
date /T >> transitiveClosure.log 2>&1
time /T >> transitiveClosure.log 2>&1
echo ---------------------------------------- >> transitiveClosure.log 2>&1
pause
exit %retval%
