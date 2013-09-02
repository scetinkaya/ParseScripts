#!/usr/bin/perl -w

#usage: ./parseCingFile.pl filename 

#this is for parsing CING output containing chemical shifts

$inputFile         = shift;


open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the CING file)");


while ($line = <FIN>)
{
    &parseLine ($line);
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

    if ($line =~ /\s+(\s+)\s+(\d+)\s+(\S\S\S)\s+(\S+)\s+(\S+)\s+(\d+\.\d+)\s+(\d+\.\d+)/)
    {
	$aaNumber      = $2;
	
	$atomType      = $4;

	$chemicalShift = $7;

	if (($atomType eq "HN") || ($atomType eq "N"))
	{
	    print STDOUT "$aaNumber $atomType $chemicalShift\n";
	}
    }
    else
    {
	print STDERR "line = $line does not match the format.\n";
    }
}
