package chobxml::toolk::lc;


# THE FOLLOWING FUNCTIONS ARE EXPLICITLY AND SOLELY FOR THE PURPOSE OF
# ISOLATING STUFF THAT COULD POSSIBLY CHANGE IN THE FUTURE

sub chrfset {
  my $lc_mage;
  $lc_mage = $_[0]->{&chobxml::toolk::magical()};
  $lc_mage->{'data'}->{'fnc'}->{'char'} = $_[1];
}

sub chrfget {
  my $lc_mage;
  $lc_mage = $_[0]->{&chobxml::toolk::magical()};
  return ($lc_mage->{'data'}->{'fnc'}->{'char'});
}

sub setdatafnc {
  if ( ref($_[0]->{'data'}->{'fnc'}) ne 'HASH' )
  {
    $_[0]->{'data'}->{'fnc'} = {};
  }
  if ( ref($_[0]->{'data'}->{'fnc'}->{'char'}) ne 'CODE' )
  {
    $_[0]->{'data'}->{'fnc'}->{'char'} = $_[0]->{'tagset'}->{'char'}->{'dflt'};
  }
}

1;
