package chobak_help;
use wraprg;
use strict;

sub ofnroff {
  my $lc_cm;
  &argola::thatbeall($_[1]);
  $lc_cm = "cat";
  &wraprg::lst($lc_cm,$_[0]->{'nrfile'});
  $lc_cm .= ' | nroff -man | less';
  exec($lc_cm);
}

sub outsrc {
  my $lc_a;
  my @lc_b;
  &argola::thatbeall($_[1]);
  $lc_a = $_[0]->{'cmd'};
  @lc_b = @$lc_a;
  exec(@lc_b);
}


1;
