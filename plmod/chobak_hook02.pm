package chobak_hook02;
use strict;

sub onto {
  my @lc_allrg;
  my $lc_count;
  my $lc_hkry;
  my $lc_funct;
  
  @lc_allrg = @_;
  $lc_count = @lc_allrg;
  if ( $lc_count < 1.5 ) { return; }
  $lc_hkry = shift(@lc_allrg);
  $lc_funct = shift(@lc_allrg);
  @$lc_hkry = (@$lc_hkry, [$lc_funct,[@lc_allrg]]);
}

sub astrue {
  &aseval($_[0],\&eval_as_true);
}
sub eval_as_true {
  return $_[0];
}

sub aseval {
 my $lc_ref;
 my @lc_ry;
 my $lc_rnd;
 my $lc_fnc;
 my $lc_rgrf;
 my @lc_rgry;
 my $lc_eval;
 
 $lc_ref = $_[0];
 $lc_eval = $_[1];
 @lc_ry = @$lc_ref;
 while ( &yet(@lc_ry) )
 {
   $lc_rnd = shift(@lc_ry);
   $lc_fnc = $lc_rnd->[0];
   $lc_rgrf = $lc_rnd->[1];
   @lc_rgry = @$lc_rgrf;
   if ( !(&$lc_eval(&$lc_fnc(@lc_rgry))) ) { return; }
 }
}

sub asany {
 my $lc_ref;
 my @lc_ry;
 my $lc_rnd;
 my $lc_fnc;
 my $lc_rgrf;
 my @lc_rgry;
 
 $lc_ref = $_[0];
 @lc_ry = @$lc_ref;
 while ( &yet(@lc_ry) )
 {
   $lc_rnd = shift(@lc_ry);
   $lc_fnc = $lc_rnd->[0];
   $lc_rgrf = $lc_rnd->[1];
   @lc_rgry = @$lc_rgrf;
   &$lc_fnc(@lc_rgry);
 }
}

sub yet {
  my $lc_a;
  $lc_a = @_;
  return ( $lc_a > 0.5 );
}



1;
