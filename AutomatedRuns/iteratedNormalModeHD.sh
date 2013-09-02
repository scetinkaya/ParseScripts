#!/bin/csh

set iterationIndex = 3;

set done           = 0;

#while ($done == 0)

  if  (-d Iteration$iterationIndex) then
	echo "directory exists. change iteration index.";
	exit;
  endif

  mkdir Iteration$iterationIndex

  mkdir Iteration$iterationIndex/Accuracies

  mkdir Iteration$iterationIndex/Assignments

  mkdir Iteration$iterationIndex/Output

  mv normalModeHD_Output*  Iteration$iterationIndex/Output

  mv Mode*_Model*_HD_vs_NMA.txt Iteration$iterationIndex/Accuracies

  mv assignments* Iteration$iterationIndex/Assignments

  cp idealAssignments.txt Iteration$iterationIndex/Assignments

  cd Iteration$iterationIndex/Assignments

  ln -s ~/Mist/Matlab/ScoringFunctions/findReliableAssignments.m .

  matlab -nojvm -r "findReliableAssignments(1,1)"

  cp confidentAssignments.txt ../..

  @ iterationIndex = $iterationIndex + 1;

  cd ../..

#  automatedNormalModeHD.sh

#end
