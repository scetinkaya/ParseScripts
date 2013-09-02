#!/usr/bin/perl -w

use strict;

my ($modelIndex, $fileIndex);


for ($modelIndex = 100; $modelIndex <= 17600; $modelIndex = $modelIndex + 100)
{
    if ($modelIndex < 1000)
    {
	$fileIndex = "/usr/project/dlab/Users/apaydin/Mist/MarsFroda/Ubiquitin/1UBQ/Pdb/LongerRun/1ubq_froda_00000$modelIndex.pdb";
    }
    elsif ($modelIndex < 10000)
    {
	$fileIndex = "/usr/project/dlab/Users/apaydin/Mist/MarsFroda/Ubiquitin/1UBQ/Pdb/LongerRun/1ubq_froda_0000$modelIndex.pdb";
    }
    else
    {
	$fileIndex = "/usr/project/dlab/Users/apaydin/Mist/MarsFroda/Ubiquitin/1UBQ/Pdb/LongerRun/1ubq_froda_000$modelIndex.pdb";
    }
    
    `rm -f 1ubq.pdb`;
    `ln -s $fileIndex 1ubq.pdb`;
    `/usr/project/dlab/data_from_dartmouth/mist/apaydin/Tools/Mars/mars-1.1.3_linux/bin/runmars mars.inp`;
    my $outDirName = "Results$modelIndex";
    `mkdir $outDirName`;
    `mv *.out $outDirName`;
}


