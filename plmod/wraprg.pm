package wraprg;
use strict;
use File::Basename;
use Cwd qw(realpath);



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

sub clct {
  my @lc_rgx;
  my $lc_count;
  my $lc_first;
  my $lc_ret;
  
  @lc_rgx = @_;
  $lc_count = @lc_rgx;
  if ( $lc_count < 0.5 ) { return ''; }
  
  $lc_first = shift(@lc_rgx);
  $lc_ret = &bsc($lc_first);
  
  if ( $lc_count > 1.5 )
  {
    &lst($lc_ret,@lc_rgx);
  }
  
  return $lc_ret;
}

sub rel_sm {
  my $lc_a;
  $lc_a = substr $_[1], 0, 1;
  if ( $lc_a eq '/' ) { return $_[1]; }
  if ( $_[0] eq '/' ) { return ( '/' . $_[1] ); }
  return ( $_[0] . '/' . $_[1] );
}


sub evalout {
  my $lc_src;
  my $lc_bgan;
  my @lc_out;
  my @lc_in;
  my @lc_parts;
  my $lc_parto;
  my $lc_good;
  my $lc_each; # Each part as we reassemble the resultant
  my $lc_ret; # Will become the reassembled resultant
  my $lc_div; # The divisor as we reassemble the resultant
  my $lc_gret; # The finally arrayref that we return.

  $lc_good = 10;

  # Both parts of the resultant start empty  
  @lc_out = ();
  @lc_in = ();

  # We need to obtain the source - including
  # info on whether or not it is an absolute
  # path.
  $lc_bgan = 0;
  $lc_src = $_[0];
  {
    my $lc2_a;
    $lc2_a = substr $_[0], 0, 1;
    if ( $lc2_a eq '/' )
    {
      $lc_bgan = 10;
      $lc_src = substr $_[0], 1;
    }
  }

  # Now we split the source string into parts
  @lc_parts = split(quotemeta('/'),$lc_src);

  foreach $lc_parto (@lc_parts)
  {
    my $lc2_ok;
    $lc2_ok = 10;

    if ( $lc_parto eq '.' ) { $lc2_ok = 0; }

    if ( $lc_parto eq '..' )
    {
      my $lc3_a;
      $lc3_a = @lc_in;
      if ( $lc3_a > 0.5 ) { pop(@lc_in); }
      if ( $lc3_a < 0.5 )
      {
        @lc_out = (@lc_out,'..');
        if ( $lc_bgan > 5 ) { $lc_good = 0; }
      }
      $lc2_ok = 0;
    }

    if ( $lc2_ok > 5 ) { @lc_in = (@lc_in,$lc_parto); }
  }
  
  $lc_ret = '';
  $lc_div = '';
  if ( $lc_bgan > 5 ) { $lc_ret = '/' }
  foreach $lc_each ((@lc_out,@lc_in))
  {
    $lc_ret .= $lc_div . $lc_each;
    $lc_div = '/';
  }

  # And now for the returning
  $lc_gret = [ ( $lc_good > 5 ), $lc_ret ];
  return $lc_gret;
}

sub abro {
  my $lc_a;
  my $lc_b;
  $lc_a = $_[0];
  $lc_b = `$lc_a`;
  return $lc_b;
}





1;
