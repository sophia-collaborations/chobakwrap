package chobak_style::tmplt::warn;
use chobak_style::tmplt::util;
use chobxml02::culprit;
use strict;



sub mainwarn {
  my $lc_bufari;
  $lc_bufari = '';
  &chobak_style::tmplt::util::go_through($_[0]->[1],$_[1],\$lc_bufari);
  
  print STDERR "\nWARNING:\n" . &chobxml02::culprit::identify() . "\n" . $lc_bufari . "\n\n";
  sleep($_[0]->[0]);
}


1;
