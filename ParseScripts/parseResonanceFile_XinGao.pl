#!/usr/bin/perl -w

#usage: ./parseResonanceFile_XinGao.pl filename 

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

    if ($line =~ /^\?\-\? (\d+\.*\d*)\s+(\d+\.\d+)/)
    {
#	print STDERR "READ LINE = $line\n";
	$hChemicalShift         = $2;
	$nChemicalShift         = $1;
	
	print STDOUT "$nChemicalShift $hChemicalShift\n";
    }
    else
    {
	print STDERR "line = $line does not match the format.\n";
    }
}


