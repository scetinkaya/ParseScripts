#!/usr/bin/perl -w
#run it as:  stopAllProcesses.pl



for (;;)
{
#    for ($i = 0; $i < 2000000; $i++)
#    {
#    }
    $buffer = `ps -uapaydin | grep MATLAB`;

    if ($buffer)
    {
	@lines = split  /^/m, $buffer;
	foreach $line (@lines)
	{
	    chomp ($line);
	    print "line = $line.\n";
#	    if ($line =~ /^\s+(\d+).*$/)
	    if ($line =~ /(\d+)/)
	    {
		print "process id is $1.\n";
		`kill -9 $1`;
	    }
	    else
	    {
		print "could not parse line.\n";
	    }
	}
    }
    else
    {
	exit 0;
    }
}
