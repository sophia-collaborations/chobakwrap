use strict;
# This program installs all manual-pages that a package has
# directed for installation.
my $hme;    # Home directory:
my $mandir; # Location of place on manpath that you install on.
my $contena;
my @contenb;
my $contenc;
my $pubresdir; # Location of pub-res directory of chobakwrap:


# If there are no manual-pages to install, then our job
# is done.
if ( ! ( -f 'man-pages.txt' ) ) { exit(0); }

# The pub-res directory should be provided through
# the command line:
$pubresdir = $ARGV[0];


# Find HOME and set default of man-install spot:
$hme = $ENV{"HOME"};
$mandir = $hme . "/share/man";


# Find the value of man-install spot even if it is not the default
sub wrp {
  my $lc_cn;
  $lc_cn = $_[0];
  $lc_cn =~ s/quotemeta("'")/"'\"'\"'"/g;
  $lc_cn = "'" . $lc_cn . "'";
  return $lc_cn;
}
sub past_default{
  my $lc_cm;
  my $lc_vl;
  $lc_cm = 'perl ' . &wrp($pubresdir . '/find-above.pl') . ' ins-opt-code/dir-of-manpage.txt x install.sh';
  $lc_vl = `$lc_cm`; chomp($lc_vl);
  if ( $lc_vl eq 'x' ) { return; }
  $mandir = $lc_vl;
}
&past_default();


$contena = `cat man-pages.txt`;
@contenb = split(/\n/,$contena);
foreach $contenc (@contenb) { &placeit($contenc); }
sub placeit {
  my $lc_sr;
  my $lc_dr;
  my $lc_ds;
  my $lc_loca;
  ($lc_sr,$lc_dr,$lc_ds) = split(/:/,$_[0]);
  
  # In a valid line, none of the three items should be
  # empty.
  if ( $lc_sr eq '' ) { return; }
  if ( $lc_dr eq '' ) { return; }
  if ( $lc_ds eq '' ) { return; }
  
  $lc_loca = `pwd`; chomp($lc_loca);
  
  if ( ! ( -f $lc_sr ) )
  {
    print STDERR "\nWARNING: No such file: " . $lc_loca . '/' . $lc_sr . ":\n\n";
  }
  
  #system("mkdir","-p",($mandir . '/' . $lc_dr));
  #system("cp",$lc_sr,($mandir . '/' . $lc_dr . '/' . $lc_ds));
  system("rm","-rf",($mandir . '/' . $lc_dr . '/' . $lc_ds));
}

