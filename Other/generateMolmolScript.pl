#!/usr/bin/perl -w

use strict;


my ($modeIndex, $modelIndex);

for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
{
    for ($modelIndex = 1; $modelIndex <= 11; $modelIndex = $modelIndex + 1)

    {
	print STDOUT "ReadPdb Z:/MarsNMA/MBP/Pdb/Unidirectional/1dmb.$modeIndex.model$modelIndex.pdb\n";
    }
}

for ($modelIndex = 1; $modelIndex <= 121; $modelIndex = $modelIndex + 1)
{
    print STDOUT "ReadPdb Z:/MarsNMA/MBP/Pdb/Bimodal/1dmb.7.8.bimodal.model$modelIndex.pdb\n";
}

print STDOUT "ReadPdb Z:/Mist/PDB/1EZP_model1.pdb\n";
