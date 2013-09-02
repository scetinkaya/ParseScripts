#!/usr/bin/perl -w

#usage: ./compareNOEFile.pl exactNOEsFile NOEsUsedInFirstRun_File

#this program reads two NOE files and compares the ranges of NOEs.

#checks to make sure that the NOEs correspond to the same atom.

#The files have the following format:

# residueIndex atomName residueIndex atomName lowerBoundDistance upperBoundDistance

#writes the two ranges to theoutput file, in the format:

#exactDistance lowerBoundDistance upperBoundDistance




$exactNoeFilename      = shift;
$firstUsedNoeFilename  = shift;
$outputFilename        = 'noeComparison.txt';

print STDOUT "check out $outputFilename\n";
open (FOUT, ">$outputFilename");


open (FIN_exactNoe_File, $exactNoeFilename) || 
    die ("couldn't open $exactNoeFilename");


open(FIN_firstUsedNoeFile, $firstUsedNoeFilename) ||
    die("couldn't open $firstUsedNoeFilename");

while ($exactNoeFileLine = <FIN_exactNoe_File>)
{
#    if ($line =~ /^(\S+) (\d+) (\-*\d+\.\d+) (\-*\d+\.\d+) (\-*\d+\.\d+)/)
    if ($exactNoeFileLine =~ /^(\d+) (\S+) (\d+) (\S+)\s+(\d+\.\d+)\s+(\d+\.\d+)/)
    {
#	&parsePdbFileLine ($1,$2,$3,$4,$5,$6);
	$exactDistance = $5;
    }
    else
    {
	die ("$exactNoeFileLine does not match the format");
    }
    
    $firstUsedNoeFileLine = <FIN_firstUsedNoeFile>;
    
    if ($firstUsedNoeFileLine =~ /^(\d+) (\S+) (\d+) (\S+)\s+(\d+\.\d+)\s+(\d+\.\d+)/)
    {
#	&parsePdbFileLine ($1,$2,$3,$4,$5,$6);
	$lowerBound = $5;
	$upperBound = $6;


	$Y = ($lowerBound + $upperBound)/2.0;
	$E = $Y - $lowerBound;

	print STDOUT "lowerbound = $lowerBound upperbound = $upperBound\n";
	    

	print FOUT "$exactDistance $Y $E\n";
    }
    else
    {
	die ("$firstUsedNoeFileLine does not match the format");
    }
}
