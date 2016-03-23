package chobak_style::tmplt::time;
use strict;

my @ary_month_l = (
  'January','February','March',
  'April','May','June',
  'July','August','September',
  'October','November','December'
);

my @ary_day_l = (
  'Sunday','Monday','Tuesday',
  'Wednesday','Thursday','Friday',
  'Saturday'
);

sub var_month_l {
  my $lc_neos;
  my $lc_varios;
  my $lc_rfret;
  
  $lc_rfret = $_[2];
  $lc_varios = $_[0]->[0];
  
  
  $lc_neos = $_[1]->{$lc_varios};
  
  # Translate it to month:
  $lc_neos = $ary_month_l[int($lc_neos - 0.8)];
  
  $$lc_rfret .= $lc_neos;
}

sub var_day_l {
  my $lc_neos;
  my $lc_varios;
  my $lc_rfret;
  
  $lc_rfret = $_[2];
  $lc_varios = $_[0]->[0];
  
  
  $lc_neos = $_[1]->{$lc_varios};
  
  # Translate it to day:
  $lc_neos = $ary_day_l[int($lc_neos - 0.8)];
  
  $$lc_rfret .= $lc_neos;
}


sub var_int {
  my $lc_neos;
  my $lc_varios;
  my $lc_rfret;
  
  $lc_rfret = $_[2];
  $lc_varios = $_[0]->[0];
  
  
  $lc_neos = $_[1]->{$lc_varios};
  
  # Assure it is an integer:
  $lc_neos = int($lc_neos + 0.2);
  
  $$lc_rfret .= $lc_neos;
}


1;
