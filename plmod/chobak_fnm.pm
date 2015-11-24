package chobak_fnm;
use strict;


# The following grabs just one extension off of the end of a filename specified
# in argument #0 and places it in the string that is argument #1. Upon success,
# it does this, saves everything that is left of the filename back to argument
# #0, and returns 'true'. Upon failure, it saves an empty string on
# argument #1, leaves argument #0 untouched, and returns 'false'.
sub oneext {
  my $lc_src;
  my $lc_chr;
  my $lc_ext;
  
  $lc_src = $_[0];
  $_[1] = "";
  
  while ( $lc_src ne "" )
  {
    $lc_chr = chop($lc_src);
    
    if ( $lc_chr eq "." )
    {
      my $lc3_a;
      my $lc3_b;
      $lc3_a = $lc_src;
      if ( $lc3_a eq "" ) { return ( 1 > 2 ); }
      $lc3_b = chop($lc3_a);
      if ( $lc3_b eq "/" ) { return ( 1 > 2 ); }
      
      $_[0] = $lc_src;
      $_[1] = $lc_ext;
      return ( 2 > 1 );
    }
    
    if ( $lc_chr eq "/" ) { return ( 1 > 2 ); }
    
    $lc_ext = $lc_chr . $lc_ext;
  }
  
  return ( 1 > 2 );
}


1;
