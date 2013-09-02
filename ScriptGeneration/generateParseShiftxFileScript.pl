#!/usr/bin/perl -w

#usage: ./generateParseShiftxFileScript.pl > myParseShiftxFileScript

#prints to STDOUT lines like  the following:

# ~/Mist/Scripts/parseSHIFTX_File.pl MySHIFTX.1200 MySHIFTX.1200.parsed

for ($coordIndex = 100; $coordIndex <= 10000; $coordIndex += 100)
{
    print STDOUT "~/Mist/Scripts/parseSHIFTX_File.pl MySHIFTX.$coordIndex MySHIFTX.$coordIndex.parsed\n";
}

