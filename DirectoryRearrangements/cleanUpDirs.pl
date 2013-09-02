#!/usr/bin/perl -w

@upperDirNames = ("3GB1","1CMZ","1E8L");
@dirNames = ("1HEZ","1PGB");

foreach $upperDirName(@upperDirNames)
{
    print "\n cd $upperDirName";
    print "\n rm -f assemble*";
    print "\n rm -f runHD*";
    print "\n rm -f plotFig.m";
    print "\n rm -f *.jpg";
    print "\n rm -f results.txt";
    print "\n rm -f tmp";

    foreach $dirName (@dirNames)
    {
	print STDOUT $dirName."\n";
	print "\n cd $dirName";
	print "\n rm -f *.m";
	print "\n rm -f *.mat";
	print "*.txt"
	    rename .pdb _pdb *.pdb
	    rm *.*
	    rename _pdb .pdb *.pdb
	    rm
	    bar, hvec, scr, sheet.pdb, *
    }
}
