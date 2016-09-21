package chobak_jsonf::do_absorb;
use chobak_jsonf;
use strict;


sub absorb {
  my $this;
  my $lc_src;
  $this = shift;
  $lc_src = $_[0];
  
  $this->{'base'} = $lc_src->{'base'};
  $this->{'flag'} = $lc_src->{'flag'};
  $this->{'fna'} = $lc_src->{'fna'};
  $this->{'fnb'} = $lc_src->{'fnb'};
  $this->{'swap'} = $lc_src->{'swap'};
  $this->{'read'} = $lc_src->{'read'};
  $this->{'write'} = $lc_src->{'write'};
  $this->{'cont'} = $lc_src->{'cont'};
}

sub refresh {
  my $this;
  my $lc_neo;
  $this = shift;
  $lc_neo = &chobak_jsonf::new($this->{'base'});
  $this->absorb($lc_neo);
  return $this->{'cont'};
}


1;
