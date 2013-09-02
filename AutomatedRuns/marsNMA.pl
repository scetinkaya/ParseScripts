#!/usr/bin/perl -w

use strict;

my ($modeIndex, $modelIndex);

#$modeIndex = 7; $modelIndex = 6; 
for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
{
#   `dividePDB_File.pl /usr/project/dlab/Users/apaydin/Mist/MarsNMA/Ubiquitin/1UBQ/Pdb/Unidirectional/1ubq.$modeIndex.pdb`;
    
    for ($modelIndex = 1; $modelIndex <= 11; $modelIndex = $modelIndex + 1)
    {
#	my $fileIndex = "/usr/project/dlab/Users/apaydin/Mist/MarsNMA/Ubiquitin/1UBQ/Pdb/Unidirectional/1ubq.$modeIndex.model$modelIndex.pdb";
	my $fileIndex = "/usr/project/dlab/Users/apaydin/Mist/ProteinFlexibility/HD_AndNMA/LangmeadHomologyModels/Better/ff2/NMA/2E71-NMA.$modeIndex.model$modelIndex.pdb";
	`rm -f 2E71.pdb`;
	`ln -s $fileIndex 2E71.pdb`;
	`/usr/project/dlab/data_from_dartmouth/mist/apaydin/Tools/Mars/mars-1.1.3_linux/bin/runmars mars.inp`;
	my $outDirName = "Results$modeIndex\_$modelIndex";
	`mkdir $outDirName`;
	`mv *.out $outDirName`;
    }
}

