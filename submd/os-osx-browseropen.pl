use strict;
use argola;

my $appath = [
  '/Applications/Google Chrome.app',
  '/Applications/Safari.app'
];
my $appick;

sub pickapp {
  my $lc_a;
  foreach $lc_a (@$appath) {
    if ( -d $lc_a ) { return $lc_a; }
  }
  die "\nNO ELIGIBLE BROWSER APP FOUND:\n\n";
}

$appick = &pickapp();

while ( &argola::yet() )
{
  my $lc_a;
  $lc_a = &argola::getrg();
  system("open","-a",$appick,$lc_a);
}




