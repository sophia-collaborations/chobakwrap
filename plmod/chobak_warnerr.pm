package chobak_warnerr;
use strict;
# A library to manage the gradual deprecation of a program's
# feature.
use wraprg;
use me::modus;


sub prima_one {
  # rg0 = warning message
  # rg1 = error message
  # rg2 = Start warning hold-up period (YYYY-MM-DD--HH-MM-SS)
  # rg3 = # of days between second-increase in warning hold-up
  # rg4 = Time of Full Feature Discontinuation (YYYY-MM-DD--HH-MM-SS)
  my $lc_starto;
  my $lc_endo;
  my $lc_cm;
  my $lc_curo;
  my $lc_delay;
  
  # Find when hold-up period starts:
  $lc_cm = 'date -j -f %Y-%m-%d--%H-%M-%S ' . &wraprg::bsc($_[2]) . ' +%s';
  $lc_starto = `$lc_cm`; chomp($lc_starto);
  
  # Find when hold-up period expires:
  $lc_cm = 'date -j -f %Y-%m-%d--%H-%M-%S ' . &wraprg::bsc($_[4]) . ' +%s';
  $lc_endo = `$lc_cm`; chomp($lc_endo);
  
  # And where are we?
  $lc_curo = `date +%s`; chomp($lc_curo);
  if ( $lc_curo > $lc_endo ) { die ( &me::modus::alr_out() . $_[1]); }
  
  $lc_delay = int( ( ( $lc_curo - $lc_starto ) / ( 60 * 60 * 24 * $_[3] ) ) + 1 );
  print STDERR $_[0];
  sleep($lc_delay);
}


1;
