#!/usr/bin/perl -w

#usage: ./parseMarsRDC_File.pl filename 

# given an RDC file, parses it to read and write the desired RDCs ("NH", "NC", etc.) in the following format:

# aaName RDC_Value

#Please change the corresponding parsing line to extract the right type of RDC.

$inputFile         = shift;

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");


while ($line = <FIN>)
{
    &parseLine ($line);
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

#    if (($line =~ /^\s*(\d+)\s+\w\w\w\s+N\s+(\d+)\s+\w\w\w\s+HN\s+(\-*\d+\.\d+)/)) #for H and NH RDC
#    if (($line =~ /^\s*(\d+)\s+\w\w\w\s+N\s+(\d+)\s+\w\w\w\s+C\s+(\-*\d+\.\d+)/)) #for N and C RDC
    if (($line =~ /^\s*(\d+)\s+\w\w\w\s+C\s+(\d+)\s+\w\w\w\s+CA\s+(\-*\d+\.\d+)/)) #for N and C RDC
    {
#	print STDERR "READ LINE = $line\n";
	$aaIndex                = $1;
	$aaIndexOfSecondAtom    = $2;
	$rdc                    = $3;

#	if ($aaIndexOfSecondAtom != $aaIndex-1) #this is for NC RDC.
	if ($aaIndexOfSecondAtom != $aaIndex) #this is for NC RDC.
	{
	    print STDERR "First atom index = $aaIndex Second atom index = $aaIndexOfSecondAtom\n";
	    exit(0);
	}

	print STDOUT "$aaIndex $rdc\n";
    }
    else
    {
	print STDERR "line = $line does not match the format.\n";
    }
}


