use strict;
use argola;
use wraprg;

my $editro = &findeditro();
sub findeditro {
  my $lc_ret;
  my $lc_res;
  
  #$lc_res = `which wra`; chomp($lc_res);
  #if ( $lc_res ne '' )
  $lc_res = `wra -ok`; chomp($lc_res);
  if ( $lc_res eq 'yes' )
  {
    $lc_ret = ['wra'];
    return $lc_ret;
  }
  
  $lc_ret = ['vi'];
  return $lc_ret;
}

while ( &argola::yet() ) { &doaround(); }
sub doaround {
  my $lc_a;
  my $lc_b;
  my $lc_dir;
  my $lc_bas;
  my $lc_cmb;
  my $lc_rdir;
  
  $lc_a = &argola::getrg();
  $lc_b = "dirname " . &wraprg::bsc($lc_a);
  $lc_dir = `$lc_b`; chomp($lc_dir);
  if ( !(-d ($lc_dir . '/.')) ) { return; }
  
  $lc_b = "basename " . &wraprg::bsc($lc_a);
  $lc_bas = `$lc_b`; chomp($lc_bas);
  
  $lc_b = "chobakwrap -sub realpath " . &wraprg::bsc($lc_dir);
  $lc_rdir = `$lc_b`; chomp($lc_rdir);
  
  $lc_cmb = $lc_rdir . '/' . $lc_bas;
  
  system('echo',@$editro,$lc_cmb);
  system(@$editro,$lc_cmb);
}



