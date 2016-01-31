package chobxml02::context;
use chobxml02::context::cls;

sub new {
  my $this;
  $this = chobxml02::context::cls->__raw_new;
  
  $this->{'tag-o'} = {}; # Opening handlers for known tags
  $this->{'tag-c'} = {}; # Closing handlers for known tags
  return $this;
}


1;
