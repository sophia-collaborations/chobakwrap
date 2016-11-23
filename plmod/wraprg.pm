package wraprg;
use strict;



sub bsc {
  my $lc_ret;
  my $lc_src;
  my $lc_chr;
  $lc_src = scalar reverse $_[0];
  $lc_ret = "\'";
  while ( $lc_src ne "" )
  {
    $lc_chr = chop($lc_src);
    if ( $lc_chr eq "\'" ) { $lc_chr = "\'\"\'\"\'"; }
    $lc_ret .= $lc_chr;
  }
  $lc_ret .= "\'";
  return $lc_ret;
}

sub lst {
  my $lc_ret;
  my $lc_rem;
  my @lc_ray;
  @lc_ray = @_;
  $lc_rem = @lc_ray;
  if ( $lc_rem < 0.5 ) { return; }
  $lc_ret = shift(@lc_ray); $lc_rem = @lc_ray;
  while ( $lc_rem > 0.5 )
  {
    $lc_ret .= " " . &bsc(shift(@lc_ray));
    $lc_rem = @lc_ray;
  }
  $_[0] = $lc_ret;
}

sub clct {
  my @lc_rgx;
  my $lc_count;
  my $lc_first;
  my $lc_ret;
  
  @lc_rgx = @_;
  $lc_count = @lc_rgx;
  if ( $lc_count < 0.5 ) { return ''; }
  
  $lc_first = shift(@lc_rgx);
  $lc_ret = &bsc($lc_first);
  
  if ( $lc_count > 1.5 )
  {
    &lst($lc_ret,@lc_rgx);
  }
  
  return $lc_ret;
}



1;