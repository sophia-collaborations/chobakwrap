package chobak_errutil;
use strict;

sub erfunc {
  $_[0]->{'errcode'} = $_[1];
  $_[0]->{'errexp'} = $_[2];
  return ( 1 > 2 );
}

1;
