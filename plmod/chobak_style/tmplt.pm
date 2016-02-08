package chobak_style::tmplt;
use strict;
use chobak_style::tmplt::cls;
use chobak_style::tmplt::util;
use wraprg;

sub new {
  my $this;
  my $lc_cmd;
  my $lc_cont;
  my $lc_rcont;
  my $lc_flare;
  my $lc_aflare;
  my $lc_incm;
  my $lc_known;
  my @lc_parts;
  my @lc_algo;
  
  $this = chobak_style::tmplt::cls->__raw_new;
  $lc_cmd = "cat";
  &wraprg::lst($lc_cmd,$_[0]);
  $lc_cont = `$lc_cmd`;
  $lc_rcont = $lc_cont;
  
  @lc_algo = ();
  while ( $lc_rcont ne "" )
  {
    ($lc_flare,$lc_aflare) = split(quotemeta('{{{'),$lc_rcont,2);
    ($lc_incm,$lc_rcont) = split(quotemeta('}}}'),$lc_aflare,2);
    @lc_algo = (@lc_algo,[\&chobak_style::tmplt::util::raw_out,[&escap($lc_flare)]]);
    
    # Now for the part inside:
    @lc_parts = split(quotemeta('|'),$lc_incm);
    $lc_known = 0;
    if ( $lc_parts[0] eq 'lit' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::util::var_lit,[$lc_parts[1]]]);
      $lc_known = 10;
    }
    if ( $lc_parts[0] eq 'esc' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::util::var_esc,[$lc_parts[1]]]);
      $lc_known = 10;
    }
    if ( $lc_parts[0] eq '' )
    {
      $lc_known = 10;
    }
    
    if ( $lc_known < 5 )
    {
      die "\nFATAL ERROR:\n"
        . "  Template file: " . $_[0] . ":\n"
        . "  Unknown Directive: " . $lc_parts[0] . ":\n"
      . "\n";
    }
  }
  
  
  $this->{'alg'} = [@lc_algo];
  return $this;
}

sub escap {
  my $lc_a;
  $lc_a = $_[0];
  
  $lc_a =~ s/&o;/{/g;
  $lc_a =~ s/&o1;/{/g;
  $lc_a =~ s/&o2;/{{/g;
  $lc_a =~ s/&o3;/{{{/g;
  $lc_a =~ s/&o4;/{{{{/g;
  $lc_a =~ s/&o5;/{{{{{/g;
  
  $lc_a =~ s/&c;/}/g;
  $lc_a =~ s/&c1;/}/g;
  $lc_a =~ s/&c2;/}}/g;
  $lc_a =~ s/&c3;/}}}/g;
  $lc_a =~ s/&c4;/}}}}/g;
  $lc_a =~ s/&c5;/}}}}}/g;
  
  return $lc_a;
}

1;
