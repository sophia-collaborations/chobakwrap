package chobak_style::basics;
use strict;
use chobak_style::tmplt;
use chobak_style::dlog::cls;
use chobak_fnc;

my $swaproo = [];

sub moreswaps {
  my $this;
  my $lc_msw;
  $this = shift;

  $lc_msw = $_[0];
  @$swaproo = (@$swaproo,@$lc_msw);
}

sub load {
  my $this;
  my $lc_found;
  my $lc_dth;
  my $lc_pthvar;
  my $lc_onabsent;
  my $lc_explain;
  my $lc_zerovar;
  my $lc_swpitem;
  $this = shift;

  $lc_zerovar = $_[0];
  # BEGIN SWAP PROCESSING
  foreach $lc_swpitem (@$swaproo)
  {
    my $lc2_a;
    $lc2_a = $lc_zerovar;

    if ( $lc_swpitem->[0] eq 'repl' )
    {
      if ( $lc_swpitem->[1] eq $lc_zerovar )
      {
        $lc2_a = $lc_swpitem->[2];
      }
    }

    if ( $lc_swpitem->[0] eq 'swap' )
    {
      if ( $lc_swpitem->[1] eq $lc_zerovar )
      {
        $lc2_a = $lc_swpitem->[2];
      }
      if ( $lc_swpitem->[2] eq $lc_zerovar )
      {
        $lc2_a = $lc_swpitem->[1];
      }
    }

    $lc_zerovar = $lc2_a;
  }
  # END SWAP PROCESSING
  
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
  
  if ( ! ( &chobak_fnc::pathfind($lc_zerovar,$lc_pthvar,$lc_found) ) )
  {
    if ( $lc_onabsent eq 'skip' ) { return; }
    if ( $lc_onabsent eq 'blank' )
    {
      $this->{'tmpl'}->{$_[1]} = &chobak_style::tmplt::new_blank();
      return;
    }
    if ( $lc_onabsent eq 'warn' )
    {
      print STDERR "WARNING: Missing Template: " . $lc_zerovar . ":\n";
      print STDERR $lc_explain;
      $this->{'tmpl'}->{$_[1]} = &chobak_style::tmplt::new_blank();
      return;
    }
    
    # The official default of $lc_onabsent is 'die'
    
    my $lc2_ech;
    $lc_dth = "\nFATAL ERROR: '" . $lc_zerovar . "' not found on path:\n";
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
