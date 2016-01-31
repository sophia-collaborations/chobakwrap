package chobxml02::context::basics;

sub tag {
  my $this;
  $this = shift;
  $this->{'tag-o'}->{$_[0]} = $_[1];
  $this->{'tag-c'}->{$_[0]} = $_[2];
}

1;
