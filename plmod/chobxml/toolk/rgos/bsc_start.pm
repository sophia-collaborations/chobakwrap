package chobxml::toolk::rgos::bsc_start;
use strict;
use chobxml::toolk;
use chobxml::toolk::lc;


sub chrset {
  my $this;
  my $lc_mage;
  my $lc_stk;
  my $lc_slem;
  $this = shift;
  $lc_mage = $this->{&chobxml::toolk::magical()};
  $lc_stk = $lc_mage->{'stack'};
  
  $lc_slem = {};
  $lc_slem->{'type'} = 'charf';
  $lc_slem->{'charf'} = &chobxml::toolk::lc::chrfget($this);
  @$lc_stk = (@$lc_stk,$lc_slem);
  
  &chobxml::toolk::lc::chrfset($this,$_[0]);
}

sub typ { return 'start'; }


1;
