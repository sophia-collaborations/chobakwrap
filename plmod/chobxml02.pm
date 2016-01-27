package chobxml02;
use strict;




sub magickal {
  # This function simply returns the name of the object
  # used to embed all chobxml02-specific information in the
  # Expat parser. The element-name is taken from this function
  # so as to centralize it's hard-coding just in case it ever
  # needs to be changed.
  return 'chobak_inf';
}


1;
