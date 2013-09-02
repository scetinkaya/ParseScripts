#!/usr/bin/perl -w

#usage: ./parseXpkFile.pl filename 

# given an input (xpeak) file, parses it to read and write the NOE chemical shifts.


$inputFile         = shift;
if ($inputFile =~ /(.*)\.xpk$/)
{
#      $outputFile = $1.".parsedXpk";
#      print STDERR "check out $outputFile\n";
#      open (FOUT, ">$outputFile");
  }
else
{
    die("error! file should be a xpk file and should finish with .xpk\n");
}

open (FIN, $inputFile) || 
    die ("couldn't open $inputFile (should be the xpk file)");


while ($line = <FIN>)
{
    &parseLine ($line);
}

sub parseLine 
{
    my $line           = shift;

#    if ($line =~ /^\d+\s{.*}\s(\d+\.\d+)\s\d+\.\d+\s\d+\.\d+\s\+\+\s0\.0\s{}\s{.*}\s(\d+\.\d+)\s\d+\.\d+\s\d+\.\d+\s\+\+\s0\.0\s{}\s{.*}\s(\d+\.\d+)\s\d+\.\d+\s\d+\.\d+\s\+\+\s0\.0\s{}\s\d+\.\d+\s\d+\.\d+\s\d\s{}\s0/)
    if ($line =~ /^\d+\s({.*})\s(\d+\.\d+)\s\d+\.\d+\s\d+\.\d+\s\+\+\s0\.0\s{}\s({.*})\s(\d+\.\d+)\s\d+\.\d+\s\d+\.\d+\s\+\+\s0\.0\s{}\s({.*})\s(\d+\.\d+)\s\d+\.\d+\s\d+\.\d+\s\+\+\s0\.0\s{}\s\d+\.\d+\s\d+\.\d+\s\d\s{}\s0/)
    {
#	$hn_ppm                = $1;
#	$h_ppm                 = $2;
#	$n_ppm                 = $3;

	$HN_id                 = $1;
#	$hn_ppm                = $2;
        $H_id                  = $3;
#	$h_ppm                 = $4;
	$N_id                  = $5;
#	$n_ppm                 = $6;
	
	

#	print STDOUT "$HN_id $hn_ppm $H_id $h_ppm $N_id $n_ppm\n";
	print STDOUT "$HN_id $H_id $N_id\n";
    }
}

