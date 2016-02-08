package chobak_style::tmplt::cls;
use strict;
use parent 'chobak_style::tmplt::basics';

sub __raw_new {
  return bless {}, shift;
}

1;
