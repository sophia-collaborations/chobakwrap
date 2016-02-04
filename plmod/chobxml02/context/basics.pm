package chobxml02::context::basics;

sub tag {
  my $this;
  $this = shift;
  $this->{'tag-o'}->{$_[0]} = $_[1];
  $this->{'tag-c'}->{$_[0]} = $_[2];
}

sub untag {
  my $this;
  $this = shift;
  $this->tag($_[0],undef,undef);
}

sub flush {
  my $this;
  $this = shift;
  $this->{'flushf'} = $_[0];
}

sub initf {
  my $this;
  $this = shift;
  $this->{'initf'} = $_[0];
}

sub misc {
  my $this;
  $this = shift;
  $this->{'gnr-o'} = $_[0];
  $this->{'gnr-c'} = $_[1];
}

1;
