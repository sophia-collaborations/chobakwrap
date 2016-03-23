package chobdate02;
# A more refined date-management package:
use strict;


sub digits {
  my $lc_src;
  my $lc_dest;
  my $lc_left;
  my $lc_chr;
  
  $lc_src = $_[1];
  $lc_dest = '';
  
  $lc_left = $_[0];
  while ( $lc_left > 0.5 )
  {
    $lc_src = '00' . $lc_src;
    $lc_chr = chop($lc_src);
    $lc_dest = $lc_chr . $lc_dest;
    
    $lc_left = int($lc_left - 0.8);
  }
  
  return $lc_dest;
}

sub idigits {
  return digits($_[0],int($_[1] + 0.2));
}

sub noonint {
  my $lc_cmd;
  my $lc_ret;
  
  $lc_cmd = "date -j -f %Y-%m-%d-%H-%M-%S ";
  $lc_cmd .= &idigits(4,$_[0]) . '-';
  $lc_cmd .= &idigits(2,$_[1]) . '-';
  $lc_cmd .= &idigits(2,$_[2]) . '-';
  $lc_cmd .= '12-00-00 +%s';
  
  $lc_ret = `$lc_cmd`;
  chomp($lc_ret);
  return $lc_ret;
}

sub getmyd {
  my $lc_cmd;
  my $lc_ret;
  my @lc_exp;
  
  $lc_cmd = "date -j -f %s " . int($_[0] + 0.2);
  $lc_cmd .= ' +%Y-%m-%d';
  
  $lc_ret = `$lc_cmd`;
  chomp($lc_ret);
  @lc_exp = split(quotemeta('-'),$lc_ret);
  
  return @lc_exp;
}

sub getinf {
  # 0 = Year
  # 1 = Month
  # 2 = Day of month
  # 3 = Day of week
  my $lc_cmd;
  my $lc_ret;
  my @lc_exp;
  
  $lc_cmd = "date -j -f %s " . int($_[0] + 0.2);
  $lc_cmd .= ' +%Y-%m-%d-%u';
  
  $lc_ret = `$lc_cmd`;
  chomp($lc_ret);
  @lc_exp = split(quotemeta('-'),$lc_ret);
  
  # Proof day-of-week: Let Sunday be first:
  {
    my $lc2_a;
    $lc2_a = $lc_exp[3];
    if ( $lc_exp[3] > 6.5 ) { $lc2_a = 0; }
    $lc_exp[3] = int($lc2_a + 1.2);
  }
  
  return @lc_exp;
}

sub advanso {
  my $lc_k;
  my $lc_noona;
  my $lc_noonb;
  my @lc_ret;
  
  $lc_k = $_[0];
  
  $lc_noona = &noonint($lc_k->[0],$lc_k->[1],$lc_k->[2]);
  $lc_noonb = int($lc_noona + ( $_[1] * 60 * 60 * 24 ) + 0.2 );
  @lc_ret = &getmyd($lc_noonb);
  @$lc_k = @lc_ret;
}

sub moreabout {
  my $lc_k;
  my $lc_noona;
  my @lc_ret;
  
  $lc_k = $_[0];
  
  $lc_noona = &noonint($lc_k->[0],$lc_k->[1],$lc_k->[2]);
  @lc_ret = &getinf($lc_noona);
  return @lc_ret;
}


1;
