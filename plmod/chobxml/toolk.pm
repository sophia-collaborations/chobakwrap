package chobxml::toolk;
use strict;
use XML::Parser::Expat;
use chobxml::toolk::basics;

use Data::Dumper;

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
  $this->{'tagset'}->{'tag_g_on'} = \&nosuchtag_on;
  $this->{'tagset'}->{'tag_g_off'} = \&nosuchtag_off;
  $this->{'tagset'}->{'init'} = \&parse_init;
  $this->{'tagset'}->{'flush'} = \&parse_flush;
  $this->{'tagset'}->{'meta'} = {};
  $this->{'tagset'}->{'char'} = {};
  $this->{'tagset'}->{'char'}->{'dflt'} = \&char_dflt;
  $this->{'tagset'}->{'char'}->{'silent'} = \&char_dflt;
  $this->{'tagset'}->{'char'}->{'loud'} = \&char_loud;
  
  return $this;
}

sub define_tag {
  my $this;
  $this = shift;
  
  $this->{'tagset'}->{'tag_m_ls'} = ($this->{'tagset'}->{'tag_m_ls'}, $_[0]);
  $this->{'tagset'}->{'tag_m_on'}->{$_[0]} = $_[1];
  $this->{'tagset'}->{'tag_m_off'}->{$_[0]} = $_[2];
}

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
  
  $lc_hash->{'tagset'} = $this->{'tagset'};
  $lc_ini = $lc_hash->{'tagset'}->{'init'};
  $lc_hash->{'data'} = &$lc_ini($this->{'tagset'});
  $lc_hash->{'refs'} = 1;
  $lc_hash->{'stack'} = [];
  
  $lc_prs->{'chobak_inf'} = $lc_hash;
  return $lc_prs;
}

sub nosuchtag_on {
  my $lc_msg;
  $lc_msg = "\nNO SUCH TAG: ";
  $lc_msg .= $_[1]->{'element'};
  $lc_msg .= ": (can not open)\n\n";
  die $lc_msg;
}

sub nosuchtag_off {
  my $lc_msg;
  $lc_msg = "\nNO SUCH TAG: ";
  $lc_msg .= $_[1]->{'element'};
  $lc_msg .= ": (can not close)\n\n";
  die $lc_msg;
}

sub parse_init {
  my $lc_a;
  $lc_a = {};
  
  $lc_a->{'fnc'} = {}; # Dynamic method's hash
  $lc_a->{'fnc'}->{'char'} = $_[0]->{'char'}->{'dflt'};
  
  return $lc_a;
}

sub parse_flush {
  # Arg #0 = The parser object itself
}

sub parse_quit {
  # Arg #0 = The parser object itself
  my $lc_lefto;
  $lc_lefto = int( ( $_[0]->{'chobak_inf'}->{'refs'} ) - 0.8 );
  $_[0]->{'chobak_inf'}->{'refs'} = $lc_lefto;
  if ( $lc_lefto < 0.5 ) { &parse_flush($_[0]); }
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


1;
