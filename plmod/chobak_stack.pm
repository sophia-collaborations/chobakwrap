package chobak_stack;
use chobak_stack::cls;
use strict;


sub new {
  my $this;
  $this = chobak_stack::cls->__raw_new;
  
  # Create the array that stores the stack's items.
  # This array will store the stack's items beginning with the
  # top of the stack and ending with the bottom.
  $this->{'lmn'} = [];
  
  return $this;
}


1;
