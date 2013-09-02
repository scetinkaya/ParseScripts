#!/usr/bin/perl -w

#usage: ./parseResonanceFile.pl filename 

# given a resonance file, parses it to read and write the H,N chemical shifts


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

#    if ($line =~ /^ATOM\s+\d+\s+(\S+)\s+(\S\S\S)\s+[\+]*[\S\s]\s+(\-*\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/)
#    if ($line =~ /^\s*\d+\s+(\d+)\s+(\w\w\w)\s+(\w+)\s+\w\s+(\-*\d+\.\d+)/)
    if ($line =~ /^\s*\d+\s+(\-*\d+\.\d+)\s+\-*\d+\.\d+\s+(\w+)\s+(\d+)/)
    {
#	print STDERR "READ LINE = $line\n";
	$aaIndex                = $3;
	$atomName               = $2;
	$chemicalShift          = $1;
	
	if ($atomName eq "N") 
	{
#	    print STDOUT "$aaIndex $aaName $chemicalShift ";
	    print STDOUT "$aaIndex $chemicalShift ";
	}
	elsif (($atomName eq "H") ||  ($atomName eq "HN"))
	{
	    print STDOUT "$chemicalShift \n";
	}
    }
    else
    {
	print STDERR "line = $line does not match the format.\n";
    }
}


