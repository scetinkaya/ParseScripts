#!/usr/bin/perl -w

#usage: ./parsePDBFile.pl filename

# given an input (PDB) file, parses it to read the atom coords.
# only writes N, CA, C', O coordinates.

$inputFile         = shift;
if ($inputFile =~ /(.*)\.pdb$/)
  {
      $outputFile = $1.".parsedPDB";
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
    &parseLine ($line);
}


# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

    if ($line =~ /^ATOM\s+\d+\s+(\S+)\s+/)
    {
#	print STDERR "READ LINE = $line\n";
	$atomCode              = $1;
	
	if (&writeAtom($atomCode))
	{
	    #print FOUT "$atomCode $aaCode $aaNumber $x $y $z\n";
	    print FOUT "$line";
	}
	else
	{
	    print STDERR "atom code = $atomCode, NOT WRITING.\n";
	}
    }
    else
      {
	  print FOUT $line;
      }
  }

# if atom code is not of the ones to be outputted, returns 0;
# otherwise, returns the atom code.
# the recognized atoms are N, CA, C, O.

sub writeAtom
{
    my $atomCode = shift;
    my $retval   = 1;
    
#    unless (($atomCode eq "CA") || ($atomCode eq "N") || 
#	    ($atomCode eq "O")  || ($atomCode eq "C") )
    unless ($atomCode eq "CA")
    {
	$retval = 0;
    }
    
    $retval;
}
