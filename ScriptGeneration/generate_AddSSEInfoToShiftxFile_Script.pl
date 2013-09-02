#!/usr/bin/perl -w


This is now obsolete as AddSSEInfoToShiftxFile_Script.pl is obsolete.
#usage: ./generate_AddSSEInfoToShiftxFile_Script.pl

#prints to STDOUT the following type of output:
#cd Mode7
#~/Mist/Scripts/parseSHIFTXFile.pl Mode7.Model6.shiftx Mode7.Model6.parsed.shiftx

for ($modeIndex = 7; $modeIndex <= 11; $modeIndex ++)
{
    print STDOUT "cd Mode$modeIndex\n";
    for ($i = 1; $i <= 11; $i++)
    {
	print STDOUT "~/Mist/Scripts/parseSHIFTXFile.pl Mode$modeIndex.Model$i.shiftx Mode$modeIndex.Model$i.parsed.shiftx\n";
    }
    print STDOUT "cd ..\n";
}
