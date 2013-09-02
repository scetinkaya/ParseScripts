#!/usr/bin/perl -w

#usage: 



$numParameters = @ARGV;
if (($numParameters != 1) )
{
    die("usage:  ./parseSHIFTS_File.pl <inputFilename> \n");
}

$inputFilename         = shift;

open (FIN, $inputFilename) || 
    die ("couldn't open $inputFilename");

while ($line = <FIN>)
{
    &parseLine ($line);
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

    if ($line =~ /^(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\d+)\s+(\d+)/)
    {
	print $1." ".$2." ".$3." ".$4."\n";
    }
}
