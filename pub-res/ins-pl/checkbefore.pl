use strict;

my $erras = 0;


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

&gitigseek('/tmp','/ins-opt-code','/build');
&errot;



