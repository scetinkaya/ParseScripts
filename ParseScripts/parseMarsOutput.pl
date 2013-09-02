#!/usr/bin/perl -w

use strict;

my ($modeIndex, $modelIndex,$line);


#$modeIndex = 7; $modelIndex = 6; 
#for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
#{
#    for ($modelIndex = 1; $modelIndex <= 11; $modelIndex = $modelIndex + 1)
#    {

#for ($modelIndex = 1; $modelIndex <= 121; $modelIndex = $modelIndex + 1)
#{
#    my $outDirName = "Results7.8\_$modelIndex";


#    my $outDirName = "Results$modeIndex\_$modelIndex";
#    chdir($outDirName);


    `grep '(H)' assignment_AA.out  > parsedMarsOutput_H.txt`;
    `grep '(M)' assignment_AA.out  > parsedMarsOutput_M.txt`;
    `cat parsedMarsOutput_H.txt parsedMarsOutput_M.txt > parsedMarsOutput_MH.txt`;
    open (FIN,'parsedMarsOutput_MH.txt');
    open (FOUT, ">confidentlyAssignedResidues_MH.txt");

    while ($line = <FIN>)
    {
	if (($line =~ /\S\S\S\_(\d+)\s+(\d+) \(H\)/) || ($line =~ /\S\S\S\_(\d+)\s+(\d+) \(M\)/))
	{
	    print FOUT "$1 $2\n";
	}
    }


    close(FIN);
    close(FOUT);
#    chdir('..');

#}
#}


