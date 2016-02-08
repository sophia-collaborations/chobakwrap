package chobak_style::dlog::basics;
use strict;

sub set {
  my $this;
  $this = shift;
  
  $this->{'var'}->{$_[0]} = $_[1];
}

sub run {
  my $this;
  my $lc_tmlist;
  my $lc_inssiz;
  my $lc_pointr;
  my $lc_func;
  my $lc_argum;
  my $lc_ret;
  my $lc_rfret;
  $this = shift;
  
  $lc_ret = '';
  $lc_rfret = \$lc_ret;
  
  $lc_tmlist = $this->{'tmpl'}->{'tmpl'}->{$_[0]}->{'alg'};
  if ( ref($lc_tmlist) ne 'ARRAY' )
  {
    die "\nFATAL ERROR: No such template: " . $_[0] . ":\n\n";
  }
  $lc_inssiz = @$lc_tmlist;
  $lc_pointr = 0;
  while ( ( $lc_pointr > ( 0 - 0.5 ) ) && ( $lc_pointr < ( $lc_inssiz - 0.5 ) ) )
  {
    $lc_func = $lc_tmlist->[$lc_pointr]->[0];
    $lc_argum = $lc_tmlist->[$lc_pointr]->[1];
    
    &$lc_func($lc_argum,$this->{'var'},$lc_rfret);
    # Remember --- the first argument (#0) is the
    # argument-element of the two-element array
    # (the argument generally being itself an array).
    # The second argument (#1) is the variable deck,
    # and the third argument (#2) is a reference to
    # the scalar where goeth the output.
    
    $lc_pointr = int($lc_pointr + 1.2);
  }
  
  return $lc_ret;
}

1;
