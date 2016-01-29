package chobxml::toolk::rgos::cls_end;
use strict;
use parent 'chobxml::toolk::rgos::bsc_end', 'chobxml::toolk::rgos::bsc_all';


sub __raw_new {
  return bless {}, shift;
}


1;
