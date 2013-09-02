#!/usr/bin/perl -w

$inputFile         = 'hnNoeManualPeak.txt';
$outputFile        = $inputFile.".NOE.withIntensities";
print STDERR "check out $outputFile\n";
open (FOUT, ">$outputFile");

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the pdb file)");


while ($line = <FIN>)
{
    &parseLine ($line);
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

#    if ($line =~ /^ATOM\s+\d+\s+(\S+)\s+(\S\S\S)[\s\+][\S\s]\s+(\-*\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)\s+(\-*\d+\.\d+)/)
    if ($line =~ /^\s*(\d+\.\d+)\s+(\d+\.\d+)\s+(\d+\.\d+)\s+(\d+\.\d+)/)
    {
#	print STDERR "READ LINE = $line\n";
	$ppm1                     = $1;
	$ppm2                     = $2;
	$ppm3                     = $3;
	$intensity                = $4;
	if ($intensity < 1.0)
	{
	    $intensity            = $intensity * 10;
	}
	print FOUT "$ppm1 $ppm2 $ppm3 $intensity\n";
    }elsif ($line =~ /^\s*(\d+\.\d+)\s+(\d+\.\d+)\s+(\d+\.\d+)/)
    {
#	print STDERR "READ LINE = $line\n";
	$ppm1                     = $1;
	$ppm2                     = $2;
	$ppm3                     = $3;
	$intensity                = 3.0;
	print FOUT "$ppm1 $ppm2 $ppm3 $intensity\n";
    }
}
