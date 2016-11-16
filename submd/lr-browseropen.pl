use strict;
use argola;
use wraprg;

while ( &argola::yet() ) { &goforth(&argola::getrg()); }
sub goforth {
  my $lc_cm;
  system("echo",("\nAttempting to open HTML page:\n  " . $_[0] . "\n"));
  
  $lc_cm;
  $lc_cm = "firefox " . &wraprg::bsc($_[0]);
  $lc_cm .= ' &bg;';
  $lc_cm = '( ' . $lc_cm . ' ) > /dev/null 2> /dev/null';
  system($lc_cm);
}


