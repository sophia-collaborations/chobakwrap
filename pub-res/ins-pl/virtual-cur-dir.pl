use strict;

my $acto_curdir;
my $sofr_act;
my $trail_act;
my $prev_act;

$acto_curdir = $ARGV[0];
$sofr_act = $acto_curdir;
$trail_act = '';

while ( 2 > 1 )
{
  my $lc_for;
  my $lc_rfake;
  
  $lc_for = $sofr_act . '/ins-opt-code/fake-dir.txt';
  if ( -f $lc_for )
  {
    $ENV{'XX_R_FAKE_XX'} = $lc_for;
    $lc_rfake = `cat \"\${XX_R_FAKE_XX}\"`;
    chomp($lc_rfake);
    exec("echo",($lc_rfake . $trail_act));
    exit(0);
  }
  
  $prev_act = $sofr_act;
  &transferi($sofr_act,$trail_act);
  
  if ( $prev_act eq '' )
  {
    exec("echo",($sofr_act . $trail_act));
    exit(0);
  }
}

sub transferi {
  my $lc_src;
  my $lc_dst;
  my $lc_chr;
  $lc_src = $_[0];
  $lc_dst = $_[1];
  if ( $lc_src eq '' ) { return; }
  $lc_chr = 'x';
  while ( $lc_chr ne '/' )
  {
    $lc_chr = chop($lc_src);
    $lc_dst = $lc_chr . $lc_dst;
    if ( $lc_src eq '' ) { $lc_chr = '/'; }
  }
  $_[0] = $lc_src;
  $_[1] = $lc_dst;
}


