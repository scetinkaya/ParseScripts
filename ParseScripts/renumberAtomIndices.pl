#!/usr/bin/perl -w

#usage: ./parsePDBFile.pl filename

# given an input (PDB) file, renumbers it so that the first atom is 
# labeled #1. Warning! Check the TER line which is not checked now.

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

die("don't forget to check the TER LINE after running. Uncomment this to run this script.");

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the pdb file)");

$aaIndexOffset = -1000;
$firstAtomIndexPrinted = 0;

while ($line = <FIN>)
{
    &renumberLine ($line);
}


# the line contains the coordinate info, which will be printed.
sub renumberLine 
{
    my $line           = shift;

    if ($line =~ /^(ATOM)\s+(\d+)(.*)/)
    {
	print STDOUT "READ LINE = $line\n";
	$beginningOfLine   = $1;
	$atomIndex         = $2;
	$restOfLine        = $3;
	if ($firstAtomIndexPrinted == 0)
	{
	    $firstAtomIndexPrinted = 1;
	    print STDOUT "first atom is indexed $atomIndex\n";
	    $atomIndexOffset = $atomIndex - 1;
	}

	if ($atomIndexOffset < 0)
	{
	    die("atomIndexOffset = $atomIndexOffset, line = $line, variables read were: $1 $2 $3\n");
	}

	$newAtomIndex = $atomIndex - $atomIndexOffset;
	print FOUT $beginningOfLine."\t";
	$middleOfLine = sprintf "%3d", $newAtomIndex;
	print FOUT $middleOfLine.$restOfLine."\n";
    }
    else
      {
	  print FOUT $line;
      }
}
