#!/usr/bin/perl -w

#usage: ./parseXinGaoDatabase.pl <XinGaoDatabaseFile> <parsedSPARTA_File> <pdbID>

# reads the XinGao database file, and parsed SPARTA File, parses them both to 
#add SSE info to the output file, in a similar format to the parsedSPARTA_File.

use strict;

my $numParameters = @ARGV;

if ($numParameters != 3)
{
    die("usage:  ./parseXinGaoDatabase.pl <XinGaoDatabaseFile> <parsedSpartaFile> <pdbID>\n");
}

my $databaseFilename         = shift;
my $parsedSpartaFilename     = shift;
my $pdbID                    = shift;

open (DATABASE, $databaseFilename) || 
    die ("couldn't open $databaseFilename");

open(SPARTA_FILE, $parsedSpartaFilename) || 
    die ("couldn't open $parsedSpartaFilename");

#first find the entry in Database file corresponding to pdbID.
#read the SSE info, write it down with the lines of the parsedSpartaFilename.
#can check whether the AA type info in Database file matches that of parsedSpartaFile.

my $sseTypes;
my $aaTypes;

while ($line = <FIN>)
{
    ($foundEntry, $aaTypes, $sseTypes) = parseLine ($line, $pdbID);
    if ($foundEntry)
    {
	writeOutput(SPARTA_FILE, $sseTypes, $aaTypes);
	break;
    }
}


sub writeOutput()
{
    my SPARTA_FILE = shift;
    my $sseTypes   = shift;
    my $aaTypes    = shift;
    my $index      = 0;

    while ($line = <SPARTA_FILE>)
    {
	if ($line ~= /^(\d+)\s(\S)\s(\S+)\s(\S+)/)
	{
	    $aaIndex = $1;
	    $aaCode  = $2;
	    $cs1     = $3;
	    $cs2     = $4;

	    if ($aaTypes[$index] != $aaCode)
	    {
		die("error. the aa code from the query $aaTypes[$index] does not match the current $aaCode");
	    }
	    print STDOUT $aaIndex." ".$aaCode." ".$sseTypes[$index]." ".$cs1." ".$cs2."\n";
	    $index   = $index + 1;
	}
	else
	{
	    die("the line $line does not match expected in SPARTA File.");
	}
    }
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line               = shift;
    my $pdbID              = shift;
    my $aaSequence = "";
    my $sseSequence = "";
    my $found  = 0;


    if ($line =~ /^>(\S+)\s+(\S\S\S\S)/)
    {
	if ($pdbID eq $2)
	{
	    $aaSequence  = shift;
	    $sseSequence = shift;
	    $found       = 1;
	}
    }

    my @retval = ($found, $aaSequence, $sseSequence);
    return @retval;
}


