#!/usr/bin/perl -w

#usage: ./parsePDBFile.pl filename 

# given an input (PDB) file, parses it to read and write the H,N coords.


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

    if ($line =~ /^\s+(\d+)\s+(\d+)\s+(\S\S\S)\s\S \. (\d\.\d+)/)
    {
	$aaNumber              = $2;
	$S2                    = $4;
	print STDOUT "$aaNumber $S2\n";
    }
    else
    {
#	print STDERR "line = $line does not match the format.\n";
    }
}

