package chobxml02::rgpack::cls_end;
use strict;
use parent 'chobxml02::rgpack::bsc_in_all', 'chobxml02::rgpack::bsc_in_tags', 'chobxml02::rgpack::bsc_end';

sub __raw_new {
  return bless {}, shift;
}

1;