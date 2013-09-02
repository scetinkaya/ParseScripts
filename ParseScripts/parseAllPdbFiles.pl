#!/usr/bin/perl -w

#usage: ./parseAllPdbFiles.pl 


#$residueIndex = 17;
$residueIndex = 80;
while ($residueIndex < 81)
{
    $inputFile         = "$residueIndex.amu.coor";

#if ($inputFile =~ /(.*)\.pdb$/)

    if (!(-e $inputFile))
    {
	print STDERR "the file $inputFile is not present.\n";
	$residueIndex = $residueIndex + 1;
	next;
    }

    parsePDB_File($inputFile);
    $residueIndex = $residueIndex + 1;

}

sub parsePDB_File
{
    $inputFile = shift;
    
    $skipThisFile = 0;

    if ($inputFile =~ /(.*)\.coor$/)
    {
	$outputFile = $1.".parsedPDB";

	if (-e $outputFile)
	{
	    $skipThisFile = 1;
	}
	else
	{
	    print STDERR "check out $outputFile\n";
	    open (FOUT, ">$outputFile");
	}
    }
    else
    {
	die("error! file should be a pdb file and should finish with .pdb\n");
    }

    if ($skipThisFile == 1)
    {
    }
    else
    {
	open (FIN, $inputFile) || 
	    die ("couldn't open $inputFile (should be the coor file)");
	
	while ($line = <FIN>)
	{
	    if ($line =~ /^ATOM/)
	    {
		&parseLine ($line);
	    }
	}
    }
}   
# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;
    
    if ($line =~ /^ATOM\s+\d+\s+(\S+)\s+(\S\S\S)[\s\+][\S\s]\s+(\-*\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/)
#    if ($line =~ /^ATOM\s+\d+\s+(\S+)\s+(\S\S\S)[\+]*[\S\s]\s+(\-*\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/)
    {
	
#	print STDERR "READ LINE = $line\n";
	$atomCode              = $1;
	$aaCode                = $2;
	$aaNumber              = $3;
	$x                     = $4;
	$y                     = $5;
	$z                     = $6;
	
	if (&writeAtom($atomCode))
	{
	    
#	    print STDERR "atom code = $atomCode, aa = $aaCode, x = $x, y = $y, z = $z\n";
	    print FOUT "$atomCode $aaCode $aaNumber $x $y $z\n";
	}
    }
    else
    {
#	print STDERR "line = $line does not match the format.\n";
    }
}

# if atom code is "H" or "N", returns 1, o.w. returns 0;

sub writeAtom
{
    my $atomCode = shift;
    my $retval   = 1;
    

#    unless (($atomCode eq "H") || ($atomCode eq "N"))
#    unless (($atomCode eq "H"))# || ($atomCode eq "N"))
    unless (($atomCode eq "CA"))# || ($atomCode eq "N"))
    {
	$retval = 0;
    }
    
    $retval;
}
