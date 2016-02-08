package chobak_style::cls;
use strict;
use parent 'chobak_style::basics';


sub __raw_new {
  return bless {}, shift;
}


1;
