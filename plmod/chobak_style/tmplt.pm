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
  
  $this = chobak_style::tmplt::cls->__raw_new;
  $lc_cmd = "cat";
  &wraprg::lst($lc_cmd,$_[0]);
  $lc_cont = `$lc_cmd`;
  $lc_rcont = $lc_cont;
  $this->{'alg'} = &procpart($lc_rcont,$_[0],'endtemplate');
  return $this;
}

sub new_blank {
  my $this;
  my $lc_rcont;
  
  $this = chobak_style::tmplt::cls->__raw_new;
  $lc_rcont = '';
  $this->{'alg'} = &procpart($lc_rcont,$_[0],'endtemplate');
  return $this;
}

sub procpart {
  my $lc_rcont;
  my @lc_algo;
  my @lc_parts;
  my $lc_known;
  my $lc_flare;
  my $lc_incm;
  my $lc_aflare;
  my $lc_returno;
  my $lc_filename;
  
  $lc_rcont = $_[0];
  $lc_filename = $_[1];
  
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
    if ( $lc_parts[0] eq 'ifyes' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::util::if_yes,[$lc_parts[1]
        ,&procpart($lc_rcont,$lc_filename,'yesfi')]])
      ;
      $lc_known = 10;
    }
    if ( $lc_parts[0] eq 'ifno' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::util::if_no,[$lc_parts[1]
        ,&procpart($lc_rcont,$lc_filename,'nofi')]])
      ;
      $lc_known = 10;
    }
    if ( $lc_parts[0] eq '' )
    {
      $lc_known = 10;
    }
    if ( $lc_parts[0] eq $_[2] )
    {
      $lc_returno = [@lc_algo];
      $_[0] = $lc_rcont;
      return $lc_returno;
    }
    
    if ( $lc_known < 5 )
    {
      die "\nFATAL ERROR:\n"
        . "  Template file: " . $lc_filename . ":\n"
        . "  Unknown Directive: " . $lc_parts[0] . ":\n"
      . "\n";
    }
  }
  
  
  $lc_returno = [@lc_algo];
  $_[0] = $lc_rcont;
  return $lc_returno;
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
