package chobaktime;
use strict;
use wraprg;

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
  &wraprg::lst($lc_cmd,$lc_sorc,"+%u");
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

sub nm_g_year {
  my $lc_cnt;
  my $lc_sorc;
  my $lc_cmd;
  my $lc_ret;
  
  $lc_cnt = @_;
  $lc_sorc = $_[0];
  if ( $lc_cnt < 0.5 ) { $lc_sorc = &nowo; }
  $lc_cmd = "date -j -r";
  &wraprg::lst($lc_cmd,$lc_sorc,"+%Y");
  $lc_ret = `$lc_cmd`; chomp($lc_ret);
  
  return $lc_ret;
}

sub nm_g_month {
  my $lc_cnt;
  my $lc_sorc;
  my $lc_cmd;
  my $lc_ret;
  
  $lc_cnt = @_;
  $lc_sorc = $_[0];
  if ( $lc_cnt < 0.5 ) { $lc_sorc = &nowo; }
  $lc_cmd = "date -j -r";
  &wraprg::lst($lc_cmd,$lc_sorc,"+%m");
  $lc_ret = `$lc_cmd`; chomp($lc_ret);
  
  return $lc_ret;
}

sub nm_g_hour {
  my $lc_cnt;
  my $lc_sorc;
  my $lc_cmd;
  my $lc_ret;
  
  $lc_cnt = @_;
  $lc_sorc = $_[0];
  if ( $lc_cnt < 0.5 ) { $lc_sorc = &nowo; }
  $lc_cmd = "date -j -r";
  &wraprg::lst($lc_cmd,$lc_sorc,"+%H");
  $lc_ret = `$lc_cmd`; chomp($lc_ret);
  
  return $lc_ret;
}

sub nm_g_min {
  my $lc_cnt;
  my $lc_sorc;
  my $lc_cmd;
  my $lc_ret;
  
  $lc_cnt = @_;
  $lc_sorc = $_[0];
  if ( $lc_cnt < 0.5 ) { $lc_sorc = &nowo; }
  $lc_cmd = "date -j -r";
  &wraprg::lst($lc_cmd,$lc_sorc,"+%M");
  $lc_ret = `$lc_cmd`; chomp($lc_ret);
  
  return $lc_ret;
}

sub nm_g_sec {
  my $lc_cnt;
  my $lc_sorc;
  my $lc_cmd;
  my $lc_ret;
  
  $lc_cnt = @_;
  $lc_sorc = $_[0];
  if ( $lc_cnt < 0.5 ) { $lc_sorc = &nowo; }
  $lc_cmd = "date -j -r";
  &wraprg::lst($lc_cmd,$lc_sorc,"+%S");
  $lc_ret = `$lc_cmd`; chomp($lc_ret);
  
  return $lc_ret;
}

sub nm_g_dayom {
  my $lc_cnt;
  my $lc_sorc;
  my $lc_cmd;
  my $lc_ret;
  
  $lc_cnt = @_;
  $lc_sorc = $_[0];
  if ( $lc_cnt < 0.5 ) { $lc_sorc = &nowo; }
  $lc_cmd = "date -j -r";
  &wraprg::lst($lc_cmd,$lc_sorc,"+%d");
  $lc_ret = `$lc_cmd`; chomp($lc_ret);
  
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

sub tsubdv {
  my $lc_rema;
  my $lc_subta;
  my $lc_ret;
  my $lc_chr;
  my $lc_dwn;
  
  # First we do the dividing and remainding
  $lc_rema = ( $_[0] % $_[1] );
  $lc_subta = int(($_[0] - $lc_rema) + 0.2);
  $_[0] = int(($lc_subta / $_[1]) + 0.2);
  
  # Now we do the zero-padding
  $lc_dwn = $_[2];
  $lc_ret = '';
  while ( $lc_dwn > 0.5 )
  {
    $lc_rema = '00' . $lc_rema;
    $lc_chr = chop($lc_rema);
    $lc_ret = $lc_chr . $lc_ret;
    $lc_dwn = int($lc_dwn - 0.8);
  }
  return $lc_ret;
}

1;
