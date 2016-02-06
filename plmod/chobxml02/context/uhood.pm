package chobxml02::context::uhood;
use strict;
use chobxml02;
use chobxml02::rgpack::cls_start;
use chobxml02::rgpack::cls_char;
use chobxml02::rgpack::cls_end;
use chobxml02::context::stackwind;
use chobinfodig;


sub handlers {
  my @lc_ret;
  
  @lc_ret = ( \&hand_start, \&hand_end, \&hand_char );
  return @lc_ret;
}

sub hand_start {
  my $lc_rgpk;
  my $lc_parser;
  my $lc_tag;
  my %lc_trib;
  my $lc_blfunc;
  my $lc_onclo_func;
  my $lc_gem;
  
  ($lc_parser,$lc_tag,%lc_trib) = @_;
  
  # First, we create and set up the Argument Pack object
  $lc_rgpk = chobxml02::rgpack::cls_start->__raw_new;
  $lc_gem = $lc_parser->{&chobxml02::magickal()};
  $lc_rgpk->{'gem'} = $lc_gem;
  $lc_rgpk->{'expat'} = $lc_parser;
  $lc_rgpk->{'pram'} = \%lc_trib;
  $lc_rgpk->{'tag'} = $lc_tag;
  $lc_rgpk->{'tagdata'} = {};
  
  # Next, we identify the function that we are going to use.
  $lc_blfunc = $lc_gem->{'context'}->{'tag-o'}->{$lc_tag};
  if ( ref($lc_blfunc) ne 'CODE' )
  {
    $lc_blfunc = $lc_gem->{'context'}->{'gnr-o'};
  }
  
  # Next, we identify the function that we will use at
  # tag-closing time.
  $lc_onclo_func = $lc_gem->{'context'}->{'tag-c'}->{$lc_tag};
  if ( ref($lc_onclo_func) ne 'CODE' )
  {
    $lc_onclo_func = $lc_gem->{'context'}->{'gnr-c'};
  }
  
  # We then add a 'tag' element to the stack.
  $lc_gem->{'stack'}->on({
    'typ' => 'tag',
    'tag' => $lc_tag,
    'dat' => $lc_rgpk->{'tagdata'},
    'pram' => \%lc_trib,
    'close' => $lc_onclo_func,
  });
  
  # Finally, we call the function.
  &$lc_blfunc($lc_rgpk);
}

sub hand_end {
  my $lc_parser;
  my $lc_tag;
  my $lc_rgpk;
  my $lc_blfunc;
  my $lc_gem;
  my $lc_stklem;
  
  ($lc_parser,$lc_tag) = @_;
  
  # First we create and set up the *basics* of
  # the Argument Pack object -- though more setting
  # up will need to be done later.
  $lc_rgpk = chobxml02::rgpack::cls_end->__raw_new;
  $lc_gem = $lc_parser->{&chobxml02::magickal()};
  $lc_rgpk->{'gem'} = $lc_gem;
  $lc_rgpk->{'expat'} = $lc_parser;
  $lc_rgpk->{'tag'} = $lc_tag;
  
  # Next, we roll the stack back to the appropriate
  # tag.
  chobxml02::context::stackwind::action($lc_gem,$lc_tag);
  $lc_stklem = $lc_gem->{'stack'}->see();
  
  # Now more setting up can be done from the stack element.
  $lc_rgpk->{'tagdata'} = $lc_stklem->{'dat'};
  $lc_rgpk->{'pram'} = $lc_stklem->{'pram'};
  
  # Next, we identify the function that we are going
  # to use.
  # Oh --- and we're getting it from the top stack
  # element - just in case it would otherwise be
  # affected by a context-modification since the
  # time of the open-tag.
  $lc_blfunc = $lc_stklem->{'close'};
  
  # Then, we call the function.
  &$lc_blfunc($lc_rgpk);
  
  # Finally, we make sure the stack is properly clean.
  chobxml02::context::stackwind::action($lc_gem,$lc_tag);
  $lc_gem->{'stack'}->off();
}

sub hand_char {
  my $lc_parser;
  my $lc_string;
  my $lc_rgpk;
  my $lc_blfunc;
  my $lc_gem;
  
  ($lc_parser,$lc_string) = @_;
  
  # First, we create and set up the Argument Pack object
  $lc_rgpk = chobxml02::rgpack::cls_char->__raw_new;
  $lc_gem = $lc_parser->{&chobxml02::magickal()};
  $lc_rgpk->{'gem'} = $lc_gem;
  $lc_rgpk->{'expat'} = $lc_parser;
  $lc_rgpk->{'string'} = $lc_string;
  
  # Next, we identify the function that we are going to use.
  $lc_blfunc = $lc_gem->{'charf'};
  
  # Finally, we call the function.
  &$lc_blfunc($lc_rgpk);
}










1;
