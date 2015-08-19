use strict;
my $listera;
my @listerb;
my $listerc;
my $biktara;
my @biktarb;
my $biktarc;

$listera = `ls -1d plmod/*.pm`;
@listerb = split(/\n/,$listera);
foreach $listerc (@listerb)
{
  &golister($listerc);
}
sub golister {
  my $lc_res;
  if ( $_[0] eq "" ) { return; }
  
  $lc_res = $_[0];
  $biktara = `ls -1d ../*/$lc_res`;
  @biktarb = split(/\n/,$biktara);
  foreach $biktarc (@biktarb)
  {
    &valota($lc_res,$biktarc);
  }
}
sub valota {
  my $lc_sra;
  my $lc_srb;
  my $lc_dif;
  $lc_sra = $_[0];
  $lc_srb = $_[1];
  $lc_dif = `diff $lc_sra $lc_srb`;
  if ( $lc_dif eq "" ) { return; }
  #system("echo",$lc_dif);
  system("echo","SKREE:",$_[0] . ":", $_[1] . ":");
  system("cp",$_[0],$_[1]);
}

