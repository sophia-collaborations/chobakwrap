package chobak_flf;
use strict;
use File::Basename;
use Cwd 'abs_path';

sub k_gdr {
  return dirname($_[0]);
}

sub realpath {
  return abs_path($_[0]);
}


1;
