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



1;
