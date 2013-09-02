#!/usr/bin/perl -w

use strict;

my $startIndex;
my $modelIndex;
my $scriptFilename;
my $warning;
my $modeIndex;




for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
{

    
    for ($modelIndex = 6; $modelIndex >= 1; $modelIndex = $modelIndex - 1)
    {

	 &runAmberScriptOnTheAppropriateFile($scriptFilename, $modeIndex, $modelIndex);

	 exit;

    }
    



    for ($modelIndex = 7; $modelIndex <= 11; $modelIndex = $modelIndex + 1)
    {

	&runAmberScriptOnTheAppropriateFile    ($scriptFilename, $modeIndex, $modelIndex);

    }
    

    
}






sub runAmberScriptOnTheAppropriateFile
{
    my $scriptFilename = shift;
    my $modeIndex      = shift;
    my $modelIndex     = shift;




    `sander -i min.in -o 1ef1.$modeIndex.$modelIndex.out -c PrmcrdFiles/prmcrd.$modeIndex.$modelIndex -r coords.$modeIndex.$modelIndex.xyz`;

#    print "sander completed for mode $modeIndex model $modelIndex.\n";

#    `ambpdb -p prmtop.$modeIndex.$modelIndex < prmcrd.$modeIndex.$modelIndex > coords.$modeIndex.$modelIndex.pdb`;

  
}
