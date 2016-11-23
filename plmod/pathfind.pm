package pathfind;
use strict;

my $chk_lkup = {
  'file' => \&check_file,
};

sub llsearch {
}

sub search {
}


sub check_file {
  my $lc_ret;
  $lc_ret = { 'ok' => (1>2) };
  if ( -f $_[0] )
  {
    $lc_ret->{'ok'} = (2>1);
    $lc_ret->{'loc'} = $_[0];
  }
  return $lc_ret;
}



1;
