#!/usr/bin/perl -w

#usage: ./parseTOCSY_Data.pl filename 

#$inputFile         = "1C05_chemicalShifts.txt";
#$inputFile         = "polnAssignedChemicalShifts.html";
#$inputFile         = "hsriAssignedChemicalShifts.htm";
#$outputFile        = "TOCSY.hSRI";
$inputFile          = "einChemicalShifts.htm";

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

    if ($line =~ /\s+\d+\s+(\d+)\s\S\S\S\s\S+\s+(\S)\s+(\d+\.\d+)/)
    {
	$atomCode = $2;
	if ($atomCode eq "H")
	{
	    $chemicalShift = $3;
	    $aaNumber      = $1;
	    printf STDOUT "$chemicalShift $chemicalShift 100 $aaNumber\n";
	}
    }
    else
    {
	print STDERR "line = $line does not match the format.\n";
    }
}
