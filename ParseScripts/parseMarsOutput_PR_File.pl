#!/usr/bin/perl -w

use strict;

open (FIN,'assignment_PR.out');

my $line;

while ($line = <FIN>)
{
    if (($line =~ /(\d+)\s+\S\S\S\_(\d+)/))
    {
	print STDOUT "$1 $2\n";
    }
    else
    {
	print STDERR "line $line does not match the format.\n";
    }
}


close(FIN);





