package chobinfodig;
use Data::Dumper;

use Scalar::Util qw(blessed);
#use Scalar::Util qw(blessed dualvar isdual readonly refaddr reftype tainted weaken isweak isvstring looks_like_number set_prototype);
# See this doc: http://perldoc.perl.org/Scalar/Util.html

use strict;




sub dumping {
  print STDERR "\n" . $_[0] . ":\n" . Dumper($_[1]) . "\n\n";
}

sub dumpxx {
  my @lc_list;
  my $lc_noma;
  my $lc_toto;
  my $lc_counto;
  
  @lc_list = @_;
  $lc_toto = @lc_list;
  if ( $lc_toto < 1.5 ) { return; }
  $lc_noma = shift(@lc_list);
  $lc_toto = @lc_list;
  for ( $lc_counto = 0; $lc_counto < ( $lc_toto - 0.5 ); $lc_counto = int($lc_counto + 1.2))
  {
    &dumping(($_[0] . '-' . $lc_counto), $lc_list[$lc_counto]);
  }
}

sub dumpy {
  my $lc_max;
  my $lc_cnt;
  $lc_max = @_;
  $lc_cnt = 1;
  while ( $lc_cnt < ( $lc_max - 0.5 ) )
  {
    &dumping(($_[0] . ' ' . $lc_cnt),$_[$lc_cnt]);
    $lc_cnt = int($lc_cnt + 1.2);
  }
}

sub refnalyze {
  print STDERR "\n" . $_[0] . ": " . &refnalret($_[1]) . "\n";
}

sub refxx {
  my @lc_list;
  my $lc_noma;
  my $lc_toto;
  my $lc_counto;
  
  @lc_list = @_;
  $lc_toto = @lc_list;
  if ( $lc_toto < 1.5 ) { return; }
  $lc_noma = shift(@lc_list);
  $lc_toto = @lc_list;
  for ( $lc_counto = 0; $lc_counto < ( $lc_toto - 0.5 ); $lc_counto = int($lc_counto + 1.2))
  {
    &refnalyze(($_[0] . '-' . $lc_counto), $lc_list[$lc_counto]);
  }
}

sub refnalret {
  my $lc_argo;
  my $lc_type;
  my $lc_msg;
  my @lc_rayall;
  my $lc_rayval;
  my $lc_raysiz;
  
  $lc_msg = "";
  $lc_argo = $_[0];
  
  if ( !(defined($lc_argo)) )
  {
    return "Undefined Variable:\n";
  }
  
  if ( blessed($lc_argo) )
  {
    $lc_msg = "Blessed Object: ";
    $lc_msg .= ref($lc_argo);
    $lc_msg .= ":\n";
    @lc_rayall = keys %$lc_argo;
    foreach $lc_rayval (@lc_rayall)
    {
      $lc_msg .= '  ' . $lc_rayval . ":\n";
    }
    
    return $lc_msg;
  }
  
  
  
  $lc_type = ref($lc_argo);
  
  if ( $lc_type eq "ARRAY" )
  {
    @lc_rayall = @$lc_argo;
    $lc_raysiz = @lc_rayall;
    $lc_msg = "ARRAY of " . $lc_raysiz . " element";
    if ( $lc_raysiz > 1.5 ) { $lc_msg .= 's'; }
    if ( $lc_raysiz < 0.5 ) { $lc_msg .= 's'; }
    $lc_msg .= ":\n";
    return $lc_msg;
  }
  
  if ( $lc_type eq "HASH" )
  {
    @lc_rayall = keys %$lc_argo;
    $lc_msg = "HASH:\n";
    foreach $lc_rayval (@lc_rayall)
    {
      $lc_msg .= '  ' . $lc_rayval . ":\n";
    }
    
    return $lc_msg;
  }
  
  if ( $lc_type eq '' )
  {
    $lc_msg = "Not a reference: " . $lc_argo . ":\n";
    return $lc_msg;
  }
  
  $lc_msg = "Unknown Type: " . $lc_type . ":\n";
  return $lc_msg;
}


1;