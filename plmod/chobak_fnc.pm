package chobak_fnc;
use strict;
use wraprg;


sub pathfind {
  my $lc_eachdir;
  my $lc_pathref;
  
  $lc_pathref = $_[1];
  
  foreach $lc_eachdir (@$lc_pathref)
  {
    my $lc2_a;
    $lc2_a = $lc_eachdir . '/' . $_[0];
    
    if ( -f $lc2_a )
    {
      $_[2] = $lc2_a;
      return ( 2 > 1 );
    }
  }
  return ( 1 > 2 );
  
}


sub hashfile {
  my @lc_arga;
  my $lc_numargs;
  my $lc_hashref;
  my $lc_argum;
  my $lc_cm;
  my $lc_cont;
  
  @lc_arga = @_;
  $lc_numargs = @lc_arga;
  if ( $lc_numargs < 1.5 ) { return; } # Nothing to do
  $lc_hashref = shift(@lc_arga);
  foreach $lc_argum (@lc_arga)
  {
    $lc_cm = 'cat';
    &wraprg::lst($lc_cm,$lc_argum);
    $lc_cont = `$lc_cm`;
    &hashblob($lc_hashref,$lc_cont);
  }
}

sub hashblob {
  my @lc_lines;
  my $lc_lino;
  
  @lc_lines = split(/\n/,$_[1]);
  foreach $lc_lino (@lc_lines)
  {
    &hashline($_[0],$lc_lino);
  }
}

sub hashline {
  my $lc_junk;
  my $lc_stg_pre; # ex-padding added
  my $lc_stga; # Precol junk removed
  my $lc_stgb; # Reversed to remove postcol junk
  my $lc_stgc; # Reversed with postcol junk removed
  my $lc_stgd; # Back in right order - without any junk left
  my $lc_nom;
  my $lc_val;
  
  if ( $_[1] eq '' ) { return; }
  $lc_stg_pre = 'xx' . $_[1] . 'xx';
  ($lc_junk,$lc_stga) = split(quotemeta(':'),$lc_stg_pre,2);
  $lc_stgb = scalar reverse $lc_stga;
  ($lc_junk,$lc_stgc) = split(quotemeta(':'),$lc_stgb,2);
  $lc_stgd = scalar reverse $lc_stgc;
  ($lc_nom,$lc_val) = split(quotemeta('='),$lc_stgd,2);
  if ( $lc_nom eq '' ) { return; }
  if ( ! ( defined($lc_nom) ) ) { return; }
  
  # Now we finally enter the result into the hash
  $_[0]->{$lc_nom} = $lc_val;
}


1;
