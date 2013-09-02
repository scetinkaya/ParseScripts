#!/usr/bin/perl -w

$modelIndex = shift;

print STDOUT "modelIndex = $modelIndex\n";

if (($modelIndex <7) || ($modelIndex > 11))
{
    die("error. modelIndex is not within range.\n");
}

$outputScript = "runMatlab_modifyingOnlySHIFTS_$modelIndex.sh";

open(FOUT, ">$outputScript");

#for ($modelIndex = 7; $modelIndex <= 7; $modelIndex = $modelIndex + 1)
{

    $exeName = "/home/home4/apaydin/Mist/Matlab/AutomatedRuns/normalModeHD_modifyingOnlySHIFTS";

#   `ssh $machineName "cd BlameAssignment_1JML/ModifyingOnlySHIFTS; nohup matlab -nojvm -nodisplay -r "$exeName($modelIndex)" &`;
 
    print FOUT "#!/bin/tcsh\n";

    print FOUT "/usr/research/pkg/matlab/bin/matlab -nojvm -nodisplay -r $exeName($modelIndex)";

#    `qsub $outputScript`;
   
}

close(FOUT);
