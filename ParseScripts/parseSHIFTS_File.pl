#!/usr/bin/perl -w

#usage: ./parseSHIFTSFile.pl <inputFilename> <outputFilename> <OPTIONAL: debugFilename>

# reads the input SHIFTS file, parses it to read the 
#N AND H SHIFTS to be written to the output file.

#Note that this script currently only works for ubiquitin.


$numParameters = @ARGV;
if (($numParameters != 2) && ($numParameters != 3))
{
    die("usage:  ./parseSHIFTS_File.pl <inputFilename> <outputFilename> <OPTIONAL: debugFilename>\n");
}

$inputFilename         = shift;
$outputFilename        = shift;

if ($numParameters == 3)
{
    $debugFilename     = shift;
    $writeDebugFile    = 1;
    print STDERR "check out $debugFilename and $outputFilename\n";
    open (FOUT_Debug, ">$debugFilename");
}
else
{
    $writeDebugFile = 0;
    print STDERR "check out $outputFilename\n";
}

open (FOUT, ">$outputFilename");

open (FIN, $inputFilename) || 
    die ("couldn't open $inputFilename");


@residueIDsN = ();
@N_Shift     = ();
@H_Shift     = ();
@residueIDsH = ();


while ($line = <FIN>)
{
    &parseLine ($line);
}

#assuming that the residueIDsH and residueIDsN arrays are in ascending order,
#the routine below writes to the output file only those rows which have both 
#a N and a H shift, and discards the other lines. 

$indexN = 0; $indexH = 0; $numN = scalar(@residueIDsN); $numH = scalar(@residueIDsH);
$total_N_Shift = 0;

#compute average n shift first

while ($indexN < $numN)
{
    $total_N_Shift = $total_N_Shift + $N_Shift[$indexN];
    $indexN        = $indexN + 1;	
}



$average_N_Shift = $total_N_Shift / $indexN; 

#print STDERR "AVERAGE N CHEMICAL SHIFT IS $average_N_Shift\n";

$indexN = 0;

while (($indexN < $numN) & ($indexH < $numH))
{
    if ($residueIDsN[$indexN] == $residueIDsH[$indexH])
    {
	if ($residueIDsN[$indexN] > 0)
	{
	    print FOUT "$residueIDsN[$indexN] $H_Shift[$indexH] $N_Shift[$indexN] \n" ;
	}
	$indexN = $indexN + 1;	$indexH = $indexH + 1;
    }
    elsif ($residueIDsN[$indexN] < $residueIDsH[$indexH])
    {
#missing H CS prediction. This may happen for prolines for instance.
#in this case we skip the corresponding N cs as well.
	$indexN = $indexN + 1;
    }
    else
    {
	#missing N CS prediction. Print average N cs instead
#print aaindex h_shift average_n_shift.
	
	print FOUT "$residueIDsH[$indexH] $H_Shift[$indexH] $average_N_Shift \n" ;
	$indexH = $indexH + 1;
    }
}



#the following code makes this script only for ubiquitin.
#if (($residueIDsN[$numN-1] == 75) & ($residueIDsH[$numH-1] == 76))
#{
#    print FOUT "76 $H_Shift[$indexH] $average_N_Shift \n" ;
#}

$residueIndexCorrespondingToLastNitrogen = $residueIDsN[$numN-1];
$residueIndexCorrespondingToLastHydrogen = $residueIDsH[$numH-1];

#if (($residueIDsN[$numN-1] == 55) & ($residueIDsH[$numH-1] == 56))


if ($residueIndexCorrespondingToLastNitrogen == $residueIndexCorrespondingToLastHydrogen - 1)
{
    print STDERR "This line adds an entry to the SHIFTS file.\n";
    print FOUT "$residueIndexCorrespondingToLastHydrogen $H_Shift[$indexH] $average_N_Shift \n" ;
}


# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

#    print STDERR "READ LINE = $line\n";

    if ($line =~ /^\S\S\S\S\s\S\s\S\S\S\s+(\d+)\s+(\S+)/)
    {
	$aaNumber              = $1;
	$atomType              = $2;

	
	if (&writeAtom($atomType))
	{
	    if ($line =~ /(\-*\d+\.\d+)$/)
	    {
		$predShift             = $1;
	    }
	    else
	    {
		die("could not parse predicted shift from line = $line\n");
	    }
	    if ($writeDebugFile)
	    {
		print FOUT_Debug "$aaNumber $atomType $predShift\n";
	    }
	    push (@residueIDsN, $aaNumber);
	    push (@N_Shift, $predShift);
	}
    }
    elsif ($line =~ /^\S+\s\S\S\S\s+(\d+)\s+(\S+)\s+\-*\d+\.\d+\s+\-*\d+\.\d+\s+\-*\d+\.\d+\s+\-*\d+\.\d+\s+\-*\d+\.\d+\s+(\-*\d+\.\d+)/)
    {
	$aaNumber              = $1;
	$atomType              = $2;
	$predShift             = $3;
	
	if (&writeAtom($atomType))
	{
	    push (@residueIDsH, $aaNumber);
	    push (@H_Shift, $predShift);

	    if ($writeDebugFile)
	    {
		print FOUT_Debug "$aaNumber $atomType $predShift\n";
	    }
	}
    }
    else
    {
	#print STDERR "line = $line does not match the format.\n";
    }
}

# if atom code is not of the ones to be outputted, returns 0;
# otherwise, returns the atom code.
# the recognized atoms are N and H.

sub writeAtom
{
    my $atomCode = shift;
    my $retval   = 1;
    
    unless (($atomCode eq "H") || ($atomCode eq "N"))
    {
	$retval = 0;
    }
    
    $retval;
}
