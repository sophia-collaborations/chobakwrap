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

sub opto__f_rloc {
  my $lc_a;
  $lc_a = &argola::srcd();
  exec("echo",$lc_a);
  exit(0);
} &argola::setopt("-rloc",\&opto__f_rloc);

&argola::help_opt('--help-sound','manp/chobakwrap-sound.1');
&argola::help_opt('--help-caff','manp/chobakwrap-caff.1');

&argola::runopts;


