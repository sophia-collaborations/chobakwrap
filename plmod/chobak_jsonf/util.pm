package chobak_jsonf::util;
use strict;

sub smp_on {
  my $this;
  $this = $_[0];
  system('touch',$this->{'flag'});
  $this->{'swap'} = \&smp_off;
  $this->{'read'} = $this->{'fnb'};
  $this->{'write'} = $this->{'fna'};
}

sub smp_off {
  my $this;
  $this = $_[0];
  system('rm','-rf',$this->{'flag'});
  $this->{'swap'} = \&smp_on;
  $this->{'read'} = $this->{'fna'};
  $this->{'write'} = $this->{'fnb'};
}

1;
