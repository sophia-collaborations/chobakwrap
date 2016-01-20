package chobak_stack::digdown::res;
use strict;


sub all_yes {
  return ( 2 > 1 );
}

sub all_no {
  return ( 1 > 2 );
}

sub acod_yes {
  if ( ref($_[0]) eq 'CODE' ) { return $_[0]; }
  return \&all_yes;
}

sub acod_no {
  if ( ref($_[0]) eq 'CODE' ) { return $_[0]; }
  return \&all_no;
}




1;
