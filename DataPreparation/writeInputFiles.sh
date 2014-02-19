#!/bin/bash
#

set noclobber

export protFile=120328.prot;
export baseName=1BVH/model_1BVH_1_withHydrogens;
export rdcFileName=MptpA;

./parseResonanceFile.pl $protFile>parsedResonances.txt
./parsePDB_File.pl $baseName.pdb
./parseDSSP.pl $baseName.dssp
./../../../../../usr/local/matlab/bin/matlab -nojvm -nodisplay -nosplash -r "prepareFilesForNVR('$baseName.parsedPDB','$rdcFileName.rdc')"  

./newparse_vectors_N-H.pl $baseName.pdb  
./../../../../../usr/local/matlab/bin/matlab -nojvm -nodisplay -nosplash -r "assembleMyInput('$baseName.parsedDSSP')" 

 
./shiftx/shiftx 1 $baseName.pdb MySHIFTX
./parseSHIFTX_File.pl MySHIFTX MySHIFTX.parsed

./../../../../../usr/local/matlab/bin/matlab -nojvm -nodisplay -nosplash -r adjustAndSSE_InfoToSHIFTX_FileWithoutTemplateShiftxFile  


shifts -qdb parsePDB_File.pl $baseName
shifts -HN '::H' parsePDB_File.pl $baseName

cat $baseName.qdb $baseName.emp>$baseName.SHIFTS_Raw.m

./parseSHIFTS_File.pl $baseName.SHIFTS_Raw.m MySHIFTS
