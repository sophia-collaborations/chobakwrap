package chobak_cstruc;
use strict;
use List::Util qw(shuffle);

sub force_hash_has_array {
  if ( ref($_[0]) ne 'HASH' ) { return; }
  if ( ref($_[0]->{$_[1]}) ne 'ARRAY' ) { $_[0]->{$_[1]} = []; }
}

sub force_hash_has_hash {
  if ( ref($_[0]) ne 'HASH' ) { return; }
  if ( ref($_[0]->{$_[1]}) ne 'HASH' ) { $_[0]->{$_[1]} = {}; }
}

sub counto {
  my $lc_tot;
  my $lc_each;
  my @lc_ray;
  my $lc_num;
  
  $lc_tot = 0;
  foreach $lc_each (@_)
  {
    if ( ref($lc_each) eq 'ARRAY' )
    {
      @lc_ray = @$lc_each;
      $lc_num = @lc_ray;
      $lc_tot = int($lc_tot + $lc_num + 0.2);
    }
  }
  return $lc_tot;
}

sub within {
  # 0 - A scalar
  # 1 - An array-ref
  # ret - Does the scalar occur in the array?
  my $lc_each;
  my $lc_ry;
  $lc_ry = $_[1];
  foreach $lc_each (@$lc_ry)
  {
    if ( $lc_each eq $_[0] ) { return ( 10 > 5 ); }
  }
  return ( 0 > 5 );
}

# The function that distinguishes hats from stacks and
# queues is not the function that adds something to the
# array, but the function that removes something from
# the array --- the function that first shuffles and
# then takes.
sub ry_hat {
  &shfl($_[0]);
  return &ry_shift($_[0]);
}

sub ry_shift {
  my $lc_rf;
  my @lc_ry;
  my $lc_rt;
  
  $lc_rf = $_[0];
  $lc_rt = undef;
  if ( ref($lc_rf) ne 'ARRAY' ) { return $lc_rt; }
  if ( &counto($lc_rf) < 0.5 ) { return $lc_rt; }
  
  @lc_ry = @$lc_rf;
  $lc_rt = shift(@lc_ry);
  @$lc_rf = @lc_ry;
  return $lc_rt;
}

sub ry_push {
  my @lc_ray;
  my $lc_ref;
  
  @lc_ray = @_;
  $lc_ref = @lc_ray;
  if ( $lc_ref < 1.5 ) { return; }
  
  $lc_ref = shift(@lc_ray);
  if ( ref($lc_ref) ne 'ARRAY' ) { return; }
  
  @$lc_ref = (@$lc_ref,@lc_ray);
}

sub ry_m_push {
  my $lc_ref;
  my @lc_ray;
  my $lc_each;
  
  $lc_ref = $_[1];
  if ( ref($lc_ref) ne 'ARRAY' ) { return; }
  @lc_ray = @$lc_ref;
  foreach $lc_each (@lc_ray)
  {
    &ry_push($_[0],$lc_each);
  }
}

sub mshfl {
  my $lc_rg;
  foreach $lc_rg (@_) { &shfl($lc_rg); }
}

sub shfl {
  my $lc_ft;
  $lc_ft = $_[0];
  
  # Here is how we handle it if it is an array:
  if ( ref($lc_ft) eq 'ARRAY' )
  {
    my @lc2_a;
    my @lc2_b;
    
    @lc2_a = @$lc_ft;
    @lc2_b = shuffle(@lc2_a);
    @$lc_ft = @lc2_b;
    
    return;
  }
  
  # We may later find a different way to handle it
  # if it is a hash. First, of course, we'd have
  # to work out how exactly it's purpose could
  # make any sense if it's a hash.
}



1;
