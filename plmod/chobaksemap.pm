package chobaksemap;
use strict;



sub flip {
  my $lc_flag;
  
  $lc_flag = $_[0] . '.flag';
  
  if ( -f $lc_flag )
  {
    system('rm','-rf',$lc_flag);
    return;
  }
  system('touch',$lc_flag);
}


sub smread {
  # This function takes a semap-base location and
  # returns the location to which read operations
  # should be directed.
  my $lc_flag;
  
  $lc_flag = $_[0] . '.flag';
  
  if ( -f $lc_flag )
  {
    return($_[0] . '-a');
  }
  return($_[0] . '-b');
}


sub smwrite {
  # This function takes a semap-base location and
  # returns the location to which write operations
  # should be directed.
  my $lc_flag;
  
  $lc_flag = $_[0] . '.flag';
  
  if ( -f $lc_flag )
  {
    return($_[0] . '-b');
  }
  return($_[0] . '-a');
}



1;
