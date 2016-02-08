package chobak_fnc;
use strict;


sub pathfind {
  my $lc_eachdir;
  my $lc_pathref;
  
  $lc_pathref = $_[1];
  
  foreach $lc_eachdir (@$lc_pathref)
  {
    my $lc2_a;
    $lc2_a = $lc_eachdir . '/' . $_[0];
    
    if ( -f $lc2_a )
    {
      $_[2] = $lc2_a;
      return ( 2 > 1 );
    }
  }
  return ( 1 > 2 );
  
}


1;
