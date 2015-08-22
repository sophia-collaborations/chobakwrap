package chobak_routines;
use strict;
use argola;
use alarmica;
use chobaktime;
use plelorec;

my @als = ();

sub opto__f_o {
  my $lc_a;
  $lc_a = &argola::getrg();
  &alarmica::setout($lc_a);
  @als = (@als,"-o",$lc_a);
} &argola::setopt("-o",\&opto__f_o);


sub crun {
  my @lc_a;
  my $lc_b;
  my $lc_scr;
  my $lc_cnd;
  my $lc_today;
  
  $lc_today = &chobaktime::dayow();
  
  @lc_a = @_;
  $lc_b = @lc_a;
  if ( $lc_b < 0.5 ) { return; }
  $lc_scr = shift(@lc_a); $lc_b = @lc_a;
  while ( $lc_b > 0.5 )
  {
    $lc_cnd = shift(@lc_a);
    
    if ( $lc_cnd == $lc_today ) { &dorun($lc_scr); }
    
    $lc_b = @lc_a;
  }
}

sub dorun {
  plelorec::flplex($_[0],@als);
}

1;
