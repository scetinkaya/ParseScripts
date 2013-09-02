#!/usr/bin/perl -w

#usage: ./parseResonanceFile.pl filename 

# given a resonance file, parses it to read and write the H,N chemical shifts


$inputFile         = shift;

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");

@aaNames         = ();
@chemicalShiftsN = ();
@chemicalShiftsH = ();
$numAAs          =  0;
$maxNumAAs       = 1000; #used in initializing the arrays

&initializeArrays;

while ($line = <FIN>)
{
  &parseLine($line);
}

&printArrays;

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;


#I think this is supposed to match lines like:
#      1   1 MET HA   H   4.20 0.03 1 


#    if ($line =~ /^ATOM\s+\d+\s+(\S+)\s+(\S\S\S)\s+[\+]*[\S\s]\s+(\-*\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/)

    

    if ($line =~ /^\s*\d+\s+(\d+)\s+(\w\w\w)\s+(\w+)\s+\w\s+(\-*\d+\.\d+)/)
#    if ($line =~ /^\s*\d+\s+(\-*\d+\.\d+)\s+\-*\d+\.\d+\s+(\w+)\s+(\d+)/)
    {
#	print STDERR "READ LINE = $line\n";
	$aaIndex                = $1;
	$aaName                 = $2;
	$atomName               = $3;
	$chemicalShift          = $4;

	if ($atomName eq "N")
	{
#	    print STDOUT "$aaIndex $aaName $chemicalShift ";
	    $aaNames[$aaIndex]         = $aaName;
	    $chemicalShiftsN[$aaIndex] = $chemicalShift;
	    if ($aaIndex > $maxNumAAs)
	    {
		die("numAAs=$numAAs is greater than maxNumAAs = $maxNumAAs");
	    }
	}
	elsif (($atomName eq "H") ||  ($atomName eq "HN"))
	{
#	    print STDOUT "$chemicalShift \n";
	    $aaNames[$aaIndex]         = $aaName;
	    $chemicalShiftsH[$aaIndex] = $chemicalShift;
	    if ($aaIndex > $maxNumAAs)
	    {
		die("numAAs=$numAAs is greater than maxNumAAs= $maxNumAAs");
	    }
	}
    }
    else
    {
#	print STDERR "line = $line does not match the format.\n";
    }
}


sub printArrays
{
    my $i;
    for ($i = 0; $i <= $maxNumAAs; $i++)
    {
	if (($chemicalShiftsN[$i] != -1) && ($chemicalShiftsH[$i] != -1))
	{
	    print STDOUT "$i $chemicalShiftsN[$i] $chemicalShiftsH[$i]\n";
	}
    }
}

sub initializeArrays()
{
    my $i;
    my $emptyString = "";
    my $negativeChemicalShift = -1;

    for ($i = 0; $i <= $maxNumAAs; $i++)
    {
	push @aaNames,$emptyString;
	push @chemicalShiftsN,$negativeChemicalShift;
	push @chemicalShiftsH,$negativeChemicalShift;
    }
}
