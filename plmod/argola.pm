package argola;
use chobak_help;
use strict;

my @argbuft;
my @argbufp;
my $versono;
my $resorco;
my %opthash = {};
my @optlist = ();

@argbuft = @ARGV;
$versono = &getrg();
$resorco = &getrg();
@argbufp = @argbuft;


sub getrg {
  my $lc_a;
  my $lc_ret;
  $lc_a = @argbuft;
  $lc_ret = "";
  if ( $lc_a > 0.5 ) { $lc_ret = shift(@argbuft); }
  return $lc_ret;
}

sub remrg {
  return @argbuft;
}

sub setopt {
  @optlist = ( @optlist, $_[0] );
  $opthash{$_[0]} = {
    'func' => $_[1],
    'typ' => 'a',
    'pram' => undef,
  };
}

sub setoptp {
  @optlist = ( @optlist, $_[0] );
  $opthash{$_[0]} = {
    'func' => $_[1],
    'typ' => 'b',
    'pram' => $_[2],
  };
}

sub runopts {
  my $lc_crg;
  my $lc_ech;
  my $lc_found;
  my $lc_mth;
  my $lc_pram;
  my $lc_typ;
  my $lc_yot;
  while ( &yet() )
  {
    $lc_crg = &getrg();
    $lc_found = 0;
    foreach $lc_ech (@optlist)
    {
      if ( $lc_ech eq $lc_crg )
      {
        my $lc3_rc;
        $lc3_rc = $opthash{$lc_ech};
        $lc_mth = $lc3_rc->{'func'};
        $lc_pram = $lc3_rc->{'pram'};
        $lc_typ = $lc3_rc->{'typ'};
        $lc_found = 10;
      }
    }
    if ( $lc_found < 5 )
    {
      die "\n" . $_[0] . ": FATAL ERROR:\nUnknown Option: " . $lc_crg . ":\n\n";
    }
    
    $lc_yot = ( 2 > 1 );
    if ( $lc_yot )
    {
      if ( $lc_typ eq 'a' )
      {
        &$lc_mth(undef,$lc_crg);
        $lc_yot = ( 1 > 2 );
      }
    }
    if ( $lc_yot )
    {
      &$lc_mth($lc_pram,$lc_crg);
    }
  }
}

sub thatbeall {
  if ( &yet() )
  {
    die "\nFATAL ERROR:\n" .
      "  Too many arguments after '" . $_[0] . "' option:\n\n";
    "\n";
  }
}

sub rset {
  @argbuft = @argbufp;
}

sub vrsn {
  return $versono;
}

sub srcd {
  return $resorco;
}

sub yet {
  my $lc_a;
  $lc_a = @argbuft;
  return ( $lc_a > 0.5 );
}

sub remo {
  my @lc_tua;
  @lc_tua = @argbuft;
  @argbuft = ();
  return @lc_tua;
}

sub help_opt {
  my $lc_hlpf;
  
  $lc_hlpf = $resorco . '/' . $_[1];
  &setoptp($_[0],\&chobak_help::ofnroff,{
    'nrfile' => $lc_hlpf,
  });
}

sub txt_help_opt {
  my $lc_hlpf;
  
  $lc_hlpf = $resorco . '/' . $_[1];
  &setoptp($_[0],\&chobak_help::oftxhlp,{
    'txhfile' => $lc_hlpf,
  });
}

sub txt_spit_opt {
  my $lc_hlpf;
  
  $lc_hlpf = $resorco . '/' . $_[1];
  &setoptp($_[0],\&chobak_help::oftxspt,{
    'txhfile' => $lc_hlpf,
  });
}

sub osorc_opt {
  my @lc_ray;
  my $lc_lem;
  
  @lc_ray = @_;
  $lc_lem = @lc_ray;
  if ( $lc_lem < 1.5 ) { die "\nInsufficient arguments to argola::osorc_opt:\n\n"; }
  $lc_lem = shift @lc_ray;
  
  &setoptp($_[0],\&chobak_help::outsrc,{
    'cmd' => [@lc_ray],
  });
}


# The following function is now known as "bsc"
# in the "wraprg" module. The copy here will
# eventually be replaced with a mere wrapper
# for the "wraprg" version -- and the only
# reason why it is not being purged altogether
# is for the sake of backward compatibility.
sub wrparg_bsc {
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


# The following function is now known as "lst"
# in the "wraprg" module. The copy here will
# eventually be replaced with a mere wrapper
# for the "wraprg" version -- and the only
# reason why it is not being purged altogether
# is for the sake of backward compatibility.
sub wraprg_lst {
  my $lc_ret;
  my $lc_rem;
  my @lc_ray;
  @lc_ray = @_;
  $lc_rem = @lc_ray;
  if ( $lc_rem < 0.5 ) { return; }
  $lc_ret = shift(@lc_ray); $lc_rem = @lc_ray;
  while ( $lc_rem > 0.5 )
  {
    $lc_ret .= " " . &wrparg_bsc(shift(@lc_ray));
    $lc_rem = @lc_ray;
  }
  $_[0] = $lc_ret;
}



1;
