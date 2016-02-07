package chobxml02::rgpack::bsc_in_tags;
use strict;
use parent 'chobxml02::rgpack::m_subparse';

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

sub tgdata {
  my $this;
  $this = shift;
  
  return($this->{'tagdata'});
}

sub untag {
  my $this;
  $this = shift;
  
  $this->{'gem'}->{'context'}->untag($_[0]);
}

sub tag {
  my $this;
  $this = shift;
  
  $this->{'gem'}->{'context'}->tag(@_);
}

1;
