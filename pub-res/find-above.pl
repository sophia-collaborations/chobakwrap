use strict;
my @allargs;
my $baselc;
my $noshow;
my $upwego = 100;

@allargs = @ARGV;
{
  my $lc_a;
  $lc_a = @allargs;
  if ( $lc_a < 1.5 ) { die "\nFATAL ERROR: Not Enough Arguments:\n\n"; }
}
$baselc = shift @allargs;
$noshow = shift @allargs;
@allargs = ($baselc,@allargs);
while ( $upwego > 0.5 )
{
  my $lc_each;
  my $lc_ok;
  my $lc_loc;
  $lc_ok = 10;
  foreach $lc_each (@allargs)
  {
    if ( !( -f $lc_each ) ) { $lc_ok = 0; }
  }
  if ( $lc_ok > 5 )
  {
    $lc_loc = `pwd`; chomp($lc_loc);
    print( $lc_loc . '/' . $baselc . "\n" );
    exit(0);
  }
  chdir('..');
  $upwego = int($upwego - 0.8);
}
print ( $noshow . "\n" );
exit(0);