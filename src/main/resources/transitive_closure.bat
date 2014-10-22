::
:: Configurable parameters
:: Please edit these variables to reflect your environment
::
set relsFile=c:/data/SNOMED/SnomedCT_Release_${editionLabel}_${editionVersion}/RF2Release/Snapshot/Terminology/sct2_Relationship_Snapshot_${editionLabel}_${editionVersion}.txt
set outputFile = c:/data/SNOMED/SnomedCT_Release_${editionLabel}_${editionVersion}/RF2Release/Snapshot/Terminology/sct2_TransitiveClosure_Snapshot_${editionLabel}_${editionVersion}.txt

del transitive_closure.log
echo. > transitive_closure.log
echo ---------------------------------------- >> transitive_closure.log 2>&1
echo Starting ...  >> transitive_closure.log 2>&1
date /T >> transitive_closure.log 2>&1
time /T >> transitive_closure.log 2>&1
echo ---------------------------------------- >> transitive_closure.log 2>&1
echo relsFile = %relsFile% >> transitive_closure.log 2>&1
echo outputFile = %outputFile% >> transitive_closure.log 2>&1
set error=0

:: NOTE: if this fails, make sure java is in the path
::       or edit it to use the full path to java executable
echo     Build transitive closure table >> transitive_closure.log 2>&1
del /Q %outputFile%
java -cp . com.wcinformatics.snomed.TransitiveClosureGenerator %relsFile% %outputFile%
IF %ERRORLEVEL% NEQ 0 (set error=1
goto trailer)

:trailer
echo ---------------------------------------- >> transitive_closure.log 2>&1
IF %error% NEQ 0 (
echo There were one or more errors. >> transitive_closure.log 2>&1
set retval=-1
) else (
echo Completed without errors. >> transitive_closure.log 2>&1
set retval=0
)
echo Finished ...  >> transitive_closure.log 2>&1
date /T >> transitive_closure.log 2>&1
time /T >> transitive_closure.log 2>&1
echo ---------------------------------------- >> transitive_closure.log 2>&1
pause
exit %retval%
