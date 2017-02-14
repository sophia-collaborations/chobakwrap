use strict;

my $erras = 0;

my $diviso = "\n";


my $appresdir;
my @gitignores;

#print "This PERL script at: " . $0 . " \n";

$appresdir = `pwd`; chomp($appresdir);

sub chadira {
  my $lc_arg;
  my $lc_res;
  my $lc_dth;
  my $lc_local;
  foreach $lc_arg (@_)
  {
    $lc_res = chdir($lc_arg);
    if ( $lc_res < 0.5 )
    {
      $lc_local = `pwd`; chomp($lc_local);
      $lc_dth = "\n\nFATAL ERROR: Could not change directory:\n";
      $lc_dth .= "  From: " . $lc_local . ":\n";
      $lc_dth .= "    To: " . $lc_arg . ":\n";
      $lc_dth .= "\n";
      die($lc_dth);
    }
  }
}


sub errot {
  if ( $erras > 0.5 )
  {
    &chadira($appresdir);
    system("echo $erras > tmp/checkret.txt");
    exit(0);
  }
}

&chadira($appresdir);
{
  my $lc_a;
  $lc_a = `cat .gitignore`;
  @gitignores = split(/\n/,$lc_a);
}
sub gitigseek {
  my $lc_arg;
  foreach $lc_arg (@_) { &gitigsee_k($lc_arg); }
}
sub gitigsee_k {
  my $lc_arg;
  my $lc_line;
  $lc_arg = $_[0];
  foreach $lc_line (@gitignores)
  {
    if ( $lc_line eq $lc_arg ) { return; }
  }
  $erras = 2;
  print STDERR 'FATAL: Line Missing from .gitignore: ' . $lc_arg . ":\n";
}
sub from_gitis_yet {
  my $lc_arg;
  my $lc_line;
  my $lc_loca;
  $lc_arg = $_[0];
  foreach $lc_line (@gitignores)
  {
    if ( $lc_line eq $lc_arg ) { return; }
  }
  print STDERR $diviso . 'WARNING FUTURE-FATAL: Line Missing from .gitignore: ' . $lc_arg . ":\n";
  $diviso = '';
  $lc_loca = `pwd`; chomp($lc_loca);
  print STDERR "EDIT THIS FILE:\n  " . $lc_loca . "/.gitignore :\n";
  print STDERR '    Warning to pause for ' . $_[1] . ' seconds in proportion to time since implemented:' . "\n\n";
  if ( $_[1] > 0.5 ) { sleep($_[1]); }
}

sub from_gitseek {
  my $lc_now;
  my $lc_secs;
  my $lc_sqa;
  my @lc_sqb;
  my $lc_sqc;
  $lc_now = `date +%s`; chomp($lc_now);
  if ( $lc_now < $_[0] ) { return; }
  $lc_secs = int(($lc_now - $_[0]) / $_[1]);
  
  $lc_sqa = $_[3];
  @lc_sqb = @$lc_sqa;
  
  if ( $lc_secs > ($_[2] - 0.5) )
  {
    return &gitigseek(@lc_sqb);
  }
  foreach $lc_sqc (@lc_sqb) { &from_gitis_yet($lc_sqc,$lc_secs); }
}

# Added February 12, 2017
&from_gitseek(1487109871, int((60 * 60 * 24 * 3) + 0.2), 60, ['.DS_Store']);

&gitigseek('/tmp','/ins-opt-code','/build');
&errot;



