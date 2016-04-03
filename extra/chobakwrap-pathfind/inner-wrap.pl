use strict;
use argola;

my $target;
my $pathfull;
my @pathbits;
my $patheach;
my $suspect;

$target = &argola::getrg();
$pathfull = &argola::getrg();
@pathbits = split(quotemeta(':'),$pathfull);
foreach $patheach (@pathbits)
{
  $suspect = $patheach . '/' . $target;
  if ( -f $suspect ) { exec('echo',$suspect); }
}