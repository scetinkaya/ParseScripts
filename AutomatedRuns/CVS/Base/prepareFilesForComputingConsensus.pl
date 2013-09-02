#!/usr/local/bin/perl -w
#


@proteinNamesArray = ("1D3Z","3GB1","1CMZ");

@homologNamesArray = ("1EF1","1RFA","1VCB","1H8C","1HEZ","1JML","1DK8");

@numHomologsPerProtein = (4,2,1);


chdir("/usr/project/dlab/Users/apaydin/Mist/ProteinFlexibility/HD_AndNMA/LangmeadHomologyModels/") or die("couldn't cd to ~/Workdir");


$homologNamesArrayCounter = 0;

for ($proteinIndex = 0; $proteinIndex < 3; $proteinIndex = $proteinIndex + 1)
{
    $proteinDir = $proteinNamesArray[$proteinIndex];

    chdir ($proteinDir);

    $numHomologs = $numHomologsPerProtein[$proteinIndex];

    for ($homologIndex = 0; $homologIndex < $numHomologs; $homologIndex  = $homologIndex + 1)
    {

	$homologDirName = $homologNamesArray[$homologNamesArrayCounter];

	$homologNamesArrayCounter = $homologNamesArrayCounter + 1;

	$currentDir = `pwd`;

	print "currentdir = $currentDir\n";

	chdir ($homologDirName) or die ("couldn't cd to $homologDirName");

	`mkdir BlameAssignment`;

	chdir("BlameAssignment") or die "can't cd to BlameAssignment"; 

	@dirArray = ("ModifyingOnlyNOEs","ModifyingOnlyRDCs","ModifyingOnlySHIFTS","ModifyingOnlySHIFTX", "ModifyingOnlyRDC1","ModifyingOnlyRDC2");
	
	for ($dirIndex = 0; $dirIndex < 6; $dirIndex = $dirIndex + 1)
	{
	    $dirString = $dirArray[$dirIndex];
	    
	    if (-e $dirString)
	    {
	    }
	    else
	    {
		mkdir ($dirString);
	    }
	    
	    chdir ($dirString) or die "can't cd to $dirString"; ;
	    
	    `ln -s ~/BlameAssignment/ModifyingOnlyNOEs/ModelDataGeneration/ .`;
	    `ln -s ~/BlameAssignment/ModifyingOnlyNOEs/SHIFT__FileGeneration/ .`;
	    `cp ~/BlameAssignment/ModifyingOnlyNOEs/*.m .`;
	    `cp ~/BlameAssignment/ModifyingOnlyNOEs/*.txt .`;
	    
	    mkdir ("Assignments");
	    
	    mkdir ("Results");
	    
#    `mv assignments* Assignments`;
	    
#    `mv Mode*_HD_vs_NMA.txt Results/`;
	    
#    chdir ("Assignments");
	    
#    `rename txt txt.backup assignmentsForMode*`;
	    
#    `cp ../idealAssignments.txt .`;
	    
#    chdir ("../Results");
	    
#    `rename txt txt.backup *`;
	    
#    chdir ("../..");
	    
	    chdir("..");
	}
	
	chdir ("../..");
    }
    
    chdir ("..");
}





