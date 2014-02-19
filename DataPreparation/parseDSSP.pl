#!/usr/bin/perl -w

#usage: ./parseDSSPFile.pl filename

# given an input (DSSP) file, parses it to write sse types.


$inputFile         = shift;

if ($inputFile =~ /(.*)\.dssp$/)
{
    $outputFile = $1.".parsedDSSP";
    print STDERR "check out $outputFile\n";
    open (FOUT, ">$outputFile");
}
else
{
    die("error! file should be a dssp file and should finish with .dssp\n");
}

open (FIN, $inputFile) ||
    die ("couldn't open $inputFile (should be the dssp file)");

$sseStartIndex = 0;
$sseEndIndex   = 0;
$lastSseType   = " ";

while ($line = <FIN>)
{
        if (($line =~ /^\s+\d+\s+\d+\s+\w/))
	{
	    &parseLine ($line);
	}
}

# the line contains the sse info, which will be printed.
sub parseLine
{
    my $line           = shift;
        if ($line =~ /^\s+\d+\s+(\d+)\s+\w\s+(\w)/)
	{
	    #print STDERR "READ LINE = $line\n";
	    $residueIndex                 = $1;
	    $sseType                      = $2;

	    if ($lastSseType ne $sseType)
	    {
		    if (&writeSse($lastSseType))
		    {
			print FOUT "$sseStartIndex $sseEndIndex $lastSseType\n";
		    }
		    $sseStartIndex = $residueIndex;
		    $lastSseType   = $sseType;
		}
	    else
	    {
		$sseEndIndex = $residueIndex;
	    }
	}
}


#returns 1 if sseType is H, E, G or I.
sub writeSse
{
    my $sseType = shift;
    my $retval   = 1;
        unless (($sseType eq "H") || ($sseType eq "E") || ($sseType eq "G") || ($sseType eq "I"))
	{
	    $retval = 0;
	}
    $retval;
}
