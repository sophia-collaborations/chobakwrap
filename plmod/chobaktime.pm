package chobaktime;
use strict;
use argola;

sub nowo {
  my $lc_a;
  $lc_a = `date +%s`;
  chomp($lc_a);
  return $lc_a;
}

sub raw_dayow {
  my $lc_cnt;
  my $lc_sorc;
  my $lc_cmd;
  my $lc_ret;
  
  $lc_cnt = @_;
  $lc_sorc = $_[0];
  if ( $lc_cnt < 0.5 ) { $lc_sorc = &nowo; }
  $lc_cmd = "date -j -r";
  &argola::wraprg_lst($lc_cmd,$lc_sorc,"+%u");
  $lc_ret = `$lc_cmd`; chomp($lc_ret);
  
  return $lc_ret;
}

# dayow()
# Wraps around raw_dayow() for a week that starts on Sunday
# rather than Monday.
sub dayow {
  my $lc_cnt;
  my $lc_sorc;
  my $lc_ret;
  
  $lc_cnt = @_;
  $lc_sorc = $_[0];
  if ( $lc_cnt < 0.5 ) { $lc_sorc = &nowo; }
  $lc_ret = int(&raw_dayow($lc_sorc) + 1.2);
  if ( $lc_ret > 7.5 ) { $lc_ret = 1; }
  return $lc_ret;
}

sub ondays {
  my $lc_found;
  my $lc_each;
  my $lc_today;
  
  $lc_found = 0;
  $lc_today = &dayow();
  foreach $lc_each (@_)
  {
    if ( $lc_today == $lc_each )
    {
      $lc_found = 10;
    }
  }
  return ( $lc_found > 5 );
}

1;
