#!/usr/bin/perl -w

note: this script has been made obsolete by adjustAndAddSSE_InfoToSHIFTX_File.m, which both adjusts the order of the 
data lines accordint to the template, and also adds sse info to the file.

#usage: ./addSSEInfoToShiftxFile.pl <inputFilename> <outputFilename>

# given an input SHIFTX file, inserts the secondary structure info 
# to it using the template SHIFTX file.


#$inputFile         = 'MySHIFTX.in';
#$outputFile        = 'MySHIFTX';

$inputFile         = shift;
$outputFile        = shift;
$templateFile      = 'SHIFTX.m.adjusted';

print STDERR "check out $outputFile\n";
open (FOUT, ">$outputFile");

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");

open (TEMPLATE_FIN, $templateFile) || 
    die ("couldn't open $templateFile");

while (($line = <FIN>) && ($templateLine = <TEMPLATE_FIN>))
{
    &parseLine($line, $templateLine);
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;
    my $templateLine   = shift;

#    print STDERR "READ LINE = $line\n";
#    print STDERR "READ TEMPLATE LINE = $templateLine\n";

#    if ($templateLine =~ /^\d+\s+\c\d+(\c)\d+\-*\d+\.\d+\s+\-*\d+\.\d+\s+\-*\d+\.\d+\s+\-*\d+\.\d+\s+\-*\d+\.\d+\s+\-*\d+\.\d+/)
    if ($templateLine =~ /^\d+\s+\S\s+(\S)\s+/)#\-*\d+\.*\d+\s+\-*\d+\.*\d+\s+\-*\d+\.*\d+\s+\-*\d+\.*\d+\s+\-*\d+\.*\d+\s+\-*\d+\.*\d+/)
    {
	$sseType              = $1;
#	print STDOUT "sseType0 = $sseType ";

	if ($line =~ /\s+(\d+)\s+(\S)\s+(\-*\d+\.*\d+)\s+(\-*\d+\.*\d+)\s+(\-*\d+\.*\d+)\s+(\-*\d+\.*\d+)\s+(\-*\d+\.*\d+)\s+(\-*\d+\.*\d+)/)
	{
#	    print STDOUT "sseType1 = $sseType ";
	    print FOUT "$1\t $2\t $sseType\t $3\t $4\t $5\t $6\t $7\t $8\n";
#	    print STDOUT "sseType2 = $sseType ";
#	    print "WROTE LINE: $1\t $2\t $sseType\t $3\t $4\t $5\t $6\t $7\t $8\n";
	    #print "$1\t $2\t $sseType--?\t $3\t $4\t $5\t $6\t $7\t $8\n";
	}
	else
	{
	    print STDERR "line = $line does not match the format.\n";
	}
    }
    else
    {
	print STDERR "templateLine = $templateLine does not match the format.\n";
    }
}
