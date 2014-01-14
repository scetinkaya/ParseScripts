#!/usr/bin/perl -w

#usage: ./parseResonanceFile.pl filename 

# given a resonance file, parses it to read and write the H,N chemical shifts
#currently adapted for LW_ubq.prot

$inputFile         = shift;

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");

@chemicalShiftsN  = ();
@chemicalShiftsHN = ();
@chemicalShiftsHA = ();
$numAAs           =  0;
$maxNumAAs        = 1000; #used in initializing the arrays

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


#    if ($line =~ /^\s*(\d+)\s+(\-*\d+\.\d+)\s+\d+\.\d+\s+(\S+)\s+(\d+)/)
    if ($line =~ /^\s*\d+\s+(\d+)\s+(\S\S\S)\s+(\S+)\s+\S\s+(\-*\d+\.\d+)/)
    {
#	print STDERR "READ LINE = $line\n";

	$aaIndex               = $1;
	$atomName              = $3;
	$chemicalShift         = $4;

#want to read lines of the form 
#2    19    PRO    HA    H    4.12   0.01   1

	if ($atomName eq "N")
	{
#	    print STDOUT "$aaIndex $aaName $chemicalShift ";
#	    $aaNames[$aaIndex]         = $aaName;
	    $chemicalShiftsN[$aaIndex] = $chemicalShift;
	    if ($aaIndex > $maxNumAAs)
	    {
		die("numAAs=$numAAs is greater than maxNumAAs = $maxNumAAs");
	    }
	}
	elsif (($atomName eq "H") ||  ($atomName eq "HN"))
	{
#	    print STDOUT "$chemicalShift \n";
#	    $aaNames[$aaIndex]         = $aaName;
	    $chemicalShiftsHN[$aaIndex] = $chemicalShift;
	    if ($aaIndex > $maxNumAAs)
	    {
		die("numAAs=$numAAs is greater than maxNumAAs= $maxNumAAs");
	    }
	}
	elsif ($atomName eq "HA")
	{
#	    print STDOUT "$chemicalShift \n";
#	    $aaNames[$aaIndex]         = $aaName;
	    $chemicalShiftsHA[$aaIndex] = $chemicalShift;
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
	if (($chemicalShiftsN[$i] != -1) && ($chemicalShiftsHN[$i] != -1) && ($chemicalShiftsHA[$i] != -1) )
	{
	    print STDOUT "$i $chemicalShiftsN[$i] $chemicalShiftsHN[$i] $chemicalShiftsHA[$i]\n";
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
#	push @aaNames,$emptyString;
	push @chemicalShiftsN,$negativeChemicalShift;
	push @chemicalShiftsHN,$negativeChemicalShift;
	push @chemicalShiftsHA,$negativeChemicalShift;
    }
}
