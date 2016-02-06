package chobxml02::rgpack::cls_char;
use strict;
use parent 'chobxml02::rgpack::bsc_in_all';

sub __raw_new {
  return bless {}, shift;
}

1;