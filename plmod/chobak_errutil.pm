package chobak_errutil;
use strict;

sub erfunc {
  my $lc_a;
  $lc_a = $_[0]->{'errorinfo'};
  if ( ref($lc_a) ne 'HASH' ) { $lc_a = {}; }
  $lc_a->{'errid'} = $_[1];
  $lc_a->{'explain'} = $_[2];
  $_[0]->{'errorinfo'} = $lc_a;
  return ( 1 > 2 );
}

1;
