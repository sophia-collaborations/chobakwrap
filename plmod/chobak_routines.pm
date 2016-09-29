package chobak_routines;
use strict;
use argola;
use alarmica;
use chobaktime;
use plelorec;

my @als = ();

# Sorts a copy of the array referenced in the second argument
# by value - returns element number Rg0 of that array to the
# calling program.
sub bestof_num {
  my $lc_ref;
  my @lc_presort;
  my @lc_postsort;
  
  $lc_ref = $_[1];
  @lc_presort = @$lc_ref;
  @lc_postsort = sort {$a <=> $b} @lc_presort;
  
  $lc_ref = $_[0];
  return $lc_postsort[$lc_ref]; 
}

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
