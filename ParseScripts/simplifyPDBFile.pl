#!/usr/bin/perl -w

#usage: ./simplifyPDBFile.pl filename indexOfFirstAA.

# given an input (PDB) file, parses it to read the atom coords.
# writes only the atom coords, skipping everything else.
# I assume HA is the H attached to CA. 



$inputFile         = shift;
if ($inputFile =~ /(.*)\.pdb$/)
  {
      $outputFile = $1.".simplePDB";
      print STDERR "check out $outputFile\n";
      open (FOUT, ">$outputFile");
  }
else
{
    die("error! file should be a pdb file and should finish with .pdb\n");
}

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the pdb file)");


#die( "set prevAAnumber to AA number of the first AA. exiting..\n");
print STDERR  "set prevAAnumber to AA number of the first AA. \n";
$prevAANumber   = shift ||  0; # to determine when to start computing a new 
print STDERR  "currently set to $prevAANumber \n";

#centroid coordinate.
#41 for 1VII

$firstLinePrinted = 0;
#x,y and z coords of the centroid.
while ($line = <FIN>)
{

  if ($line =~ /^ATOM/)
    {
	&parseLine ($line);
    }
  elsif ($line =~ /^TER/)
  {
      exit 0;
  }
}


# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;


    unless ($line =~ /ATOM/)
    {
	die ("line = $line does not start with ATOM!\n");
    }
    
    if ($line =~ /^ATOM\s+\d+\s+(\S+)\s+(\S+)\s+[\S\s]\s+(\-*\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/)
    {

#	print STDERR "READ LINE = $line\n";
	$atomCode              = $1;
	$aaCode                = $2;
	$aaNumber              = $3;
	$x                     = $4;
	$y                     = $5;
	$z                     = $6;


	if ($firstLinePrinted == 0)
	  {
	    print STDERR "first AA # = ".$aaNumber."\n";
	    unless ($prevAANumber == $aaNumber)
	      {
		die("prev AA number != first aa number. change code.\n");
	      }
	    $firstLinePrinted = 1;
	  }
	
	$prevAANumber = $aaNumber;
	
	    
	    #	  print STDERR "atom code = $atomCode, aa = $aaCode, x = $x, y = $y, z = $z\n";
	    #	  if ($atomCode eq "CA")
	    #	    {
	print FOUT "$atomCode $aaCode $aaNumber $x $y $z\n";
	    #	  print STDOUT "$x $y $z\n";
	    #	    }

    }
    else
      {
	print STDERR "line = $line does not match the format.\n";
      }
}
