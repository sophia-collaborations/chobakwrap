package chobak_date::main;
use strict;
use chobaktime;

sub year {
  my $this;
  $this = shift;
  return &chobaktime::nm_g_year($this->{'raw'});
}

sub month {
  my $this;
  $this = shift;
  return &chobaktime::nm_g_month($this->{'raw'});
}

sub dayom {
  my $this;
  $this = shift;
  return &chobaktime::nm_g_dayom($this->{'raw'});
}

sub hour {
  my $this;
  $this = shift;
  return &chobaktime::nm_g_hour($this->{'raw'});
}

sub min {
  my $this;
  $this = shift;
  return &chobaktime::nm_g_min($this->{'raw'});
}

sub sec {
  my $this;
  $this = shift;
  return &chobaktime::nm_g_sec($this->{'raw'});
}

sub stamp {
  my $this;
  my $ret;
  $this = shift;
  
  $ret = $this->year();
  $ret .= '-' . $this->month() . $this->dayom();
  $ret .= '-' . $this->hour() . $this->min() . $this->sec();
  return $ret;
}

sub clone {
  my $this;
  my $that;
  $this = shift;
  $that = chobak_date::cls->__raw_new;
  $that->{'raw'} = $this->{'raw'};
  return $that;
}


1;
