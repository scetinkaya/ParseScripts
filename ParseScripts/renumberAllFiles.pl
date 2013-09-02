#!/usr/bin/perl -w


for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
{
    for ($modelIndex = 1; $modelIndex <= 11; $modelIndex = $modelIndex + 1)
    {
	`renumberPdbFile.pl 1DK8-NMA.$modeIndex.model$modelIndex.pdb`;
    }
}

