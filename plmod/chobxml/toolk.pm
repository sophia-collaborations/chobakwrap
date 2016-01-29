package chobxml::toolk;
use strict;
use XML::Parser::Expat;
use chobxml::toolk::basics;
use chobxml::toolk::extra;
use chobxml::toolk::lc;

# This module is a higher-level library for XML parsing built
# as a layer on-top of Expat - specifically, PERL's traditional
# port of Expat.

# In use of this library, please refrain from directly accessing
# the 'chobak_inf' variable that is added by this library to the
# expat parser-object. For one thing, it's part of the
# under-the-hood implementation of this library - not part of
# the proper interface to the library. And furthermore, it is
# entirely possible that it's name might change in future versions,
# or other changes may need to be made that will cause any program
# that directly accesses it that isn't produced by the same party
# as the library itself as part of the same project to break.
# Seriously -- anything you really need from this element, there's
# other functions for accessing it.

# As a matter of fact -- if you are writing a program that uses
# this library - it is best that you restrict your use of it
# to the proper interfaces altogether. Eventually, online
# documentation will be made available. Until then, the functions
# you should use will be preceded by a comment that starts with
# the string 'PROPER INTERFACE:'.

# If a function is *not* one for external programs to use, but
# requires similar description anyway (for whatever reason) the
# equivalent string will be 'SHADOW INTERFACE:'. However, if
# neither of these strings appears preceding a function, assume
# that the function nonetheless *is* a shadow-interface -- i.e.,
# an interface that is meant to be used strictly as part of the
# under-the-hood implementation of the library.

# ########

# my @fruits = keys %color_of; # @fruits becomes list of keys in %color_of

# As for object constructors:
# http://perldoc.perl.org/perlobj.html#Writing-Constructors


#sub new {
#  my $lc_cls;
#  my $lc_ths;
#  $lc_cls = shift;
#  $lc_ths = {};
#  bless $lc_ths, $lc_cls;
#  
#  $lc_ths->_initialize();
#  
#  return $lc_ths;
#}
#sub _initialize {
#  my $this = shift;
#  $this->{vong} = 0;
#}
#sub upo {
#  my $this = shift;
#  $this->{vong} = int($this->{vong} + 1.2);
#  system("echo",": " . $this->{vong} . " :");
#}



# PROPER INTERFACE:
# $tagset = chobxml::toolk->new;
#
# This function creates a tagset object

sub new {
  my $class;
  my $this;
  
  $class = shift;
  $this = {};
  bless $this, $class;
  
  $this->{'tagset'} = {};
  $this->{'tagset'}->{'tag_m_on'} = {};
  $this->{'tagset'}->{'tag_m_off'} = {};
  $this->{'tagset'}->{'tag_m_ls'} = [];
  $this->{'tagset'}->{'tag_g_on'} = \&chobxml::toolk::basics::nosuchtag_on;
  $this->{'tagset'}->{'tag_g_off'} = \&chobxml::toolk::basics::nosuchtag_off;
  $this->{'tagset'}->{'init'} = \&chobxml::toolk::basics::parse_init;
  $this->{'tagset'}->{'flush'} = \&chobxml::toolk::basics::parse_flush;
  $this->{'tagset'}->{'meta'} = {};
  $this->{'tagset'}->{'char'} = {};
  $this->{'tagset'}->{'char'}->{'dflt'} = \&char_dflt;
  $this->{'tagset'}->{'char'}->{'silent'} = \&char_dflt;
  $this->{'tagset'}->{'char'}->{'loud'} = \&char_loud;
  
  return $this;
}

# PROPER INTERFACE:
# $tagset->define_tag([tagname],[open_f],[close_f]);
#
# The argument labeled [tagname] is a string containing the
# name of the tag being defined.
#
# The function referenced by [open_f] is the chobxml::toolk
# tag-function called when this tag is opened --- and
# the one referenced by [close_f] is the one called
# when the tag is closed.
sub define_tag {
  my $this;
  $this = shift;
  
  $this->{'tagset'}->{'tag_m_ls'} = ($this->{'tagset'}->{'tag_m_ls'}, $_[0]);
  $this->{'tagset'}->{'tag_m_on'}->{$_[0]} = $_[1];
  $this->{'tagset'}->{'tag_m_off'}->{$_[0]} = $_[2];
}

sub default_hnd {
  my $this;
  $this = shift;
  
  $this->{'tagset'}->{'tag_g_on'} = $_[0];
  $this->{'tagset'}->{'tag_g_off'} = $_[1];
}

sub define_init {
  my $this;
  $this = shift;
  $this->{'tagset'}->{'init'} = $_[0];
}

sub define_flush {
  my $this;
  $this = shift;
  $this->{'tagset'}->{'flush'} = $_[0];
}


# ########################

sub parser {
  my $this = shift;
  my $lc_prs;
  my $lc_hash;
  my $lc_ini;
  
  $lc_hash = {};
  
  $lc_prs = XML::Parser::Expat->new;
  $lc_prs->setHandlers(
      'Start' => \&chobxml::toolk::basics::lm_start,
      'End' => \&chobxml::toolk::basics::lm_end,
      'Char' => \&chobxml::toolk::basics::lm_char
  );
  
  $lc_hash->{'toolk'} = $this;
  $lc_hash->{'tagset'} = $this->{'tagset'};
  $lc_ini = $lc_hash->{'tagset'}->{'init'};
  $lc_hash->{'data'} = &$lc_ini($this->{'tagset'},$_[0]);
  &chobxml::toolk::lc::setdatafnc($lc_hash);
  $lc_hash->{'numrefs'} = {};
  $lc_hash->{'numrefs'}->{'count'} = 1;
  $lc_hash->{'stack'} = [];
  
  $lc_prs->{'chobak_inf'} = $lc_hash;
  return $lc_prs;
}

sub claim {
  my $this;
  my $lc_inf;
  my $lc_elem;
  my $lc_stack;
  
  $this = shift;
  
  $lc_inf = $_[0]->{'handle'}->{'chobak_inf'};
  $lc_elem = {};
  $lc_elem->{'type'} = 'toolk';
  $lc_elem->{'toolk'} = $lc_inf->{'toolk'};
  $lc_elem->{'tagset'} = $lc_inf->{'tagset'};
  
  $lc_stack = $lc_inf->{'stack'};
  @$lc_stack = (@$lc_stack,$lc_elem);
  
  $lc_inf->{'toolk'} = $this;
  $lc_inf->{'tagset'} = $this->{'tagset'};
  
}

sub parse {
  my $this;
  my $lc_a;
  $this = shift;
  $lc_a = $this->parser($_[0]);
  $lc_a->parse($_[1]);
  $this->parse_quit($lc_a);
}

sub parse_quit {
  # Arg #0 = The parser object itself
  my $this;
  my $lc_lefto;
  
  $this = shift;
  
  $lc_lefto = int( ( $_[0]->{'chobak_inf'}->{'numrefs'}->{'count'} ) - 0.8 );
  $_[0]->{'chobak_inf'}->{'numrefs'}->{'count'} = $lc_lefto;
  
  
  
  system("echo","LEFT ON IT: " . $lc_lefto);
  if ( $lc_lefto < 0.5 )
  {
    my $lc2_mth;
    $lc2_mth = $this->{'tagset'}->{'flush'};
    
    #&chobxml::toolk::basics::parse_flush($_[0]);
    &$lc2_mth($_[0]);
  }
}

sub char_dflt {
}

sub char_loud {
  print &escap($_[1]->{'text'});
}

sub escap {
  # Function written with help from these URLs:
  # https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
  # http://www.perlmonks.org/bare/?node_id=291353
  my $lc_strg;
  
  $lc_strg = $_[0];
  
  $lc_strg =~ s/&/&amp;/g;
  $lc_strg =~ s/</&lt;/g;
  $lc_strg =~ s/>/&gt;/g;
  $lc_strg =~ s/"/&quot;/g;
  $lc_strg =~ s/'/&apos;/g;
  
  return $lc_strg;
}



sub magical {
  return 'chobak_inf';
}


1;
