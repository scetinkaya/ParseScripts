#!/usr/bin/perl -w

#usage: ./parsePDBFile.pl filename 

# given an input (PDB) file, parses it to read and write the H,N,HA and CA coords.


$inputFile         = shift;
if ($inputFile =~ /(.*)\.pdb$/)
#if ($inputFile =~ /(.*)\.coor$/)
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

    if (($line =~ /^ATOM/) || ($line =~ /^HETATM/))
    {
	
	&parseLine ($line);
    }
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

    if ($line =~ /^ATOM\s+\d+\s+(\S+)\s+(\S\S\S)[\s\+][\S\s]\s+(\-*\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/)
#    if ($line =~ /^ATOM\s+\d+\s+(\S+)\s+(\S\S\S)[\+]*[\S\s]\s+(\-*\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/)
    {

#	print STDERR "READ LINE = $line\n";
	$atomCode              = $1;
	$aaCode                = $2;
	$aaNumber              = $3;
	$x                     = $4;
	$y                     = $5;
	$z                     = $6;

#	$aaNumber              = $aaNumber - 78; #for 1CMZ

#	print STDERR "substracted 78 from the AA number for 1CMZ.\n";


	if (&writeAtom($atomCode))
	{
#	    print STDERR "atom code = $atomCode, aa = $aaCode, x = $x, y = $y, z = $z\n";
	    print FOUT "$atomCode $aaCode $aaNumber $x $y $z\n";
	}
    }
    elsif ($line =~ /^HETATM\s+\d+\s+(\S+)\s+(\S\S\S)[\s\+][\S\s]\s+(\-*\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/) 
    {
	$atomCode              = $1;
	$aaCode                = $2;
	$aaNumber              = $3;
	$x                     = $4;
	$y                     = $5;
	$z                     = $6;

	
	if (&writeAtom($atomCode))
	{
#	    print STDERR "atom code = $atomCode, aa = $aaCode, x = $x, y = $y, z = $z\n";
	    print FOUT "$atomCode $aaCode $aaNumber $x $y $z\n";
	}
    }
    else
    {
#	print STDERR "line = $line does not match the format.\n";
    }
}

# if atom code is "H" or "H1", returns 1, o.w. returns 0;

sub writeAtom
{
    my $atomCode = shift;
    my $retval   = 1;
    

#   unless (($atomCode eq "H") || ($atomCode eq "N") || ($atomCode eq "CA") || ($atomCode eq "HA")) 
#    unless (($atomCode eq "H"))# || ($atomCode eq "N"))
#    unless (($atomCode eq "CA"))# || ($atomCode eq "N"))
    unless (($atomCode eq "H") || ($atomCode eq "H1"))
    {
	$retval = 0;
    }
    
    $retval;
}
