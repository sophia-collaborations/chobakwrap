package chobxml02::rgpack::bsc_start;


sub morph {
  my $this;
  my $lc_gem;
  $this = shift;
  
  $lc_gem = $this->{'gem'};
  
  $lc_gem->{'stack'}->on({
    'typ' => 'context',
    'cntx' => $lc_gem->{'context'}
  });
  
  $lc_gem->{'context'} = $_[0];
}


1;
