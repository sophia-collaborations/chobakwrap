package chobxml02::context::stackwind;
use strict;

sub action {
  my $lc_grg;
  $lc_grg = {};
  $lc_grg->{'gem'} = $_[0];
  $lc_grg->{'tag'} = $_[1];
  $_[0]->{'stack'}->digdown($lc_grg,{
    'check' => \&for_check,
    #'onyes' => \&for_onyes,
    'onno' => \&for_onno
  });
}

sub for_check {
  my $lc_itm;
  
  $lc_itm = $_[0]->see();
  return ( $lc_itm->{'typ'} eq 'tag' );
}

1;
