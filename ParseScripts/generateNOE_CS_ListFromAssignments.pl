#!/usr/bin/perl -w

#usage: ./generateNOE_CS_ListFromAssignments.pl 

#obtained and modified from parseNOE_File2.pl and parseResonanceFile.pl
#given an NOE file, simply extracts the indices of the residues which have an NOE between them.
#and then finds the corresponding chemical shift values and prints them.
#e.g., if the NOE is between residue 2 HN and resdue 63 HA, it will print the chemical shift values
#of residues 2 HN, residue 2 N, and residue 63 HA.

$chemicalShiftListFilename = "chemicalShiftList.txt";
$noeFilename               = "NOE_Source.txt";

open (FIN_NOE, $noeFilename)                   || die("couldn't open $noeFilename");
open (FIN_CS_LIST, $chemicalShiftListFilename) || die("couldn't open $chemicalShiftListFilename");


@chemicalShiftsN  = ();
@chemicalShiftsHN = ();
@chemicalShiftsHA = ();
$numAAs           =  0;
$maxNumAAs        = 1000; #used in initializing the arrays

&initializeArrays;



while ($line = <FIN_CS_LIST>)
{
    if ($line =~ /(\d+)\s(\-*\d+\.\d+)\s(\-*\d+\.\d+)\s(\-*\d+\.\d+)/) 
    {
	$aaIndex = $1;
	$chemicalShiftN = $2;
	$chemicalShiftHN = $3;
	$chemicalShiftHA = $4;
	$chemicalShiftsN[$aaIndex]  = $chemicalShiftN;
	$chemicalShiftsHN[$aaIndex] = $chemicalShiftHN;
	$chemicalShiftsHA[$aaIndex] = $chemicalShiftHA;
	if ($aaIndex > $maxNumAAs)
	{
	    die("numAAs=$numAAs is greater than maxNumAAs= $maxNumAAs");
	}
    }
    else
    {
	die("line = $line does not match format.\n");
    }
}

while ($line = <FIN_NOE>)
{
#reads lines of the form assign (resid     2  and name       HN)   (resid     2 and name     HA)      1.8   0.0  3.0009481834913454
    if ($line =~ /resid\s+(\d+).+HN.+resid\s+(\d+).+HN/) 
    {
	$aa1Index  = $1;
	$aa2Index  = $2;
	printf STDOUT "%d %d\n", $aa1Index,$aa2Index;
	printf STDOUT "%f %f %f\n", $chemicalShiftsN[$aa1Index],$chemicalShiftsHN[$aa1Index], $chemicalShiftsHN[$aa2Index];
	printf STDOUT "%f %f %f\n", $chemicalShiftsN[$aa2Index],$chemicalShiftsHN[$aa2Index], $chemicalShiftsHN[$aa1Index];
    }
    elsif  ($line =~ /resid\s+(\d+).+HA.+resid\s+(\d+).+HN/) 
    {
	$aa1Index  = $1;
	$aa2Index  = $2;
	printf STDOUT "%d %d\n", $aa1Index,$aa2Index;
	printf STDOUT "%f %f %f\n", $chemicalShiftsN[$aa2Index],$chemicalShiftsHN[$aa2Index], $chemicalShiftsHA[$aa1Index];
    }
    elsif  ($line =~ /resid\s+(\d+).+HN.+resid\s+(\d+).+HA/) 
    {
	$aa1Index  = $1;
	$aa2Index  = $2;
	printf STDOUT "%d %d\n", $aa1Index,$aa2Index;
	printf STDOUT "%f %f %f\n", $chemicalShiftsN[$aa1Index],$chemicalShiftsHN[$aa1Index], $chemicalShiftsHA[$aa2Index];
    } 
    elsif  ($line =~ /resid\s+(\d+).+HA.+resid\s+(\d+).+HA/) 
    {
	# don't use HA HA NOEs.
    }
    else
    {
#	printf STDERR "$line\n";# does not match the format\n";
    }
}



sub initializeArrays()
{
    my $i;
    my $negativeChemicalShift = -1;

    for ($i = 0; $i <= $maxNumAAs; $i++)
    {
#	push @aaNames,$emptyString;
	push @chemicalShiftsN,$negativeChemicalShift;
	push @chemicalShiftsHN,$negativeChemicalShift;
	push @chemicalShiftsHA,$negativeChemicalShift;
    }
}
