package chobak_stack::mainset;
use strict;

sub siz {
  my $this;
  my $lc_ryrf;
  my $lc_sizo;
  $this = shift;
  
  $lc_ryrf = $this->{'lmn'};
  $lc_sizo = @$lc_ryrf;
  return $lc_sizo;
}

sub on {
  my $this;
  my $lc_arg;
  my $lc_ryrf;  
  $this = shift;
  
  $lc_ryrf = $this->{'lmn'};
  foreach $lc_arg (@_)
  {
    @$lc_ryrf = ($lc_arg,@$lc_ryrf);
  }
}

sub off {
  my $this;
  my $lc_ryrf;
  my $lc_sizo;
  my $lc_ret;
  $this = shift;
  
  $lc_ryrf = $this->{'lmn'};
  $lc_sizo = @$lc_ryrf;
  if ( $lc_sizo < 0.5 ) { return undef; }
  
  $lc_ret = shift(@$lc_ryrf);
  return $lc_ret;
}


1;
