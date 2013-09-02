#!/usr/bin/perl -w

#usage: ./generateParsePDBFileScript.pl filenamePrefix 
#e.g., ./generateParsePDBFileScript.pl 1ESR_REF
#for files such as 1ESR_REF_froda_010000.pdb.

unless (@ARGV)
{
    die("usage: ./generateParsePDBFileScript.pl  filenamePrefix\n");
}

$filenamePrefix = shift;
#prints to STDOUT the following:

for ($fileIndex = 100; $fileIndex <= 10000; $fileIndex = $fileIndex + 100)
{
    if ($fileIndex < 1000)
    {
	print STDOUT "parsePDBFile.pl ".$filenamePrefix."_froda_000$fileIndex.pdb\n";
    }
    elsif ($fileIndex < 10000)
    {
	print STDOUT "parsePDBFile.pl ".$filenamePrefix."_froda_00$fileIndex.pdb\n";
    }
    elsif ($fileIndex == 10000)
    {
	print STDOUT "parsePDBFile.pl ".$filenamePrefix."_froda_010000.pdb\n";
    }
}
