package chobak_json;
# WARNING: Programs that use this library will not work unless
# the following CPAN modules are installed:
#   JSON

use strict;
use JSON::PP;
use wraprg;

# Arg 0: SOURCE: JSON string
# Arg 1: DESTIN: PerlRef to data decoded from JSON string
#      ([] if the JSON string is not valid)
# RETURN: true - if the JSON string is valid -- false - if otherwise
sub safe {
  my $lc_ok;
  my $lc_rsl;
  $lc_ok = 0;
  eval {
    $lc_rsl = decode_json($_[0]);
    $lc_ok = 10;
  };
  if ( $lc_ok > 5 )
  {
    $_[1] = $lc_rsl;
  } else {
    $_[1] = [];
  }
  return ( $lc_ok > 5 );
}


# Arg 0: SOURCE: JSON string
# RETURN: true - if the JSON string is valid -- false - if otherwise
sub test {
  my $lc_a;
  $lc_a = 0;
  eval {
    decode_json($_[0]);
    $lc_a = 10;
  };
  return ( $lc_a > 5 );
}


sub tojson {
  return encode_json($_[0]);
}

sub readf {
  my $lc_cm;
  my $lc_con;
  my $lc_ret;
  
  if ( !(-f $_[0]) ) { return []; }
  $lc_cm = "cat " . &wraprg::bsc($_[0]);
  $lc_con = `$lc_cm`;
  &safe($lc_con,$lc_ret);
  return $lc_ret;
}

sub savef {
  my $lc_cm;
  $lc_cm = "| cat > " . &wraprg::bsc($_[1]);
  open TAKRAT, $lc_cm;
  print TAKRAT &tojson($_[0]);
  print TAKRAT "\n";
  close TAKRAT;
}


# Clones the data referenced in Arg 0 by converting it
# to JSON and back - and saves the reference to the
# clone in Arg 1.
sub clone {
  my $lc_js;
  my $lc_ok;
  my $lc_cl;
  
  $lc_js = &tojson($_[0]);
  $lc_ok = &safe($lc_js,$lc_cl);
  $_[1] = $lc_cl;
  return $lc_ok;
}



1;
