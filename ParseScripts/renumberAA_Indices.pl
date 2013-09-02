#!/usr/bin/perl -w

#usage: ./renumberPdbFile.pl filename 

#substracts 11 from the amino acid indices and rewrites the coordinates to the file $pdbPrefix.renumberedPDB where the $pdbPrefix is the PDB ID.

$inputFile         = shift;
if ($inputFile =~ /(.*)\.pdb$/)
  {
      $outputFile = $1.".renumberedPDB";
      print STDERR "check out $outputFile\n";
      open (FOUT, ">$outputFile");
  }
else
{
    die("error! file should be a pdb file and should finish with .pdb\n");
}

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the pdb file)");


while ($line = <FIN>)
{

    if ($line =~ /^ATOM/)
    {
	
	&parseLine ($line);
    }
    else
    {
	print FOUT $line;
    }
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

#    if ($line =~ /^ATOM\s+(\d+)\s+(\S+)\s+(\S\S\S)([\s\+][\S\s])\s+(\-*\d+)(.*)/)
    if ($line =~ /^ATOM(\s+)(\d+)(\s+)(\S+)(\s+)(\S\S\S)([\s\+][\S\s])(\s+)(\-*\d+)(.*)/)
    {
#	print STDERR "READ LINE = $line\n";
#	$space1                = $1;
	$atomIndex             = $2;
	$atomIndex             = $2 - 118;
	$space2                = $3;
	$atomName              = $4;
        $space3                = $5;
	$aaName                = $6;
	$chainID               = $7;
#	$space4                = $8;
	$aaNumber              = $9;
	$theRest               = $10;
	$aaNumber              = $aaNumber + 67; #mapping index 12 to index 79
	
	if (($aaNumber >= 79) & ($aaNumber <= 206))
	{
#	printf (FOUT "%s \n", $atomName);
	    printf (FOUT "ATOM   %4d%s%s%s%s%s %3d%s\n", $atomIndex,$space2,$atomName,$space3,$aaName,$chainID,$aaNumber,$theRest);# $2 $3 $4 $aaNumber $theRest\n";
	}
#	printf (FOUT "ATOM   %4d", $atomIndex);# $2 $3 $4 $aaNumber $theRest\n";
#	print (FOUT, "ATOM    %4d  %s $1 $2 $3 $4 $aaNumber $theRest\n";

#	if (length($atomName) <= 3)
#	{
#	    printf (FOUT "  ");
#	}
#	else
#	{
#	    printf (FOUT " ");
#	}
#	printf(FOUT "%s\n", $atomName);

    }
    else
    {
	print STDOUT "line = $line does not match the format.\n";
    }
}
