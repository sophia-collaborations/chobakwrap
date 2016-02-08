package chobak_style::tmplt::util;
use strict;

sub raw_out {
  my $lc_neos;
  my $lc_rfret;
  
  $lc_rfret = $_[2];
  $lc_neos = $_[0]->[0];
  $$lc_rfret .= $lc_neos;
}


sub var_esc {
  my $lc_neos;
  my $lc_varios;
  my $lc_rfret;
  
  $lc_rfret = $_[2];
  $lc_varios = $_[0]->[0];
  
  
  $lc_neos = &escap($_[1]->{$lc_varios});
  $$lc_rfret .= $lc_neos;
}


sub var_lit {
  my $lc_neos;
  my $lc_varios;
  my $lc_rfret;
  
  $lc_rfret = $_[2];
  $lc_varios = $_[0]->[0];
  
  
  $lc_neos = $_[1]->{$lc_varios};
  $$lc_rfret .= $lc_neos;
}


sub escap {
  # A copy of function of same name in: chobxml02::fnc::writing
  my $lc_strg;
  
  $lc_strg = $_[0];
  
  $lc_strg =~ s/&/&amp;/g;
  $lc_strg =~ s/</&lt;/g;
  $lc_strg =~ s/>/&gt;/g;
  $lc_strg =~ s/"/&quot;/g;
  $lc_strg =~ s/'/&apos;/g;
  
  return $lc_strg;
}


1;
