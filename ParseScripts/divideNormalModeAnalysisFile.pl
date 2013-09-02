#!/usr/bin/perl -w

#usage: ./divideNormalModeAnalysisFile.pl inputFilename indexOfFirstAA.

#the normal mode analysis file comes in repeated chunks of the coordinates
#corresponding to the motion of the protein along each of the normal modes.
#this script simply divides these chunks and saves the result to
#distinct files.

#inputFilename should have .all extension

unless (@ARGV)
{
    die("usage: ./divideNormalModeAnalysisFile.pl inputFilename indexOfFirstAA\n");
}

$inputFile         = shift;

$outputFileIndex   = 1; 

if ($inputFile =~ /(.*)\.all$/)
  {
      $outputFilePrefix = $1.".coords";
      $outputFileName = $outputFilePrefix.$outputFileIndex;
      print STDERR "check out files starting with $outputFilePrefix\n";
      open (FOUT, ">$outputFileName");
      print STDOUT "check $outputFileName ";	    
  }
else
{
    die("error! file name should have .all extension and should contain the result of normal mode analysis result.\n");
}

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the normal mode analysis file)");


$indexOfFirstAA   = shift ||  1; 

$firstLinePrinted = 0;

while ($line = <FIN>)
{
  if ($line =~ /^(\d+)/)
    {
      &writeLine ($line);
    }
}

print STDOUT "\n";   

# the line contains the coordinate info, which will be printed.
sub writeLine 
{
    my $line           = shift;

    unless ($line =~ /^(\d+)/)
    {
	die ("line = $line does not start with a number!\n");
    }
    
#    print STDERR "READ LINE = $line\n";
    $aaIndex              = $1;

    if ($firstLinePrinted == 0)
    {
	print STDERR "first AA \# = $aaIndex\n";
	unless ($indexOfFirstAA == $aaIndex)
	{
	    die("first AA Index in the file != first aa index that was provided . please rerun with the right amino acid index in the parameters.\n");
	}
	$firstLinePrinted = 1;

	print FOUT $line;
    }
    else
    {
	if ($aaIndex == $indexOfFirstAA)
	{
	    #we start a new file
	    $outputFileIndex = $outputFileIndex + 1;
	    close (FOUT);  
	    
	    $outputFileName = $outputFilePrefix.$outputFileIndex;
	    open (FOUT, ">$outputFileName");
	    print STDOUT " $outputFileName ";
	}
	print FOUT $line;
    }
}

