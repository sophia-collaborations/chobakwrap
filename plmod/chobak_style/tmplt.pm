package chobak_style::tmplt;
use strict;
use chobak_style::tmplt::cls;
use chobak_style::tmplt::util;
use chobak_style::tmplt::time;
use chobak_style::tmplt::warn;
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
    if ( $lc_parts[0] eq 'cap' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::util::var_cap,[$lc_parts[1]]]);
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
    if ( $lc_parts[0] eq 'warn' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::warn::mainwarn,[$lc_parts[1]
        ,&procpart($lc_rcont,$lc_filename,'endwarn')]])
      ;
      $lc_known = 10;
    }
    
    
    if ( $lc_parts[0] eq 'month-l' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::time::var_month_l,[$lc_parts[1]]]);
      $lc_known = 10;
    }
    if ( $lc_parts[0] eq 'day-l' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::time::var_day_l,[$lc_parts[1]]]);
      $lc_known = 10;
    }
    if ( $lc_parts[0] eq 'month-s' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::time::var_month_s,[$lc_parts[1]]]);
      $lc_known = 10;
    }
    if ( $lc_parts[0] eq 'day-s' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::time::var_day_s,[$lc_parts[1]]]);
      $lc_known = 10;
    }
    if ( $lc_parts[0] eq 'int' )
    {
      @lc_algo = (@lc_algo,[\&chobak_style::tmplt::time::var_int,[$lc_parts[1]]]);
      $lc_known = 10;
    }
    
    if ( $lc_parts[0] eq 'enum' )
    {
      my @lc3_ray;
      my $lc3_isz;
      my @lc3_inf;
      
      @lc3_ray = @lc_parts;
      $lc3_isz = @lc3_ray;
      if ( $lc3_isz > 3.5 )
      {
        shift @lc3_ray; # Get rid of command:
        @lc3_inf = (shift @lc3_ray); # Var Name
        @lc3_inf = (@lc3_inf, (shift @lc3_ray)); # Min Size;
        @lc3_inf = (@lc3_inf, [@lc3_ray]); Enumeration List
        
        # Now -- add the command
        @lc_algo = (@lc_algo,[
          &chobak_style::tmplt::efec::var_enum,[@lc3_inf]
        ]);
      }
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
  
  $lc_a =~ s/&I;/|/g;
  $lc_a =~ s/&I1;/|/g;
  $lc_a =~ s/&I2;/||/g;
  $lc_a =~ s/&I3;/|||/g;
  $lc_a =~ s/&I4;/||||/g;
  $lc_a =~ s/&I5;/|||||/g;
  
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
