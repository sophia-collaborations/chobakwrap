use strict;
use argola;
use chobaksemap;

# This script is simply a command-line interface to the 'chobaksemap'
# PERL library.

my $semaploc;
my $semapmode;

$semaploc = &argola::getrg();
$semapmode = &argola::getrg();


if ( $semapmode eq 'flip' )
{
  &chobaksemap::flip($semaploc);
  exit(0);
}

if ( $semapmode eq 'read' )
{
  exec('echo',&chobaksemap::smread($semaploc));
  exit(0);
}

if ( $semapmode eq 'write' )
{
  exec('echo',&chobaksemap::smwrite($semaploc));
  exit(0);
}



die ("\n" . "FATAL ERROR: No such semap mode known: " . $semapmode . ":\n\n");



