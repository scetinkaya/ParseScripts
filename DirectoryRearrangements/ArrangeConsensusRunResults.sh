#!/bin/bash
mkdir Assignments
mkdir Results
mv assignments* Assignments
mv Mode*_HD_vs_NMA.txt Results
rename txt txt.backup Assignments/*.txt
cp /usr/project/dlab/Users/apaydin/Mist/ProteinFlexibility/HD_AndNMA/LangmeadHomologyModels/1D3Z/idealAssignments.txt Assignments
