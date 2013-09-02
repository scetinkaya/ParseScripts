#!/usr/bin/perl -w

$parsedPdbFileList = `ls Mode*.parsedPDB`;

if ($parsedPdbFileList)
{
    @parsedPdbFiles = split /^/m, $parsedPdbFileList;
    foreach $parsedPdbFile (@parsedPdbFiles)
    {
	chop($parsedPdbFile);
#	print `head -2860 $parsedPdbFile > firstModel.$parsedPdbFile`;
	print `head -76 $parsedPdbFile > firstModel.$parsedPdbFile`;
    }
}

