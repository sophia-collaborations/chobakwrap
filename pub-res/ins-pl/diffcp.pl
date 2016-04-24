use strict;
# This script is a stand-in for 'cp' that does the copying only if
# the two files are different from each other.
my $sorca;
my $desta;
my $difran;
my $cmdn;

($sorca,$desta) = @ARGV;
$cmdn = "diff";
&lst($cmdn,$sorca,$desta);
$difran = `$cmdn`; chomp($difran);
if ( $difran eq '' ) { exit(0); }
exec("cp",$sorca,$desta);




sub bsc {
  my $lc_ret;
  my $lc_src;
  my $lc_chr;
  $lc_src = scalar reverse $_[0];
  $lc_ret = "\'";
  while ( $lc_src ne "" )
  {
    $lc_chr = chop($lc_src);
    if ( $lc_chr eq "\'" ) { $lc_chr = "\'\"\'\"\'"; }
    $lc_ret .= $lc_chr;
  }
  $lc_ret .= "\'";
  return $lc_ret;
}

sub lst {
  my $lc_ret;
  my $lc_rem;
  my @lc_ray;
  @lc_ray = @_;
  $lc_rem = @lc_ray;
  if ( $lc_rem < 0.5 ) { return; }
  $lc_ret = shift(@lc_ray); $lc_rem = @lc_ray;
  while ( $lc_rem > 0.5 )
  {
    $lc_ret .= " " . &bsc(shift(@lc_ray));
    $lc_rem = @lc_ray;
  }
  $_[0] = $lc_ret;
}


