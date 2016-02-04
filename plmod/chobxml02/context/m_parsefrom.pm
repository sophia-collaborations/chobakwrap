package chobxml02::context::m_parsefrom;
use chobxml02;
use strict;
use XML::Parser::Expat;
use chobxml02::context::uhood;
use chobxml02::rgpack::cls_flush;
use chobxml02::rgpack::cls_init;
use wraprg;
use chobak_stack;
use chobxml02::culprit;

sub parsefrom {
  my $this;
  my $lc_cm;
  my $lc_cont;
  my $lc_prs;
  my @lc_ghnd;
  my $lc_gem;
  my $lc_rgpk;
  my $lc_blfunc;
  my $lc_arref;
  my $lc_spculp;
  $this = shift;
  
  
  if ( ! ( -f $_[0] ) )
  {
    die ("\nNo such file:\n  " . $_[0] . ":\n\n");
  }
  
  # If we are still alive - we mine the contents of the file.
  $lc_cm = "cat";
  &wraprg::lst($lc_cm,$_[0]);
  $lc_cont = `$lc_cm`;
  
  
  $lc_prs = XML::Parser::Expat->new;
  @lc_ghnd = &chobxml02::context::uhood::handlers();
  $lc_prs->setHandlers(
      'Start' => $lc_ghnd[0],
      'End' => $lc_ghnd[1],
      'Char' => $lc_ghnd[2]
  );
  
  # Create a Reference Form of Arguments:
  $lc_arref = [];
  @$lc_arref = @_;
  
  # Build the Gem
  $lc_gem = {};
  $lc_gem->{'context'} = $this;
  $lc_gem->{'charf'} = $this->{'dfl-chr'};
  $lc_gem->{'stack'} = &chobak_stack::new();
  $lc_gem->{'data'} = {};
  $lc_gem->{'args'} = $lc_arref;
  $lc_gem->{'curfile'} = $_[0];
  
  
  $lc_prs->{&chobxml02::magickal()} = $lc_gem;
  
  
  
  
  # Before parsing - we do the initing.
  
  $lc_rgpk = chobxml02::rgpack::cls_init->__raw_new;
  $lc_rgpk->{'gem'} = $lc_gem;
  $lc_rgpk->{'expat'} = $lc_prs;
  
  $lc_blfunc = $lc_gem->{'context'}->{'initf'};
  &$lc_blfunc($lc_rgpk);
  
  
  
  
  
  # Here cometh the magic moment when we parse!!!
  
  $lc_spculp = &chobxml02::culprit::swap($_[0]);
  
  $lc_prs->parse($lc_cont);
  
  &chobxml02::culprit::swap($lc_spculp);
  
  
  
  
  # Now after parsing -- we do the flushing.
  
  $lc_rgpk = chobxml02::rgpack::cls_flush->__raw_new;
  $lc_rgpk->{'gem'} = $lc_gem;
  $lc_rgpk->{'expat'} = $lc_prs;
  
  $lc_blfunc = $lc_gem->{'context'}->{'flushf'};
  &$lc_blfunc($lc_rgpk);
}

1;


