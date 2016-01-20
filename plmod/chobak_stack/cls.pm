package chobak_stack::cls;
use parent 'chobak_stack::mainset','chobak_stack::digdown';
use strict;

sub __raw_new {
  return bless {}, shift;
}



1;
