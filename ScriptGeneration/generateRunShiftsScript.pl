#!/usr/bin/perl -w

#usage: ./generateRunShiftsScript.pl  filenamePrefix 

#prints to STDOUT lines like the following:
#~/Mist/Tools/shifts-4.1.1/src/shifts -qdb   1h8c_REF_froda_009800
#~/Mist/Tools/shifts-4.1.1/src/shifts '::H' 1h8c_REF_froda_009800 > 1h8c_REF_froda_009800.out2



unless (@ARGV)
{
    die("usage: ./generateRunShiftsScript.pl  filenamePrefix\n");
}
$filenamePrefix = shift;


for ($fileIndex = 100; $fileIndex <= 10000; $fileIndex = $fileIndex + 100)
{
    if ($fileIndex < 1000)
    {
	$filename = $filenamePrefix."_froda_000$fileIndex";
	print STDOUT "~/Mist/Tools/shifts-4.1.1/src/shifts -qdb -noreslib $filename\n";
	print STDOUT "~/Mist/Tools/shifts-4.1.1/src/shifts '::H' $filename > $filename.out2\n";
    }
    elsif ($fileIndex < 10000)
    {
	$filename = $filenamePrefix."_froda_00$fileIndex";
	print STDOUT "~/Mist/Tools/shifts-4.1.1/src/shifts -qdb  $filename\n";
	print STDOUT "~/Mist/Tools/shifts-4.1.1/src/shifts '::H' $filename > $filename.out2\n";
    }
    elsif ($fileIndex == 10000)
    {
	$filename = $filenamePrefix."_froda_010000";
	print STDOUT "~/Mist/Tools/shifts-4.1.1/src/shifts -qdb $filename\n";
	print STDOUT "~/Mist/Tools/shifts-4.1.1/src/shifts '::H' $filename > $filename.out2\n";
    }
}
