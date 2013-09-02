#!/usr/bin/perl -w

#usage: ./rearrangeChemicalShifts.pl filename

# given an input file containing parsed chemical shifts, puts the H,N coords on the same line.


$inputFile         = shift;

open (FIN, $inputFile) ||
    die ("couldn't open $inputFile)");


while ($line1 = <FIN>)
{
    $line2 = <FIN>;

    &parseLine ($line1, $line2);
}

# the line contains the coordinate info, which will be printed.
sub parseLine
{
    my $line1           = shift;
    my $line2           = shift;

    if ($line1 =~ /^(\d+)\s+(\S+)\s+(\d+\.\d+)/)
    {
#       print STDERR "READ LINE = $line\n";
        $aaNumber1              = $1;
        $atomCode1              = $2;
        $frequency1             = $3;
    }
    else
    {
       print STDERR "line = $line1 does not match the format.\n";
    }

    if ($line2 =~ /^(\d+)\s+(\S+)\s+(\d+\.\d+)/)
    {
#       print STDERR "READ LINE = $line\n";
        $aaNumber2              = $1;
        $atomCode2              = $2;
        $frequency2             = $3;
    }
    else
    {
       print STDERR "line = $line2 does not match the format.\n";
    }

    if ($aaNumber1 != $aaNumber2)
    {
	print STDERR "error, $aaNumber1 is not equal $aaNumber2.\n";
    }

    print "$aaNumber1 $frequency1 $frequency2\n";
}
