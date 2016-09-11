package chobak_jsonf::cls;
use parent 'chobak_jsonf::mainset';
use strict;

sub __raw_new {
  return bless {}, shift;
}

1;
