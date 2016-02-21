package chobak_help;
use wraprg;
use strict;

sub ofnroff {
  my $lc_cm;
  $lc_cm = "cat";
  &wraprg::lst($lc_cm,$_[0]->{'nrfile'});
  $lc_cm .= ' | nroff -man | less';
  exec($lc_cm);
}


1;
