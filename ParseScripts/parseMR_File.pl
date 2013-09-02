#!/usr/bin/perl -w

#usage: ./parseMR_File.pl filename 

# given a MR file, parses it to read and write the H,N chemical shifts


$inputFile         = shift;

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile");


while ($line = <FIN>)
{
    if ($line =~ /^RES\_ID\s+(\d+)/)
    {
	$resId = $1; $N_CS = -1;

	while ($line = <FIN>) 
	{
	    if ($line =~ /^END\_RES\_DEF/)
	    {
		last;
	    }

	    if ($line =~ /\s+N\s+(\d+\.\d+)/)
	    {
		$N_CS = $1;
	    }
	    elsif ($line =~ /\s+HN\s+(\d+\.\d+)/)
	    {
		$H_CS = $1;
	    }
	}

	if ($N_CS != -1)
	{
	    print "$resId $N_CS $H_CS\n";
	}
    }
}

