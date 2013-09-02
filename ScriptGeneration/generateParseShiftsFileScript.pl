#!/usr/bin/perl -w

#usage: ./generateParseShiftsFileScript.pl filenamePrefix 

#prints to STDOUT lines like the following:
#cat 1h8c_REF_froda_000100.out1  1h8c_REF_froda_000100.out2 > 1h8c_REF_froda_000100.SHIFTS_Raw.m
#~/Mist/Scripts/parseSHIFTSFile.pl  1h8c_REF_froda_000100.SHIFTS_Raw.m
#mv MySHIFTS MySHIFTS.100
#mv MySHIFTS_N_andH_WrittenSeparately.txt MySHIFTS_N_andH_WrittenSeparately.txt.100
unless (@ARGV)
{
    die("usage: ./generateParseShiftsFileScript.pl  filenamePrefix\n");
}
$filenamePrefix = shift;

for ($fileIndex = 100; $fileIndex <= 10000; $fileIndex = $fileIndex + 100)
{
    if ($fileIndex < 1000)
    {
	$filename = $filenamePrefix."_froda_000$fileIndex";
    }
    elsif ($fileIndex < 10000)
    {
	$filename = $filenamePrefix."_froda_00$fileIndex";
    }
    elsif ($fileIndex == 10000)
    {
	$filename = $filenamePrefix."_froda_010000";
    }
    print STDOUT "cat $filename.out1 $filename.out2 > $filename.SHIFTS_Raw.m\n";
    print STDOUT "~/Mist/Scripts/parseSHIFTSFile.pl $filename.SHIFTS_Raw.m\n";
    print STDOUT "mv MySHIFTS MySHIFTS.$fileIndex\n";
    print STDOUT "mv MySHIFTS_N_andH_WrittenSeparately.txt MySHIFTS_N_andH_WrittenSeparately.txt.$fileIndex\n";
}



