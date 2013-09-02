#!/usr/bin/perl -w


$dirNamePrefix   = "/home/home4/apaydin/Mist/ProteinFlexibility/FIRST_FRODA/LangmeadHomologyModels/1D3Z";
@dirNames        = ("1H8C","1RFA","1VCB","1EF1");
@refPdbFileNames = ("1H8C_REF","1RFA_REF","1VCB_REF","1EF1_REF");

$i = 0;

foreach $dirName (@dirNames)
{
    $refPdbFileName = $refPdbFileNames[$i];
    $dirName        = "$dirNamePrefix/$dirName";

    chdir ($dirName) or die "can't cd to $dirName";
    
    `automatedExplorationOfResonanceAssignmentsAroundPDB.pl $refPdbFileName > runScript`;
    `chmod u+x runScript`;
    $i = $i + 1;
}
