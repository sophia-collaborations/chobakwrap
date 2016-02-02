package chobxml02::rgpack::bsc_in_tags;

sub mytag {
  # This function identifies what tag we are on.
  my $this;
  $this = shift;
  return $this->{'tag'};
}

sub pram {
  # This function retrieves one of the parameters passed
  # in the XML Open-tag.
  my $this;
  $this = shift;
  
  return $this->{'pram'}->{$_[0]};
}

1;
