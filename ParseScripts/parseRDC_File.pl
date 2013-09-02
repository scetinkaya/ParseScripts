#!/usr/bin/perl -w

#usage: parseRDC_File.pl filename 

#WARNING (04/07/09). This script does not work for parsing general .mr files
# to print RDCs. Use Njp's script instead.
# given an input file containing RDCs, parses it to read and write the RDCs.


$inputFile         = shift;
$outputFile        = $inputFile.".parsedRDCs";
print STDOUT "check out $outputFile\n";
open (FOUT, ">$outputFile");

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

    if ($line =~ /resid\s+(\d+) and.*\s+(\-*\d+\.\d+)\s+0\.0000\s+0\.0000/)
    {

#	print STDOUT "READ LINE = $line\n";
	$aaCode                = $1;
	$rdc                   = $2;
#	    print STDOUT "atom code = $atomCode, aa = $aaCode, x = $x, y = $y, z = $z\n";
	print FOUT "$aaCode $rdc\n";

    }
    else
    {
	print STDOUT "line = $line does not match the format.\n";
    }
}
