#!/bin/sh -f
#
# Configurable parameters
# Please edit these variables to reflect your environment
#


# Configure defaults for RF2
relsFile = Snapshot/Terminology/sct2_Relationship_Snapshot_${editionLabel}_${editionVersion}.txt
outputFile = Snapshot/Terminology/sct2_TransitiveClosure_Snapshot_${editionLabel}_${editionVersion}.txt

/bin/rm -f transitive_closure.log
touch transitive_closure.log
ef=0

echo "See transitive_closure.log for output"
echo "----------------------------------------" >> transitive_closure.log 2>&1
echo "Starting ... `/bin/date`" >> transitive_closure.log 2>&1
echo "----------------------------------------" >> transitive_closure.log 2>&1
echo "relsFile = $relsFile" >> transitive_closure.log 2>&1
echo "outputFile = $outputFile" >> transitive_closure.log 2>&1

# NOTE: if this fails, make sure java is in the path
#       or edit it to use the full path to java executable
echo "    Build transitive closure table ... `/bin/date`" >> transitive_closure.log 2>&1
/bin/rm -f $outputFile
java -cp . com.wcinformatics.snomed.TransitiveClosureGenerator $relsFile $outputFile
if [ $? -ne 0 ]; then ef=1; fi

echo "----------------------------------------" >> transitive_closure.log 2>&1
if [ $ef -eq 1 ]
then
  echo "There were one or more errors." >> transitive_closure.log 2>&1
  retval=-1
else
  echo "Completed without errors." >> transitive_closure.log 2>&1
  retval=0
fi
echo "Finished ... `/bin/date`" >> transitive_closure.log 2>&1
echo "----------------------------------------" >> transitive_closure.log 2>&1
exit $retval
