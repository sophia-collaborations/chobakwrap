package chobxml02::fnc::writing;
use strict;

sub to_pen_raw {
  my $lc_pen;
  
  $lc_pen = $_[0]->{'gem'}->{'penpt'};
  $$lc_pen .= $_[0]->{'string'};
}

sub to_pen_esc {
  my $lc_pen;
  
  $lc_pen = $_[0]->{'gem'}->{'penpt'};
  $$lc_pen .= &escap($_[0]->{'string'});
}


sub escap {
  # Function written with help from these URLs:
  # https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
  # http://www.perlmonks.org/bare/?node_id=291353
  #
  # Originally written for this package: chobxml::toolk
  # but copy-pasted here to endure once the original 'chobxml'
  # is no more. This function does the very-important task of
  # replacing characters that need to be escaped for XML/HTML
  # with their equivalent. At least it does the *basics* in
  # this regard.
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
