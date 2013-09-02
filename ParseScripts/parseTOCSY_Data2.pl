#!/usr/bin/perl -w

#usage: ./parseTOCSY_Data2.pl filename 

# given an input (prot) file, parses it to read and write the H chemical shifts.

$inputFile         = "gb1_cyana.prot";
#$inputFile         = "polnAssignedChemicalShifts.html";
#$inputFile         = "hsriAssignedChemicalShifts.htm";
#$outputFile        = "TOCSY.hSRI";

#print STDERR "check out $outputFile\n";
#open (FOUT, ">$outputFile");


open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the bmrb file)");

while ($line = <FIN>)
{
    &parseLine ($line);
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

    if ($line =~ /\s+\d+\s+(\-*\d+\.\d+)\s+\d+\.\d+\s+(\S)\S*\s+(\d+)/)
    {
	$chemicalShift = $1;
	$atomCode      = $2;
	$aaNumber      = $3;

	if (($atomCode eq "H") & ($chemicalShift != 999.000))
	{
	    printf STDOUT "$chemicalShift $chemicalShift 100 $aaNumber\n";
	}
    }
    else
    {
	print STDERR "line = $line does not match the format.\n";
    }
}
