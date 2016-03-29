package chobak_style::basics;
use strict;
use chobak_style::tmplt;
use chobak_style::dlog::cls;
use chobak_fnc;

sub load {
  my $this;
  my $lc_found;
  my $lc_dth;
  my $lc_pthvar;
  my $lc_onabsent;
  my $lc_explain;
  $this = shift;
  
  $lc_explain = "  purpose: (no explanation provided):\n";
  if ( defined($_[2]) )
  {
    if ( $_[2] ne "" )
    {
      $lc_explain = "\n" . $_[2] . "\n\n";
    }
  }
  
  $lc_pthvar = $this->{'path'};
  $lc_onabsent = $this->{'pref'}->{'on-absent-template'};
  
  if ( ! ( &chobak_fnc::pathfind($_[0],$lc_pthvar,$lc_found) ) )
  {
    if ( $lc_onabsent eq 'skip' ) { return; }
    if ( $lc_onabsent eq 'blank' )
    {
      $this->{'tmpl'}->{$_[1]} = &chobak_style::tmplt::new_blank();
      return;
    }
    if ( $lc_onabsent eq 'warn' )
    {
      print STDERR "WARNING: Missing Template: " . $_[0] . ":\n";
      print STDERR $lc_explain;
      $this->{'tmpl'}->{$_[1]} = &chobak_style::tmplt::new_blank();
      return;
    }
    
    # The official default of $lc_onabsent is 'die'
    
    my $lc2_ech;
    $lc_dth = "\nFATAL ERROR: '" . $_[0] . "' not found on path:\n";
    $lc_dth .= $lc_explain;
    foreach $lc2_ech (@$lc_pthvar)
    {
      $lc_dth .= '   ' . $lc2_ech . "\n";
    }
    $lc_dth .= "\n";
    die $lc_dth;
  }
  
  $this->{'tmpl'}->{$_[1]} = &chobak_style::tmplt::new($lc_found);
}

sub dlog {
  my $this;
  my $lc_ret;
  $this = shift;
  
  $lc_ret = chobak_style::dlog::cls->__raw_new;
  $lc_ret->{'var'} = {};
  $lc_ret->{'tmpl'} = $this;
  
  return $lc_ret;
}

1;
