package chobak_date::cls;
use strict;
use parent 'chobak_date::main','chobak_date::manip';

sub __raw_new {
  return bless {}, shift;
}

1;
