#!/usr/bin/perl -w

#usage: ./generateMoveShiftxFiles.pl > myMoveShiftxFiles.pl

#prints to STDOUT the following:
# cd Mode$modeIndex
#mkdir SHIFTS
#mkdir SHIFTX
#mv *.out? SHIFTS/
#mv *.bmrb SHIFTS/
#mv *.par1 SHIFTS/
#mv MySHIFTS* SHIFTS/
#mv *SHIFTS_* SHIFTS/
#where $modeIndex goes from 7 to 11.

for ($modeIndex = 7; $modeIndex <= 11; $modeIndex ++)
{
    print STDOUT "cd Mode$modeIndex\n";
    print STDOUT "mv *.shiftx SHIFTX\n";
    print STDOUT "mv MySHIFTX* SHIFTX\n";
    
    print STDOUT "cd ..\n";
}
