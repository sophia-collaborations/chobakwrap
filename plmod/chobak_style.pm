package chobak_style;
use strict;
use chobak_style::cls;

sub new {
  my $this;
  $this = chobak_style::cls->__raw_new;
  
  $this->{'path'} = [@_];
  $this->{'tmpl'} = {}; # The Array of Parsed Template objects
  
  return $this;
}


1;
