#!/usr/bin/perl -w

#usage: ./parsePDB_IDsFromXinGaoFile.pl 

# reads the Xin Gao file query_seq_ss_cs_new.txt, parses it to read the 
#pdb files to be written to the output file.

$inputFilename         = 'query_seq_ss_cs_new.txt';

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

#    print STDERR "READ LINE = $line\n";

    if ($line =~ /^\>(\S+)\s+(\S+)/)
    {
	$bmrbID                = $1;
	$pdbID                 = $2;
	
	print STDOUT ($pdbID, "\n");
    }
}


