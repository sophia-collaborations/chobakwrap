package chobxml02::culprit;
use strict;

my $curfile = undef;

END {
  if ( defined($curfile) )
  {
    print STDERR ("\nCULPRIT FILE:\n    " . $curfile . ":\n\n");
  }
}

sub swap {
  my $lc_a;
  $lc_a = $curfile;
  $curfile = $_[0];
  return $lc_a;
}


1;
