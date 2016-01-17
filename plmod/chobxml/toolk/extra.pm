package chobxml::toolk::extra;
use chobxml::toolk;
use strict;

use Data::Dumper;


sub subparse {
  my $lc_prs;
  
  $lc_prs = XML::Parser::Expat->new;
  $lc_prs->setHandlers(
      'Start' => \&chobxml::toolk::basics::lm_start,
      'End' => \&chobxml::toolk::basics::lm_end,
      'Char' => \&chobxml::toolk::basics::lm_char
  );
  
  
  $lc_prs->{'chobak_inf'} = $_[0]->{'handle'}->{'chobak_inf'};
  $lc_prs->{'chobak_inf'}->{'numrefs'}->{'count'} = int($lc_prs->{'chobak_inf'}->{'numrefs'}->{'count'} + 1.2);
  
  system("echo","INCREASED REFS TO: " . $lc_prs->{'chobak_inf'}->{'numrefs'}->{'count'});
  
  
  $lc_prs->parse($_[1]);
  
  $lc_prs->{'chobak_inf'}->{'toolk'}->parse_quit($lc_prs);
}


sub dumping {
  print STDERR "\n" . $_[0] . ":\n" . Dumper($_[1]) . "\n\n";
}


1;
