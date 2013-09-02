#!/usr/bin/perl -w

#usage: ./parseMarsResonanceFile.pl filename 

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

    if (($line =~ /^\s*(\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/) | 
	($line =~ /^\s*(\d+)\s+(\-*\d+\.\d+)\s+(\-)\s+(\-*\d+\.\d+)/))
    {
#	print STDERR "READ LINE = $line\n";
	$aaIndex                = $1;
	$chemicalShift_N        = $2;
	$chemicalShift_H        = $4;
	print STDOUT "$aaIndex $chemicalShift_H $chemicalShift_N\n";
    }
    else
    {
	print STDERR "line = $line does not match the format.\n";
    }
}


