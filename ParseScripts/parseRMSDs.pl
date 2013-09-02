#!/usr/bin/perl -w

#usage: ./parsePDBFile.pl filename 

# given an input (PDB) file, parses it to read and write the H,N coords.


$inputFile         = 'rmsds.txt';


open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");


while ($line = <FIN>)
{
    if ($line =~ /GLOBAL RMS\_D (\d+\.\d+)\;/)
    {
	
	print STDOUT $1."\n";
    }
}
