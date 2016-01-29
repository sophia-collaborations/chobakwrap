package chobxml::toolk::rgos::cls_char;
use strict;
use parent 'chobxml::toolk::rgos::bsc_char', 'chobxml::toolk::rgos::bsc_all';


sub __raw_new {
  return bless {}, shift;
}


1;
