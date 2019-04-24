use strict;
# This is the C compilation to be used with -chobakwrap- packages instead
# of -gcc-. It is one of -chobakwrap-'s C tools - the other which will
# be -libmaker- that builds libraries, and possibly other tools in the
# future.
#
# By putting all things specific to -chobakwrap- in these tools, the hope
# is that in future versions, we can make improvements as to how -chobakwrap-
# handles C libraries without breaking anything.
use argola;

my @the_c_comd;
my $hme;

$hme = $ENV{'HOME'};

@the_c_comd = ('gcc',('-L' . $hme . '/chobakwrap/cliba'));
@the_c_comd = (@the_c_comd,('-I' . $hme . '/chobakwrap/clibh'));

while ( &argola::yet() )
{
  @the_c_comd = (@the_c_comd,&argola::getrg());
}

#@the_c_comd = ('echo',@the_c_comd);
system(@the_c_comd);


