package chobxml::toolk::stack_restore;
use strict;
use chobxml::toolk;
use chobxml::toolk::lc;
use chobinfodig;



sub round {
  my $lc_hand;
  my $lc_stacklem;
  my $lc_mage;
  
  $lc_hand = $_[0];
  $lc_stacklem = $_[1];
  $lc_mage = $lc_hand->{&chobxml::toolk::magical()};
  
  
  #&chobinfodig::refnalyze("Bonzo",$lc_mage->{'data'}->{'fnc'}->{'char'}); sleep(2);
  
  if ( $lc_stacklem->{'type'} eq 'toolk' )
  {
    $lc_mage->{'tagset'} = $lc_stacklem->{'tagset'};
    $lc_mage->{'toolk'} = $lc_stacklem->{'toolk'};
    return;
  }
  
  if ( $lc_stacklem->{'type'} eq 'charf' )
  {
    &chobxml::toolk::lc::charfset($lc_hand,$lc_stacklem->{'charf'});
    return;
  }
}


1;
