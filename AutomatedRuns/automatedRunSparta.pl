#!/usr/bin/perl -w

$pdbFileList = `ls *.pdb.gz`;

#$pdbFileList = `ls *.pdb`;

if ($pdbFileList)
{
    @pdbFiles = split /^/m, $pdbFileList;
    foreach $pdbFile (@pdbFiles)
    {
	if ($pdbFile =~ /(.*)\.pdb.gz/)
	{
	    `gunzip $pdbFile`;
	    `sparta+ -in $1.pdb`;
	    `mv pred.tab pred.tab.$1`;
	    `mv struct.tab struct.tab.$1`;
	}
	elsif ($pdbFile =~ /(.*)\.pdb/)
	{
	    `sparta+ -in $1.pdb`;
	    `mv pred.tab pred.tab.$1`;
	    `mv struct.tab struct.tab.$1`;
	}
	else
	{
	    print "could not parse $pdbFile.\n";
	    exit;
	}
    }
}

