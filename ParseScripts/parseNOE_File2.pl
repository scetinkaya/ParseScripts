#!/usr/bin/perl -w

#usage: ./parseNOEFile2.pl noeFilename

#given an NOE file, simply extracts the indices of the residues which have an NOE between them.

$noeFilename           = shift;

open (FIN_NOE, $noeFilename) || die("couldn't open $noeFilename");

while ($line = <FIN_NOE>)
{
#reads lines of the form assign (resid     2  and name       HN)   (resid     2 and name     HA)      1.8   0.0  3.0009481834913454
    if (($line =~ /resid\s+(\d+).+HN.+resid\s+(\d+).+HN/) | ($line =~ /resid\s+(\d+).+HA.+resid\s+(\d+).+HN/) | (($line =~ /resid\s+(\d+).+HN.+resid\s+(\d+).+HA/)) | (($line =~ /resid\s+(\d+).+HA.+resid\s+(\d+).+HA/)))
    {
	$aa1Index  = $1;
	$aa2Index  = $2;
	printf STDOUT "%d %d\n", $aa1Index,$aa2Index;
    }
    else
    {
#	printf STDERR "$line\n";# does not match the format\n";
    }
}


