#!/usr/bin/perl -w

#usage: ./replaceProtonCoords.pl 


$inputFile         = 'extractedProtons.txt';#shift;
$pdbFile         = '1h8c_REF.txt';
$outputFile        = 'protonReplaced1h8c.txt';

#read pdb file

#read parsed proton coordinates, save them in an array.

#if the line is a hydrogen atom,
#  rewrite the header of the line
#  write the corresponding h coords in the right format.
#else
#  rewrite the line as is.
#end


@extractedResidueIDs = ();
@extractedProtonXCoords   = ();
@extractedProtonYCoords   = ();
@extractedProtonZCoords   = ();


open (FOUT, ">$outputFile");

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");

open (PDBFILE, $pdbFile) ||
    die ("couldn't open $pdbFile");

while ($line = <FIN>)
{
    if ($line =~/(\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/)
    {
	push(@extractedResidueIDs, $1);
	push(@extractedProtonXCoords  , $2);
	push(@extractedProtonYCoords  , $3);
	push(@extractedProtonZCoords  , $4);
    }
    else
    {
	print STDERR "error. line = $line does not match the format\n";
    }
}
close(FIN);
printf (STDOUT "read %d proton coords successfully\n",scalar(@extractedResidueIDs));

while ($line = <PDBFILE>)
{
    if ($line =~ /^ATOM\s+\d+\s+H\s+/)
    {
	if ($line =~ /^(.*)\s+(\d+)\s+\-*\d+\.\d+\s+\-*\d+\.\d+\s+\-*\d+\.\d+$/)
	{
	    $beginningOfLine = $1;
	    $resIndex = $2;
	    $found = 0;
	    $numCoords = scalar(@extractedProtonXCoords);
	    for ($i = 0; $i < $numCoords; $i = $i + 1)
	    {
		if ($extractedResidueIDs[$i] == $resIndex)
		{
		    $protonX = $extractedProtonXCoords[$i];
		    $protonY = $extractedProtonYCoords[$i];
		    $protonZ = $extractedProtonZCoords[$i];
		    $found   = 1;
		    last;
		}
	    }
	    if ($found)
	    {
		printf FOUT "%s %d %11.3f %7.3f %7.3f\n", $beginningOfLine, $resIndex, $protonX, $protonY, $protonZ;
		#print FOUT $line;
	    }
	    else
	    {
		#writing all lines with proton coordinates not present in the input model out as well. make sure
		#in rmsd computation to disregard these protons.
		#print FOUT $line; 
	    }
	}
	else
	{
	    print STDERR "error. line = $line does not match the formqt\n";
	}
    }
    else
    {
	#print FOUT $line;
    }
}

