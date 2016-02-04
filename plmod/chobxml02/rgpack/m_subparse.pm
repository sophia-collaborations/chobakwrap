package chobxml02::rgpack::m_subparse;
use chobxml02;
use chobak_flf;
use strict;
use chobinfodig;
use chobxml02::context::uhood;
use chobxml02::culprit;
use wraprg;


sub subparse {
  my $this;
  my $lc_gem;
  my $lc_oldf;
  my $lc_olddir;
  my $lc_newf;
  my $lc_h_gem; # Holding place for what was on gem
  my $lc_h_larm; # Holding place for what was on alarm
  my $lc_prs;
  my $lc_cont; # Content of the New File:
  my @lc_ghnd;
  $this = shift;
  
  $lc_gem = $this->{'gem'};
  
  
  $lc_oldf = &chobak_flf::realpath($lc_gem->{'curfile'});
  $lc_olddir = &chobak_flf::k_gdr($lc_oldf);
  if ( substr($_[0],0,1) eq '/' )
  {
    $lc_newf = $_[0];
  } else {
    $lc_newf = $lc_olddir . '/' . $_[0];
  }
  if ( ! ( -f $lc_newf ) )
  {
    die "\nCan not find file:\n    " . $lc_newf . ":\n\n";
  }
  
  
  # Create the new parser:
  $lc_prs = XML::Parser::Expat->new;
  @lc_ghnd = &chobxml02::context::uhood::handlers();
  $lc_prs->setHandlers(
      'Start' => $lc_ghnd[0],
      'End' => $lc_ghnd[1],
      'Char' => $lc_ghnd[2]
  );
  $lc_prs->{&chobxml02::magickal()} = $lc_gem;
  
  
  
  # Obtain the file's contents:
  {
    my $lc2_c;
    $lc2_c = "cat";
    &wraprg::lst($lc2_c,$lc_newf);
    $lc_cont = `$lc2_c`;
  }
  
  
  
  # Register new file in the gem:
  $lc_h_gem = $lc_gem->{'curfile'};
  $lc_gem->{'curfile'} = $lc_newf;
  
  # Register new file in culpricy:
  $lc_h_larm = &chobxml02::culprit::swap($lc_newf);
  
  
  
  
  # Now --- the magic moment when we parse the
  # smaller file:
  $lc_prs->parse($lc_cont);
  
  
  
  
  # Back Out of Gem Registry
  $lc_gem->{'curfile'} = $lc_h_gem;
  
  # Back Out from Culpricy:
  &chobxml02::culprit::swap($lc_h_larm);
  
  
}














1;
