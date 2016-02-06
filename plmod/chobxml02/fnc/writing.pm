package chobxml02::fnc::writing;
use strict;

sub to_pen_raw {
  my $lc_pen;
  
  $lc_pen = $_[0]->{'gem'}->{'penpt'};
  $$lc_pen .= $_[0]->{'string'};
}


1;
