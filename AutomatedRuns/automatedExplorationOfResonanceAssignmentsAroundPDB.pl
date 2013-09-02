#!/usr/bin/perl -w

use strict;

#usage: ./automatedExplorationOfResonanceAssignmentsAroundPDB.pl pdbPrefix

#runs the scripts to run HD vs. NMA on a protein.

#preconditions to run this script:
#1- there should be templateFiles (answerkey.m,TOCSY.m, templateSHIFTX.m, templateModelData.m, myinput.m, NOES.txt, order.m) in the parent directory.
#2- the pdb files should be in the present directory. They should be named as $pdbPrefix-NMA.$modeIndex.pdb, where $modeIndex goes from 7 to 11.

#note: templateModelData is the same as the input.m. Apparently it works.

#output: 
#at the end of the run:
#the results should be stored in the current dir. with the name of:
#Mode%d_HD_vs_NMA.txt where %d goes from 7 to 11.
#please make sure to rename their extension to .txt.backup so that
#they are not overwritten.

unless (@ARGV)
{
    die("usage: ./automatedExplorationOfResonanceAssignmentsAroundPDB.pl  pdbPrefix\n");
}

my $pdbPrefix       = shift;

my $scriptDirPrefix = "Scripts";

&createDirectoryStructure;

&copyTemplateFiles;

&modelDataFunctions;

&shiftsFunctions;

&shiftxFunctions;

sub createDirectoryStructure
{ 
	`mkdir Pdb`;
	`mkdir ModelDataGeneration`;
	`mkdir ModelDataGeneration/ModelDataFiles`;
	
	`mkdir SHIFT__FileGeneration/`;
	
	`mkdir SHIFT__FileGeneration/SHIFTS`;
	`mkdir SHIFT__FileGeneration/SHIFTS/Data`;
	`mkdir SHIFT__FileGeneration/SHIFTS/Parsed`;
	`mkdir SHIFT__FileGeneration/SHIFTS/Parsed/Temp`;
	`mkdir SHIFT__FileGeneration/SHIFTS/Parsed/Adjusted`;
	
	`mkdir SHIFT__FileGeneration/SHIFTX`;
	`mkdir SHIFT__FileGeneration/SHIFTX/Data`;
	`mkdir SHIFT__FileGeneration/SHIFTX/Parsed`;
	`mkdir SHIFT__FileGeneration/SHIFTX/Parsed/Temp`;
	`mkdir SHIFT__FileGeneration/SHIFTX/Parsed/Adjusted`;
	
	`mkdir Scripts`;

}

sub copyTemplateFiles
{
	` cp ../templateSHIFTX.m    .`;
	` cp ../answerkey.m         answerkey.m`;
	` cp ../TOCSY.m             TOCSY.m`;
	` cp ../templateModelData.m .`;
	` cp ../myinput.m .`;
	` cp ../NOES.txt .`;
	` cp ../order.m .`;

}

sub modelDataFunctions
{
    &generateModelData;
    &moveModelData;
    &divideModelData;
}

sub shiftsFunctions
{
    &dividePdbFiles;
    &runSHIFTS;
    &moveSHIFTS_Data;
    &parseSHIFTS;
    &adjustSHIFTS;
    &cleanUpSHIFTS_Data;
}

sub shiftxFunctions
{
    &runSHIFTX;
    &moveSHIFTX_Data;
    &renameSHIFTX_Result;
    &parseSHIFTX;
    &adjustSHIFTX;
    &cleanUpSHIFTX_Data;
}



sub generateModelData
{
    my $matlabFilename_ModelGeneration        = "automatedModelDataGeneration.m";

    &parsePDB_Files;
    
    &prepareMatlabFileForModelGeneration ($matlabFilename_ModelGeneration);

    &runMatlabFileForModelGeneration     ($matlabFilename_ModelGeneration);
}


sub parsePDB_Files
{ 
    my $modeIndex;

    `mv *.pdb Pdb`;

    for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
    {
	`parsePDB_File.pl Pdb/$pdbPrefix-NMA.$modeIndex.pdb`;
    }
}

sub prepareMatlabFileForModelGeneration
{
    my $matlabFilename_ModelGeneration      = $_[0];

    open  (FOUT_MatlabFile_ModelGeneration, ">$matlabFilename_ModelGeneration");

    print "$matlabFilename_ModelGeneration\n";

    

    print  FOUT_MatlabFile_ModelGeneration  "addpath('/home/home4/apaydin/Mist/Matlab/FileProcessing')\n";

    print  FOUT_MatlabFile_ModelGeneration  "modelDataFilename = '../templateModelData.m';\n";
    
    print  FOUT_MatlabFile_ModelGeneration  "cd Pdb\n";

    print  FOUT_MatlabFile_ModelGeneration  "for modeIndex = 7:11 \n";

    print  FOUT_MatlabFile_ModelGeneration  "  parsedPdbFilename        = sprintf('$pdbPrefix-NMA.%d.parsedPDB', modeIndex); \n";
    
    print  FOUT_MatlabFile_ModelGeneration  "  matlabFilename           = sprintf('Mode%d.all',modeIndex); \n";

    print  FOUT_MatlabFile_ModelGeneration  "  generateOneModelData (modelDataFilename, parsedPdbFilename, matlabFilename); \n";

    print  FOUT_MatlabFile_ModelGeneration  "end \n";

    close  FOUT_MatlabFile_ModelGeneration;
}

sub runMatlabFileForModelGeneration
{
    my $matlabFilename_ModelGeneration = $_[0];

    `nohup matlab -nojvm -nodisplay < $matlabFilename_ModelGeneration`;

    `mv $matlabFilename_ModelGeneration Scripts`;
}



sub moveModelData
{
    `mv Pdb/Mode*.all ModelDataGeneration/ModelDataFiles`;
}

sub divideModelData
{
    my $modeIndex;

    for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
    {
	`~/Mist/Scripts/ParseScripts/divideNormalModeAnalysisFile.pl ModelDataGeneration/ModelDataFiles/Mode$modeIndex.all 2`;
    }

}

sub dividePdbFiles
{
    my $modeIndex;

    for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
    {
	`dividePDB_File.pl Pdb/$pdbPrefix-NMA.$modeIndex.pdb`;
    }

}

sub runSHIFTS
{ 
    chdir("Pdb");

    my ($modeIndex, $modelIndex, $pdbFilenamePrefix);

    for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
    {
	for ($modelIndex = 1; $modelIndex <= 11; $modelIndex = $modelIndex + 1)
	{
	    $pdbFilenamePrefix = "$pdbPrefix-NMA.$modeIndex.model$modelIndex";

	    `shifts -qdb -noreslib $pdbFilenamePrefix`;
	    `shifts -noreslib '::H'  $pdbFilenamePrefix > $pdbFilenamePrefix.out2`;
	}
    }

    chdir("..");
}

sub moveSHIFTS_Data
{
    `mv Pdb/*.bmrb SHIFT__FileGeneration/SHIFTS`;
    `mv Pdb/*.out1 SHIFT__FileGeneration/SHIFTS`;
    `mv Pdb/*.out2 SHIFT__FileGeneration/SHIFTS`;
    `mv Pdb/*.par1 SHIFT__FileGeneration/SHIFTS`;
}

sub parseSHIFTS
{
    my ($pdbFilenamePrefix,$modeIndex,$modelIndex);

    chdir("SHIFT__FileGeneration/SHIFTS");

    for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
    {
	for ($modelIndex = 1; $modelIndex <= 11; $modelIndex = $modelIndex + 1)
	{
	    $pdbFilenamePrefix = "$pdbPrefix-NMA.$modeIndex.model$modelIndex";

	    `cat $pdbFilenamePrefix.out1 $pdbFilenamePrefix.out2 > $pdbFilenamePrefix.SHIFTS_Raw.m`;
	    `parseSHIFTS_File.pl $pdbFilenamePrefix.SHIFTS_Raw.m MySHIFTS.$modeIndex.model$modelIndex`;
	}
    }
    chdir("../..");
}

sub adjustSHIFTS
{ 
    `nohup matlab -nojvm -nodisplay < /home/home4/apaydin/Mist/Matlab/AutomatedRuns/automatedSHIFTS_FileAdjustment.m`;
}

sub cleanUpSHIFTS_Data
{
    my $shiftsFilename     = $_[0];

    chdir ("SHIFT__FileGeneration/SHIFTS");

    `mv *.bmrb Data`;
    `mv *.out1 Data`;
    `mv *.out2 Data`;
    `mv *.par1 Data`;
    `mv *.adjusted Parsed/Adjusted`;
    `mv MySHIFTS.* Parsed/Temp`;
    `mv *SHIFTS_Raw.m Data`;

    chdir ("../..");
}

sub runSHIFTX
{
   
    my ($modeIndex, $modelIndex, $pdbFilenamePrefix);

    for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
    {
	for ($modelIndex = 1; $modelIndex <= 11; $modelIndex = $modelIndex + 1)
	{
	    $pdbFilenamePrefix = "$pdbPrefix-NMA.$modeIndex.model$modelIndex";
	    
	    `shiftx.linux.bin 1 Pdb/$pdbFilenamePrefix.pdb Pdb/$pdbFilenamePrefix.shiftx`;
	}
    }
}

sub moveSHIFTX_Data
{

    ` mv Pdb/*.shiftx SHIFT__FileGeneration/SHIFTX`;
}

sub renameSHIFTX_Result
{
    ` rename $pdbPrefix-NMA MySHIFTX  SHIFT__FileGeneration/SHIFTX/*.shiftx`;
    ` rename .shiftx '' SHIFT__FileGeneration/SHIFTX/*.shiftx`;
}

sub parseSHIFTX
{
    my ($modeIndex, $modelIndex, $pdbFilenamePrefix);

    chdir("SHIFT__FileGeneration/SHIFTX");

    for ($modeIndex = 7; $modeIndex <= 11; $modeIndex = $modeIndex + 1)
    {
	for ($modelIndex = 1; $modelIndex <= 11; $modelIndex = $modelIndex + 1)
	{
	    $pdbFilenamePrefix = "$pdbPrefix-NMA.$modeIndex.model$modelIndex";
	    
	    `parseSHIFTX_File.pl MySHIFTX.$modeIndex.model$modelIndex MySHIFTX.$modeIndex.model$modelIndex.parsed`;
	}
    }
}


sub adjustSHIFTX
{
    my $matlabFilenameForShiftxFileAdjustment = "automatedShiftxFileAdjustment.m";

    open (FOUT, ">$matlabFilenameForShiftxFileAdjustment");
    print FOUT "addpath('/home/home4/apaydin/Mist/Matlab/FileProcessing');\n";

    print FOUT "templateShiftxFile = '../../templateSHIFTX.m'; \n";

    print FOUT "cd SHIFT__FileGeneration/SHIFTX/\n";

    print FOUT "for modeIndex = 7:11 \n";
    print FOUT "  for modelIndex = 1:11 \n";
    print FOUT "    shiftxFilename = sprintf('MySHIFTX.\%d.model\%d.parsed\',modeIndex,modelIndex); \n";
    print FOUT "    adjustAndSSE_InfoToSHIFTX_File(templateShiftxFile, shiftxFilename); \n";
    print FOUT "  end \n";
    print FOUT "end \n";

    close FOUT;

    `nohup matlab -nojvm < $matlabFilenameForShiftxFileAdjustment`;

    chdir("../..");
}

sub cleanUpSHIFTX_Data
{ 

    chdir("SHIFT__FileGeneration/SHIFTX");

    `mv *.parsed Parsed/Temp`;
    `mv *.adjusted Parsed/Adjusted`;
    `rename parsed.adjusted adjusted Parsed/Adjusted/*.adjusted`;
    `mv MySHIFTX.* Data`;

    chdir("../.."); 
}

sub runNormalModeHD
{
    ` nohup matlab -nojvm -nodisplay < ~/Mist/Matlab/AutomatedRuns/automatedRunNormalModeHD.m`;
}


sub runFroda
{
    my $pdbPrefix           = shift;
    
    ` nohup ~/Research/Mist/Tools/FIRST5.2/src/FIRST5 -non -E-1 -FRODA -totconf10000 $pdbPrefix.pdb`;
}

sub renameFrodaOutput
{
    my $pdbPrefix           = shift;

    ` rename $pdbPrefix\_froda\_ Coords *.pdb`;
}
sub cleanUpFrodaOutput
{
    my $pdbPrefix           = shift;
    ` mkdir Pdb`;
    ` mkdir OtherFrodaData`;
    ` mv *.pdb Pdb`;
    ` mv $pdbPrefix* OtherFrodaData`;
    ` mv cluster.list OtherFrodaData`;
    
}


sub generateStrideData
{
    ` nohup automatedRunStride`;
}

sub moveStrideData
{
    ` mkdir ModelDataGeneration/StrideFiles`;
    ` mkdir ModelDataGeneration/StrideFiles/Raw`;
    ` mv Pdb/*.stride ModelDataGeneration/StrideFiles/Raw`;
}

sub parseStrideData
{
    ` mkdir ModelDataGeneration/StrideFiles/Parsed`;

    ` nohup automatedParseStrideScript`;
}


sub updateModelDataFileWithNewHBondInfo
{

    ` nohup matlab5.3 < /home/home4/apaydin/Mist/ProteinDynamics/Matlab/changeLabilityInfoInModelData.m`;
    ` mkdir ModelDataGeneration/ModelDataFiles/Temp`;
    ` mv ModelDataGeneration/ModelDataFiles/ModelData* ModelDataGeneration/ModelDataFiles/Temp`;
    ` rename NewModelData ModelData ModelDataGeneration/ModelDataFiles/NewModelData*`;
}



sub runFrodaNVR{` nohup matlab5.3 < /home/home4/apaydin/Mist/ProteinDynamics/Matlab/automatedRunFrodaNVR.m`; }

sub runFrodaHD{ ` nohup matlab5.3 < /home/home4/apaydin/Mist/ProteinDynamics/Matlab/automatedRunFrodaHD.m`;}

