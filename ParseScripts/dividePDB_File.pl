#!/usr/bin/perl -w

#usage: ./dividePDBFile.pl inputFilename 

#the normal mode analysis output file comes in repeated chunks of the coordinates
#corresponding to the motion of the protein along each of the normal modes.
#this script simply divides these chunks and saves the result to
#distinct files.

#The rule is that each separate file starts with a MODEL command and ends with
#ENDMDL.

#inputFilename should have .pdb extension

unless (@ARGV)
{
    die("usage: ./dividePDBFile.pl inputFilename\n");
}

$inputFile         = shift;

$outputFileIndex   = 0; 

if ($inputFile =~ /(.*)\.pdb$/)
  {
      $outputFilePrefix = $1.".model";
      print STDOUT "check out the following files: ";
  }
else
{
    die("error! file name should have .pdb extension and should contain the result of normal mode analysis result.\n");
}

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the normal mode analysis result file)");

while ($line = <FIN>)
{
  if ($line =~ /^MODEL/)
    {
	$outputFileIndex = $outputFileIndex + 1;
	$outputFileName  = $outputFilePrefix.$outputFileIndex.".pdb";
	open (FOUT, ">$outputFileName");
	print STDOUT " $outputFileName ";	    

	while ($line = <FIN>)
	{
	    if ($line =~ /^ENDMDL/)
	    {
		print FOUT "END\n";
		close (FOUT);  
		last;
	    }
	    else
	    {
		print FOUT $line;
	    }
	}
    }
}

print STDOUT "\n";   



