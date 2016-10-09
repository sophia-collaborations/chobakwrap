use strict;
my $uname_s;
my $uname_o;

sub aco {
  my $lc_a; my $lc_b;
  $lc_a = $_[0];
  $lc_b = `$lc_a`;
  chomp($lc_b);
  return $lc_b;
}
$uname_s = &aco("uname -s");
if ( $uname_s eq "Darwin" )
{
  exec("echo","osx");
}
if ( $uname_s eq "Linux" )
{
  $uname_o = &aco("uname -o");
  if ( $uname_o eq "GNU/Linux" ) { exec("echo","gnulinux"); }
}




exec("echo","x");

