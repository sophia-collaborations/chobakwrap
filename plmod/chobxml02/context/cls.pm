package chobxml02::context::cls;
use parent 'chobxml02::context::basics';

sub __raw_new {
  return bless {}, shift;
}

1;
