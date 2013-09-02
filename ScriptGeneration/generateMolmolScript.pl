#!/usr/bin/perl -w

#usage: ./generateMolmolScript

for ($modeIndex = 7; $modeIndex <= 11; $modeIndex++)
{
    for ($modelIndex = 1; $modelIndex <= 11; $modelIndex++)
    {
	print STDOUT "ReadPdb z:/workDir/1EF1/Pdb/1EF1-NMA.$modeIndex.model$modelIndex.pdb\n";
    }
}
