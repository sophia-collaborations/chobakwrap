package chobxml02::context::cls;
use parent 'chobxml02::context::basics', 'chobxml02::context::m_parsefrom';

sub __raw_new {
  return bless {}, shift;
}

1;
