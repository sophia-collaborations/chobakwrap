package chobxml::toolk::basics;


sub lm_start {
  my $lc_hand;
  my $lc_lem;
  my %lc_prm;
  my $lc_mth;
  my $lc_misca;
  
  ($lc_hand,$lc_lem,%lc_prm) = @_;
  $lc_misca = {};
  
  $lc_mth = $lc_hand->{'chobak_inf'}->{'tagset'}->{'tag_m_on'}->{$lc_lem};
  if ( ref($lc_mth) ne "CODE" )
  {
    $lc_mth = $lc_hand->{'chobak_inf'}->{'tagset'}->{'tag_g_on'};
  }
  
  # Create the stack element:
  
  # Fill the Second Argument:
  $lc_misca->{handle} = $lc_hand;
  $lc_misca->{'element'} = $lc_lem;
  $lc_misca->{param} = \%lc_prm;
  $lc_misca->{'text'} = "";
  
  return &$lc_mth($lc_hand->{'chobak_inf'}->{'data'},$lc_misca);
}

sub lm_end {
  my $lc_hand;
  my $lc_lem;
  my $lc_mth;
  my $lc_misca;
  
  ($lc_hand,$lc_lem) = @_;
  $lc_misca = {};
  
  $lc_mth = $lc_hand->{'chobak_inf'}->{'tagset'}->{'tag_m_off'}->{$lc_lem};
  if ( ref($lc_mth) ne "CODE" )
  {
    $lc_mth = $lc_hand->{'chobak_inf'}->{'tagset'}->{'tag_g_off'};
  }
  
  $lc_misca->{handle} = $lc_hand;
  $lc_misca->{'element'} = $lc_lem;
  $lc_misca->{param} = {};
  $lc_misca->{'text'} = "";
  
  return &$lc_mth($lc_hand->{'chobak_inf'}->{'data'},$lc_misca);
}

sub lm_char {
  my $lc_hand;
  my $lc_misca;
  my $lc_char;
  my $lc_mth;
  
  ($lc_hand,$lc_char) = @_;
  $lc_misca = {};
  
  $lc_mth = $lc_hand->{'chobak_inf'}->{'data'}->{'fnc'}->{'char'};
  
  $lc_misca->{handle} = $lc_hand;
  $lc_misca->{'element'} = "";
  $lc_misca->{param} = {};
  $lc_misca->{'text'} = $lc_char;
  
  return &$lc_mth($lc_hand->{'chobak_inf'}->{'data'},$lc_misca);
}


1;
