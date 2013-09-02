#!/usr/bin/perl -w

#usage: ./generateMoveShiftsFiles.pl

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
    print STDOUT "mkdir SHIFTS\n";
    print STDOUT "mkdir SHIFTX\n";
    print STDOUT "mv *.out? SHIFTS\n";
    print STDOUT "mv *.bmrb SHIFTS\n";
    print STDOUT "mv *.par1 SHIFTS\n";
    print STDOUT "mv MySHIFTS* SHIFTS\n";
    print STDOUT "mv *SHIFTS_* SHIFTS\n";
    
    print STDOUT "cd ..\n";
}
