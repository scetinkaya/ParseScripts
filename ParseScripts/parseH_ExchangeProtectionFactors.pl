#!/usr/bin/perl -w

#usage: ./parseH_ExchangeProtectionFactors.pl filename 




$inputFile         = shift;

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");


while ($line = <FIN>)
{
    &parseLine ($line);
}

# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

    if ($line =~ /^\S(\d+)\s+\S+\s+\S+\s+(\S+)/)
    {

	$aaCode                = $1;
	$k                     = $2;

	print STDOUT "$aaCode $k \n";
    }
}
