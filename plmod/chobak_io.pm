package chobak_io;
use strict;

sub inln {
  # Read a line from standard input.
  my $lc_rt;
  my $lc_cr;
  $lc_rt = '';
  while ( 2 > 1 )
  {
    read STDIN, $lc_cr, 1;
    if ( $lc_cr eq "\n" ) { return $lc_rt; }
    $lc_rt .= $lc_cr;
  }
}

1;
