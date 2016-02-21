package chobak_date;
use strict;
use chobak_date::cls_ymd;
use chobak_date::cls_md;

sub new_ymd {
  my $this;
  
  $this = chobak_date::cls_ymd->__raw_new;
  $this->{'typ'} = 'ymd';
  
  return $this;
}

sub new_md {
  my $this;
  
  die "\n"
  . "The 'new_md' form of the 'chobak_date' class is not\n"
  . "yet supported.\n"
  . "\n";
  
  $this = chobak_date::cls_md->__raw_new;
  $this->{'typ'} = 'md';
  
  return $this;
}

1;
