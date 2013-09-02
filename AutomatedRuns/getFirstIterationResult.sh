#!/bin/csh

    if (-d Iteration1) then
	echo "directory exists. exiting.";
	exit;
    endif

    mkdir Iteration1
    mkdir Iteration1/Assignments
    cp Assignments/as* Iteration1/Assignments
    cp Bidirectional/Assignments/assignments* Iteration1/Assignments
    rename 7.8. 78_ Iteration1/Assignments/as*
    cp idealAssignments.txt Iteration1/Assignments
    cd Iteration1/Assignments
    ln -s ~/Mist/Matlab/ScoringFunctions/findReliableAssignments.m .
    matlab -nojvm -r "findReliableAssignments(1,1)"
    cp confidentAssignments.txt ../..
    cd ../..

    mkdir SHIFTS
    mkdir SHIFTX
    cp SHIFT__FileGeneration/SHIFTS/Parsed/Adjusted/MySHIFTS.* SHIFTS/
    cp Bidirectional/SHIFTS/MySHIFTS.7.8.model* SHIFTS/
    cd SHIFTS/
    rename .adjusted '' *
    rename 7.8 78 *
    cd ..
    cp SHIFT__FileGeneration/SHIFTX/Parsed/Adjusted/MySHIFTX.* SHIFTX
    cp Bidirectional/SHIFTX/MySHIFTX.7.8.model* SHIFTX/
    cd SHIFTX/
    rename .adjusted '' *
    rename 7.8 78 *
    cd ..
   

    cp Bidirectional/ModelDataGeneration/ModelDataFiles/Mode.7.8.* ModelDataGeneration/ModelDataFiles/
    rename Mode.7.8 Mode78 ModelDataGeneration/ModelDataFiles/*

   
