#!/usr/bin/perl -w

#usage: ./findAmbiguousNOEList.pl 

#reads the NOE raw CS List and the CS corresponding to every residue and then determines for which NOE which residue indices may correspond to it.


$chemicalShiftListFilename = "chemicalShiftList.txt";
$noeFilename               = "rawBackboneNOE_CS_List.txt";

open (FIN_NOE, $noeFilename)                   || die("couldn't open $noeFilename");
open (FIN_CS_LIST, $chemicalShiftListFilename) || die("couldn't open $chemicalShiftListFilename");


@chemicalShiftsN  = ();
@chemicalShiftsHN = ();
@chemicalShiftsHA = ();
$numAAs           =  0;
$maxNumAAs        = 1000; #used in initializing the arrays
$N_EPSILON        = 0.5;
$H_EPSILON        = 0.05;

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

$numAAs = $aaIndex;
print STDOUT "read $numAAs amino acids.\n";

while ($line = <FIN_NOE>)
{
#reads lines of the form assign (resid     2  and name       HN)   (resid     2 and name     HA)      1.8   0.0  3.0009481834913454
    if ($line =~ /(\d+\.\d+)\s(\d+\.\d+)\s(\d+\.\d+)/) 
    {
	$N_CS   = $1;
	$HN_CS  = $2;
	$H3_CS  = $3;
#	Printf STDOUT "%d %d\n", $aa1Index,$aa2Index;
	&printCloseResidueIndices($N_CS, $HN_CS, $H3_CS);
    }
    else
    {
	die("$line does not match the format\n";
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
sub  findCloseHN_Pairs
{
    my $N_CS  = shift;
    my $HN_CS = shift;
    my $i;
    my @retval;

    for ($i = 0; $i < $numAAs; $i++)
    {
	if ((abs($N_CS-$chemicalShiftsN[$i])< $N_EPSILON) && (abs($H_CS - $chemicalShiftsH[$i]) < $H_EPSILON))
	{
	    push (@retval, $i);
	}
    }

    return @retval;
}

sub findCloseH_Atoms
{
    my $H3_CS = shift;
    my @retval;
    my $i;

    for ($i = 0; $i < $numAAs; $i++)
    {
	if ((abs($H3_CS-$chemicalShiftsH[$i])< $H_EPSILON) || (abs($H3_CS - $chemicalShiftsHA[$i]) < $H_EPSILON))
	{
	    push (@retval, $i);
	}
    }

    return @retval;
} 

sub printCloseResidueIndices
{
    my $i, $j;
    my $N_CS  = shift;
    my $HN_CS = shift;
    my $H3_CS = shift;
    @closeHN_Pairs = findCloseHN_Pairs($N_CS, $HN_CS);
    @closeH3_Atoms = findCloseH_Atoms ($H3_CS);

#    for each element in close hn pairs
#      for each element in close h3 atoms
#        print the corresponding indices to stdout as a potential noe between those residues. 
    $numberOfCloseHN_Pairs = @closeHN_Pairs;
    $numberOfCloseH3_Atoms = @closeH3_Atoms;

    for ($i = 0; $i < $numberOfCloseHN_Pairs; $i++)
    {
	for ($j = 0; $j < $numberOfCloseH3_Atoms; $j++)
	{
	    print STDOUT "$closeHN_Pairs[$i] $closeH3_Atoms[$j]\n"
	}
    }
}
