package chobak_date;
use strict;
use chobak_date::cls;

sub new {
  my $this;
  my $lc_a;
  
  $lc_a = `date +%s`; chomp($lc_a);
  
  $this = chobak_date::cls->__raw_new;
  $this->{'raw'} = $lc_a;
  
  return $this;
}


1;
