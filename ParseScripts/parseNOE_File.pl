#!/usr/bin/perl -w

#usage: ./parseNOEFile.pl parsedPDBfilename noeFilename

# given a parsed pdb file containing N,H,CA and HA coordinates and a NOE file, computes the exact distance
# for the specified NOEs and writes the new NOE file with the exact distances.


#read the parsedpdb file

#for each line

#store the coordinates in an array.

#in reading the noe file:

#extract the residue indices, atom names. (eg 19 ha 65 ca)

#compute the exact distance from the coresonding array

#rewrite the NOE info to a new file.


#put these coordinates into an array, access with the index of residue.

#   eg N_x[$residueIndex] = ..; N_y[$residueIndex] = ..; etc.

#-------------------------------------------



#read the NOE file.

#skip the first two lines, make sure one has 'reidusenot' and the other tdoes not have anything.

#read the pdb file

#read each line

#extract the residue indices, atom names. (eg 19 ha 65 ca)

#go to the pdb file to get the atom coordinates

#cmpute the exact distance

#write the new noe data to the file.


$firstAminoAcidIndex   = 0;
$parsedPdbFile         = shift;
$noeFilename           = shift;

if ($parsedPdbFile =~ /(.*)\.parsedPDB$/)
  {
#      $outputFile = $1.".exactNOEs";
#      print STDERR "check out $outputFile\n";
#      open (FOUT, ">$outputFile");
  }
else
{
    die("error! file should be a parsedPDB file and should finish with .parsedPDB\n");
}

open (FIN_parsedPDB_File, $parsedPdbFile) || 
    die ("couldn't open $parsedPdbFile (should be the pdb file)");


@NCoord_x  = ();@NCoord_y  = ();@NCoord_z  = ();
@HCoord_x  = ();@HCoord_y  = ();@HCoord_z  = ();
@HACoord_x = ();@HACoord_y = ();@HACoord_z = ();
@CACoord_x = ();@CACoord_y = ();@CACoord_z = ();

while ($line = <FIN_parsedPDB_File>)
{
#    if ($line =~ /^(\S+) (\d+) (\-*\d+\.\d+) (\-*\d+\.\d+) (\-*\d+\.\d+)/)
    if ($line =~ /^(\S+) (\S+) (\d+) (\-*\d+\.\d+) (\-*\d+\.\d+) (\-*\d+\.\d+)/)
    {
	&parsePdbFileLine ($1,$2,$3,$4,$5,$6);
    }
    else
    {
	die ("$line does not match the format");
    }
}

open (FIN_NOE, $noeFilename) || die("couldn't open $noeFilename");

while ($line = <FIN_NOE>)
{
    if ($line =~ /^(\d+) (\S+) (\d+) (\S+)/)
    {
	@retArray  = &parseNoeFileLine ($line);
	$aa1Index  = $retArray[0];
	$atom1Type = $retArray[1];
	$aa2Index  = $retArray[2];
	$atom2Type = $retArray[3];
	$exactDistance =  &computeExactDistance ($aa1Index, $atom1Type, $aa2Index, $atom2Type);
#	print FOUT "$aa1Index $atom1Type $aa2Index $atom2Type $exactDistance $exactDistance\n";
	$lowerBoundDistance = $exactDistance - 1.0;
	$upperBoundDistance = $exactDistance + 1.0;
	printf STDOUT "%d %s %d %s %7.1f %7.1f\n", $aa1Index,$atom1Type,$aa2Index,$atom2Type,$lowerBoundDistance,$upperBoundDistance;
    }
    else
    {
	die ("$line does not match the format");
    }
}


sub parsePdbFileLine 
{
    my $atomType              = shift;
    my $aaType                = shift;
    my $aaIndex               = shift;
    my $x                     = shift;
    my $y                     = shift;
    my $z                     = shift;
	
    if ($firstAminoAcidIndex == 0)
    {
	$firstAminoAcidIndex = $aaIndex;
    }
    
    if ($atomType eq "N")
    {
	$NCoord_x[$aaIndex-$firstAminoAcidIndex]  = $x;
	$NCoord_y[$aaIndex-$firstAminoAcidIndex]  = $y;
	$NCoord_z[$aaIndex-$firstAminoAcidIndex]  = $z;
    }
    elsif ($atomType eq "H")
    {
	$HCoord_x[$aaIndex-$firstAminoAcidIndex]  = $x;
	$HCoord_y[$aaIndex-$firstAminoAcidIndex]  = $y;
	$HCoord_z[$aaIndex-$firstAminoAcidIndex]  = $z;
    }
    elsif ($atomType eq "HA") 
    {
	$HACoord_x[$aaIndex-$firstAminoAcidIndex] = $x;
	$HACoord_y[$aaIndex-$firstAminoAcidIndex] = $y;
	$HACoord_z[$aaIndex-$firstAminoAcidIndex] = $z;
    }
    elsif ($atomType eq "CA") 
    {
	$CACoord_x[$aaIndex-$firstAminoAcidIndex] = $x;
	$CACoord_y[$aaIndex-$firstAminoAcidIndex] = $y;
	$CACoord_z[$aaIndex-$firstAminoAcidIndex] = $z;
    }
    else
    {
	print STDERR "skipping atom type $atomType \n";
    }
}

sub parseNoeFileLine 
{
    my $line = shift;

    if ($line =~ /^(\d+)\s+(\S+)\s+(\d+)\s+(\S+)/)
    {
	$aa1Index              = $1;
	$atom1Type             = $2;
	$aa2Index              = $3;
	$atom2Type             = $4;
    }
    else
    {
	die ("line = $line does not match the format.\n");
#	print STDERR "line = $line does not match the format.\n";
    }
    my @retArray = ($aa1Index, $atom1Type, $aa2Index, $atom2Type);
    return @retArray;
}

# returns	$exactDistance
sub computeExactDistance 
{
    my $aa1Index  = shift;
    my $atom1Type = shift;
    my $aa2Index  = shift;
    my $atom2Type = shift;

    @coord1 = extractCoords ($aa1Index, $atom1Type);
    
    @coord2 = extractCoords ($aa2Index, $atom2Type);
    
    $exactDistanceSqr = 0;
    
    for ($i = 0; $i < 3; $i = $i + 1)
    {
	$exactDistanceSqr = $exactDistanceSqr + ($coord1[$i] - $coord2[$i]) * ($coord1[$i] - $coord2[$i]);
    }
    
    $exactDistance = sqrt($exactDistanceSqr);
}

#returns x,y,z stored in @coord.
sub extractCoords 
{
    $aaIndex  = shift;
    $atomType = shift;

    my @coord = ();
    if ($atomType eq "N")
    {
	push (@coord, $NCoord_x[$aaIndex-$firstAminoAcidIndex]); 
	push (@coord, $NCoord_y[$aaIndex-$firstAminoAcidIndex]); 
	push (@coord, $NCoord_z[$aaIndex-$firstAminoAcidIndex]); 
    }
    elsif (($atomType eq "HN") || ($atomType eq "H"))
    {
	push (@coord, $HCoord_x[$aaIndex-$firstAminoAcidIndex]); 
	push (@coord, $HCoord_y[$aaIndex-$firstAminoAcidIndex]); 
	push (@coord, $HCoord_z[$aaIndex-$firstAminoAcidIndex]); 
    }
    elsif ($atomType eq "HA") 
    {
	push (@coord, $HACoord_x[$aaIndex-$firstAminoAcidIndex]); 
	push (@coord, $HACoord_y[$aaIndex-$firstAminoAcidIndex]); 
	push (@coord, $HACoord_z[$aaIndex-$firstAminoAcidIndex]); 
    }
    elsif ($atomType eq "CA") 
    {
	push (@coord, $CACoord_x[$aaIndex-$firstAminoAcidIndex]);
	push (@coord, $CACoord_y[$aaIndex-$firstAminoAcidIndex]);
	push (@coord, $CACoord_z[$aaIndex-$firstAminoAcidIndex]);
    }
    else
    {
	die("atom type $atomType is wrong\n");
    }
    return @coord;
}
