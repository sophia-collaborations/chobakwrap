package chobak_jsonf::cls;
use parent 'chobak_jsonf::mainset', 'chobak_jsonf::do_absorb';
use strict;

sub __raw_new {
  return bless {}, shift;
}

1;
