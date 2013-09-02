#!/usr/bin/perl -w

#usage: ./parseStrideOutput.pl filename 

# given an input file obtained as a result of running stride, parses it to read and write the Hbond info. output format is:
# residueIndex Hbond?
# the second column is 1 if the nh proton is involved in a H bond, 0 o.w.

$inputFile         = shift;
#$outputFile = $inputFile.".HBondInfo";

#print STDERR "check out $outputFile\n";
#open (FOUT, ">$outputFile");

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");


while ($line = <FIN>)
{
    if ($line =~ /^DNR/)
    {
	&parseLine ($line);
    }
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

    if ($line =~ /^DNR\s\s\S\S\S\s+\S+\s+(\d+)/)
    {
	$residueIndex = $1;
	print STDOUT $residueIndex." 1\n";
    }
    else
    {
	print STDERR "line = $line does not match the format.\n";
    }
}
