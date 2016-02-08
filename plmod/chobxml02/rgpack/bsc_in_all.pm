package chobxml02::rgpack::bsc_in_all;
use strict;
use chobxml02::fnc::writing;

sub gldata {
  my $this;
  $this = shift;
  
  return ($this->{'gem'}->{'data'});
}

sub wrraw { # NOT TESTED YET --- SO BE CAREFUL:
  my $this;
  my $lc_pen;
  my $lc_typ;
  $this = shift;
  
  $lc_pen = $lc_pen = $this->{'gem'}->{'penpt'};
  $lc_typ = ref($lc_pen);
  
  if ( $lc_typ eq 'SCALAR' )
  {
    $$lc_pen .= $_[0];
  }
}

sub wresc { # NOT TESTED YET --- SO BE CAREFUL:
  my $this;
  my $lc_pen;
  my $lc_typ;
  $this = shift;
  
  $lc_pen = $lc_pen = $this->{'gem'}->{'penpt'};
  $lc_typ = ref($lc_pen);
  
  if ( $lc_typ eq 'SCALAR' )
  {
    $$lc_pen .= &chobxml02::fnc::writing::escap($_[0]);
  }
}

sub argum {
  my $this;
  my $lc_argrf;
  my $lc_argtot;
  $this = shift;
  
  $lc_argrf = $this->{'gem'}->{'args'};
  $lc_argtot = @$lc_argrf;
  if ( $lc_argtot < ( $_[0] + 0.5 ) ) { return undef; }
  return ($lc_argrf->[$_[0]]);
}

1;
