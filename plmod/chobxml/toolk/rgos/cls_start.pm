package chobxml::toolk::rgos::cls_start;
use strict;
use parent 'chobxml::toolk::rgos::bsc_start', 'chobxml::toolk::rgos::bsc_all';


sub __raw_new {
  return bless {}, shift;
}


1;
