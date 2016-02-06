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

sub for_onno {
  my $lc_itm;
  my $lc_typ;
  
  # Identify the Item and it's Type
  $lc_itm = $_[0]->see();
  $lc_typ = $lc_itm->{'typ'};
  
  
  if ( $lc_typ eq 'context' )
  {
    $_[1]->{'gem'}->{'context'} = $lc_itm->{'cntx'};
    return ( 1 > 2 );
  }
  
  if ( $lc_typ eq 'charf' )
  {
    $_[1]->{'gem'}->{'charf'} = $lc_itm->{'charf'};
    return ( 1 > 2 );
  }
  
  if ( $lc_typ eq 'penpt' )
  {
    $_[1]->{'gem'}->{'penpt'} = $lc_itm->{'penpt'};
    return ( 1 > 2 );
  }
  
  
  
  
  
  
  # If nothing is found matching that type:
  die ( "\nFATAL ERROR: Unknown Stack-Element Type: " . $lc_typ . ":\n"
      . "  To rectify, start by looking at the following resource:\n"
      . "          Module: chobxml02::context::stackwind :\n"
      . "        Function: for_onno :\n"
  . "\n");
}

1;
