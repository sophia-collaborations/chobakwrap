use strict;
use plelorec;
use argola;
use alarmica;

sub opto__f_run {
  my @lc_a;
  @lc_a = &argola::remrg;
  &plelorec::flplex(@lc_a);
} &argola::setopt("-run",\&opto__f_run);

sub opto__f_set {
  my $lc_a;
  $lc_a = &argola::getrg;
  &alarmica::regmsg($lc_a);
} &argola::setopt("-set",\&opto__f_set);

sub opto__f_entr {
}

&argola::runopts;


