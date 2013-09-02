#!/usr/bin/perl -w

#usage: ./parseNOEFile3.pl noeFilename

#given an NOE file, simply extracts the indices of the residues which have an NOE between them as well as their atom codes. This is to be used with parseNOE_File.pl.

$noeFilename           = shift;

open (FIN_NOE, $noeFilename) || die("couldn't open $noeFilename");

while ($line = <FIN_NOE>)
{
    if ($line =~ /resid\s+(\d+).+HN.+resid\s+(\d+).+HN/)
    {
	$aa1Index  = $1;
	$aa2Index  = $2;
	print STDOUT $aa1Index." HN ".$aa2Index." HN\n";
    }
    elsif ($line =~ /resid\s+(\d+).+HA.+resid\s+(\d+).+HN/) 
    {
	$aa1Index  = $1;
	$aa2Index  = $2;
	print STDOUT $aa1Index." HA ".$aa2Index." HN\n";
    }
    elsif ($line =~ /resid\s+(\d+).+HN.+resid\s+(\d+).+HA/)
    {
	$aa1Index  = $1;
	$aa2Index  = $2;
	print STDOUT $aa1Index." HN ".$aa2Index." HA\n";
    }
    elsif ($line =~ /resid\s+(\d+).+HA.+resid\s+(\d+).+HA/)
    {
	$aa1Index  = $1;
	$aa2Index  = $2;
	print STDOUT $aa1Index." HA ".$aa2Index." HA\n";
    }
    else
    {
#	printf STDERR "$line\n";# does not match the format\n";
    }
}


