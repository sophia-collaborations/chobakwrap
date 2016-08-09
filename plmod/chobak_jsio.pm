package chobak_jsio;
# WARNING: Programs that use this library will not work unless
# the following CPAN modules are installed:
#   JSON

use strict;
use chobak_json;
use chobak_io;

my $hotlist;
{
  my $lc_loc;
  $lc_loc = `chobakwrap -rloc`; chomp($lc_loc);
  $lc_loc .= '/pub-res/acnt.json';
  $hotlist = &chobak_json::readf($lc_loc);
}

sub inln {
  my $lc_a;
  my $lc_each;
  my $lc_ol;
  my $lc_nu;
  $lc_a = &chobak_io::inln();
  foreach $lc_each (@$hotlist)
  {
    $lc_ol = quotemeta($lc_each->[0]);
    $lc_nu = $lc_each->[1];
    $lc_a =~ s/$lc_ol/$lc_nu/g;
  }
  return $lc_a;
}


1;
