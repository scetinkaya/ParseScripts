#!/usr/bin/perl -w

#usage: ./parseUPL.pl filename 

# given an input (UPL) file, parses it to read and write NOEs.


$inputFile         = shift;
if ($inputFile =~ /(.*)\.upl$/)

{
      $outputFile = $1.".parsedUPL";
      print STDERR "check out $outputFile\n";
      open (FOUT, ">$outputFile");
}
else
{
    die("error! file should be a upl file and should finish with .upl\n");
}

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the upl file)");


while ($line = <FIN>)
{

    if (($line =~ /^\s+/) || ($line =~ /^\d+/))
    {
	
	&parseLine ($line);
    }
}
close(FOUT);
# the line contains the coordinate info, which will be printed.
sub parseLine 
{
    my $line           = shift;

    if ($line =~ /^\s*(\d+)\s+\S+\s+(\S+)\s+(\d+)\s+\S+\s+(\S+)\s+\S+\s+\S+\s+\S+\s+\S+\s+\S+\s+\S+/)
    {

	$atomNum1              = $1;
	$atomName1             = $2;
	$atomNum2              = $3;
	$atomName2             = $4;


	if (&writeAtom($atomName1,$atomName2))
	{

	    print FOUT "$atomNum1 $atomNum2\n";
	}

	
    }

sub writeAtom
{
    my $atomName1 = shift;
    my $retval   = 1;
    


    unless (($atomName1 eq "H") || ($atomName1 eq "HA"))
    {
    	$retval = 0;
	}
	
	my $atomCode2 = shift;
    	
	unless (($atomName2 eq "H") || ($atomName2 eq "HA"))
    {
		$retval = 0;
	}
    
    
    $retval;
}
}
