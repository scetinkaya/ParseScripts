#!/usr/bin/perl -w

#usage: ./generateRunShiftxScript.pl  filenamePrefix 
#prints to STDOUT lines like the following:
#shiftx.linux.bin 1 Coords004300.pdb Coords004300.shiftx

unless (@ARGV)
{
    die("usage: ./generateRunShiftxScript.pl  filenamePrefix\n");
}
$filenamePrefix = shift;


for ($fileIndex = 100; $fileIndex <= 10000; $fileIndex = $fileIndex + 100)
{
    if ($fileIndex < 1000)
    {
	$filename = $filenamePrefix."000$fileIndex";
	print STDOUT "shiftx.linux.bin 1 $filename.pdb $filename.shiftx\n";

    }
    elsif ($fileIndex < 10000)
    {
	$filename = $filenamePrefix."00$fileIndex";
	print STDOUT "shiftx.linux.bin 1 $filename.pdb $filename.shiftx\n";

    }
    elsif ($fileIndex == 10000)
    {
	$filename = $filenamePrefix."010000";
	print STDOUT "shiftx.linux.bin 1 $filename.pdb $filename.shiftx\n";

    }
}

