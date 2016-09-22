package chobak_jsonf::mainset;
use chobak_json;
use strict;

sub cont {
  my $this;
  $this = shift;
  
  return($this->{'cont'});
}

sub save {
  my $this;
  my $lc_fnc;
  $this = shift;
  
  &chobak_json::savef($this->{'cont'},$this->{'write'});
  $lc_fnc = $this->{'swap'};
  &$lc_fnc($this);
  system('rm','-rf',$this->{'write'});
}

sub reffile {
  my $this;
  my $lc_a;
  $this = shift;
  
  $lc_a = $this->{'base'} . '.ref';
  return $lc_a;
}

1;

