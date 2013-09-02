#!/usr/bin/perl -w

#usage: ./generateRunStrideScript.pl 





for ($fileIndex = 100; $fileIndex <= 10000; $fileIndex = $fileIndex + 100)
{
    if ($fileIndex < 1000)
    {
	print STDOUT "/net/mist/apaydin/Tools/Stride/stride -h Pdb/Coords000$fileIndex.pdb > Pdb/Coords000$fileIndex.stride\n";
    }
    elsif ($fileIndex < 10000)
    {
	print STDOUT "/net/mist/apaydin/Tools/Stride/stride -h Pdb/Coords00$fileIndex.pdb > Pdb/Coords00$fileIndex.stride\n";
    }
    elsif ($fileIndex == 10000)
    {
	print STDOUT "/net/mist/apaydin/Tools/Stride/stride -h Pdb/Coords010000.pdb > Pdb/Coords010000.stride\n";
    }
}
