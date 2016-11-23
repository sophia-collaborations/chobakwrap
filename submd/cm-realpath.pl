use strict;
use argola;
use Cwd qw(realpath);

while ( &argola::yet() ) { system("echo",realpath(&argola::getrg())); }



