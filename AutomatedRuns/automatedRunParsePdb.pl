#!/usr/bin/perl -w

$pdbFileList = `ls *.pdb`;

if ($pdbFileList)
{
    @pdbFiles = split /^/m, $pdbFileList;
    foreach $pdbFile (@pdbFiles)
    {
	`parsePDBFile.pl $pdbFile`;
    }
}

