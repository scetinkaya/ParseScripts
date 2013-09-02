#!/usr/bin/perl -w

#usage: ./runNVR.pl pdbPrefix
#e.g.  runNVR.pl 1G6J
#important note: the input files that need to be in the running directory are:
# $pdbPrefix.modeldata
# $pdbPrefix.shiftx
# $pdbPrefix.shifts
# $pdbPrefix.tocsy
# $pdbPrefix.answerkey
# $pdbPrefix.pdb
# where $pdbPrefix is replaced with the pdb prefix, such as 1G6J.


unless (@ARGV)
{
    die("usage: ./runNVR.pl  pdbPrefix\n");
}

$pdbPrefix = shift;


&checkInputFiles($pdbPrefix);

&parsePDBFiles;

&generateModelData;

&runSHIFTS;
&parseSHIFTS;
&adjustSHIFTS;

&runSHIFTX;
&parseSHIFTX;
&adjustSHIFTX;

&runNVR;

sub checkInputFiles
{
    check them;
}

sub parsePDBFiles
{ 
    print "\n nohup parseOriginalPdbFile";
}

sub generateModelData
{ 
    print "\n nohup matlab5.3 < /net/mist/apaydin/ProteinDynamics/Matlab/automatedModelDataGeneration.m";
}

sub runSHIFTS
{ 
    print "\n nohup automatedRunShiftsOnOneStructure";
}

sub parseSHIFTS
{
    print "\n nohup automatedParseShifts";
}

sub adjustSHIFTS
{ 
    print "\n  nohup matlab5.3 < /net/mist/apaydin/ProteinDynamics/Matlab/automatedSHIFTS_FileAdjustment.m";
}

sub runSHIFTX
{
    print "\n  nohup automatedRunShiftxOnFrodaOutput";
}

sub parseSHIFTX
{
    print "\n  nohup automatedParseShiftx"; 
}

sub adjustSHIFTX
{
    print "\n  nohup matlab5.3 < /net/mist/apaydin/ProteinDynamics/Matlab/automatedSHIFTX_FileAdjustment.m"; 
}

sub runNVR
{
    print "\n  nohup matlab5.3 < /net/mist/apaydin/ProteinDynamics/Matlab/automatedRunNVR.m"; 
}


