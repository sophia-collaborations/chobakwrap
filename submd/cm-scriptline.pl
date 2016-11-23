use strict;
my $preline;
my $itemo;

$preline = '#! ';

$itemo = `which perl`; chomp($itemo);
$preline .= $itemo;
$itemo = `which chobakwrap`; chomp($itemo);
$preline .= ' ' . $itemo . ' -run';

exec("echo",$preline);
