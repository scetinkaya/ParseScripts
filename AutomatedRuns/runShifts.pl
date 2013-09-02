#!/usr/bin/perl -w


unless (@ARGV)
{
    die("usage: ./runShifts.pl  pdbFilename\n");
}

$pdbFilename = shift;

open(FIN, $pdbFilename) || die("$pdbFilename could not be found in the current directory.\n");
close(FIN);

if ($pdbFilename =~ /^(.*)\.pdb/)
{
    $pdbID = $1;
}
else
{
    die("could not extract the pdb ID\n");
}

`shifts -qdb -noreslib  $pdbID`;
`shifts -noreslib '::H' $pdbID > $pdbID.out2`;
`cat $pdbID.out1 $pdbID.out2 > $pdbID.SHIFTS_Raw.txt`;
`parseSHIFTSFile.pl $pdbID.SHIFTS_Raw.txt $pdbID.shifts`;
