#!/usr/bin/perl -w


$dirNamePrefix = "/net/mist/apaydin/ProteinDynamics/FIRST_FRODA/LangmeadHomologyModels/1D3Z/Originals/";
@dirNames = ("1H8C");#,"1RFA","1VCB","1EF1","1C9F","1XGM","1ESR","1G6J","1UBI","1UBQ","1UD7");
@refPdbFileNames = ("1h8c_REF");#,"1rfa_REF","1vcb_REF","1ef1_REF","1c9f_REF","1xgm_REF","1esr_REF","1g6j_REF","1ubi_REF","1ubq_REF","1ud7_REF");

#@dirNames = ("1VCB","1EF1","1C9F","1XGM","1ESR","1UBI","1UBQ","1UD7");
#@refPdbFileNames = ("1vcb_REF","1ef1_REF","1c9f_REF","1xgm_REF","1esr_REF","1ubi_REF","1ubq_REF","1ud7_REF");

$i = 0; $dontRun = 1;
foreach $dirName (@dirNames)
{
    $refPdbFileName = $refPdbFileNames[$i];
    $dirName = "$dirNamePrefix$dirName";

    chdir ($dirName) or die"can't cd to $dirName";

    if ($dontRun)
    {
    `rm -f $refPdbFileName.pdb`;
#    `ln -s foo.pdb $refPdbFileName.pdb`;
    `automatedComputationOfResonanceAssignmentForTheOriginalStructure.pl $refPdbFileName > runScript`;
    `chmod u+x runScript`;
    }
    else
    {
	print "$dirName\n";
	`nohup ./runScript&`;
    }

    $i = $i + 1;
}

#cd 1H8C

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1h8c_REF


#cd ../1RFA

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1rfa_REF


#cd ../1VCB

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1vcb_REF

#cd ../1EF1

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1ef1_REF

#cd ../1C9F

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1c9f_REF

#cd ../1XGM

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1xgm_REF

#cd ../1ESR

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1esr_REF

#cd ../1G6J

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1g6j_REF

#cd ../1UBI

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1ubi_REF

#cd ../1UBQ

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1ubq_REF

#cd ../1UD7

#automatedExplorationOfResonanceAssignmentsAroundPDB.pl 1ud7_REF

