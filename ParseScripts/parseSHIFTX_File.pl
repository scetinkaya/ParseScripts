#!/usr/bin/perl -w

#usage: ./parseSHIFTX_File.pl <inputFilename> <outputFilename>

# reads the input SHIFTX file, parses it to just keep the first part of the file, and also removes any
#'*' in front of the residue numbers.


$numParameters = @ARGV;
if ($numParameters != 2)
{
    die("usage:  ./parseSHIFTX_File.pl <inputFilename> <outputFilename>\n");
}



$inputFile         = shift;
$outputFile        = shift;

print STDERR "check out $outputFile\n";

open (FOUT, ">$outputFile");

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");

&checkAndDiscardFirstTwoLines;

while ($line = <FIN>)
{
    if ($line =~ /NUM/)
    {
	exit;
    }
    &parseLine($line);
}




# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

    if ($line =~ /^\s[\s\*](.*)/)
    {
	print FOUT "$1\n";
    }

}

sub checkAndDiscardFirstTwoLines
{

    $line = <FIN>;
    unless ($line =~ /NUM/)
    {
	die("line = $line does not contain   NUM\n");
    }
	
    $line = <FIN>;
    unless ($line =~ "---")
    {
	die ("second line = $line does not contain ---\n");
    }
}

