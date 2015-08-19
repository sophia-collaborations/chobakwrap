package mirans;
use strict;


sub nm {
  my $lc_src;
  my $lc_rem;
  my $lc_dst;
  my $lc_chr;
  
  ($lc_src,$lc_rem) = @_;
  $lc_dst = "";
  while ( $lc_rem > 0.5 )
  {
    $lc_src = "00" . $lc_src;
    $lc_chr = chop($lc_src);
    $lc_dst = $lc_chr . $lc_dst;
    $lc_rem = int($lc_rem - 0.8);
  }
  return $lc_dst;
}

sub hrx {
  my $lc_hrx;
  my $lc_min;
  my $lc_res;
  ($lc_hrx,$lc_min) = @_;
  $lc_res = int( ( $lc_hrx * 60 ) + $lc_min + 0.2 );
  return $lc_res;
}

sub cmd_fnd {
  my $lc_prdr;
  my $lc_acon;
  
  $lc_prdr = $ENV{"HOME"};
  $lc_prdr .= "/.choremaster";
  $lc_acon = @_;
  if ( $lc_acon < 0.5 )
  {
    return $lc_prdr;
  }
  $lc_prdr .= "/" . $_[0];
}



1;
