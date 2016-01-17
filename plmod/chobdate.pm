package chobdate;
use strict;
use wraprg;

sub nowo {
  my $lc_ret;
  $lc_ret = `date +%s`;
  chomp($lc_ret);
  return $lc_ret;
}

sub atto {
  my $lc_cm;
  my $lc_rt;
  $lc_cm = "date -j -r";
  &wraprg::lst($lc_cm,$_[0]);
  $lc_cm .= " +%Y-%m-%d";
  $lc_rt = `$lc_cm`;
  chomp($lc_rt);
  return $lc_rt;
}

sub at_hr {
  my $lc_cm;
  my $lc_rt;
  $lc_cm = "date -j -r";
  &wraprg::lst($lc_cm,$_[0]);
  $lc_cm .= " +%H";
  $lc_rt = `$lc_cm`;
  chomp($lc_rt);
  return $lc_rt;
}

sub at_mn {
  my $lc_cm;
  my $lc_rt;
  $lc_cm = "date -j -r";
  &wraprg::lst($lc_cm,$_[0]);
  $lc_cm .= " +%M";
  $lc_rt = `$lc_cm`;
  chomp($lc_rt);
  return $lc_rt;
}

sub at_weekd {
  my $lc_cm;
  my $lc_rt;
  $lc_cm = "date -j -r";
  &wraprg::lst($lc_cm,$_[0]);
  $lc_cm .= " +%w";
  $lc_rt = `$lc_cm`;
  chomp($lc_rt);
  return $lc_rt;
}

sub cntro {
  my $lc_a;
  my $lc_hr;
  
  $lc_a = $_[0];
  $lc_hr = &at_hr($lc_a);
  while ( $lc_hr < 8.6 )
  {
    $lc_a = int(($lc_a + ( 60 * 60 )) + 0.2);
    $lc_hr = &at_hr($lc_a);
  }
  while ( $lc_hr > 15.5 )
  {
    $lc_a = int(($lc_a - ( 60 * 60 )) + 0.2);
    $lc_hr = &at_hr($lc_a);
  }
  
  $_[0] = $lc_a;
}

sub nexta {
  my $lc_a;
  
  $lc_a = $_[0];
  
  &cntro($lc_a);
  $lc_a = int($lc_a + ( 60 * 60 * 24 ) + 0.2);
  &cntro($lc_a);
  
  $_[0] = $lc_a;
  return &atto($lc_a);
}


1;
