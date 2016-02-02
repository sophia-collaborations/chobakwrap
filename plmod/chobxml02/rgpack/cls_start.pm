package chobxml02::rgpack::cls_start;
use strict;
use parent 'chobxml02::rgpack::bsc_in_all', 'chobxml02::rgpack::bsc_in_tags', 'chobxml02::rgpack::bsc_start';

sub __raw_new {
  return bless {}, shift;
}

1;