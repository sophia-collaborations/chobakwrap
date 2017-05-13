use strict;
use argola;

my $thetarget;
$thetarget = &argola::getrg();
if ( !(-d $thetarget) )
{
  die("\nNO SUCH DIRECTORY: " . $thetarget . ":\n\n");
}

exec("open",$thetarget);
