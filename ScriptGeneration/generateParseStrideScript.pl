#!/usr/bin/perl -w

#usage: ./generateRunStrideScript.pl 


for ($fileIndex = 100; $fileIndex <= 10000; $fileIndex = $fileIndex + 100)
{
    if ($fileIndex < 1000)
    {
	print STDOUT "parseStrideOutput.pl ModelDataGeneration/StrideFiles/Raw/Coords000$fileIndex.stride > ModelDataGeneration/StrideFiles/Parsed/Coords000$fileIndex.stride.parsed\n";
    }
    elsif ($fileIndex < 10000)
    {
	print STDOUT "parseStrideOutput.pl ModelDataGeneration/StrideFiles/Raw/Coords00$fileIndex.stride > ModelDataGeneration/StrideFiles/Parsed/Coords00$fileIndex.stride.parsed\n";
    }
    elsif ($fileIndex == 10000)
    {
	print STDOUT "parseStrideOutput.pl ModelDataGeneration/StrideFiles/Raw/Coords010000.stride> ModelDataGeneration/StrideFiles/Parsed/Coords010000.stride.parsed\n";
    }
}
