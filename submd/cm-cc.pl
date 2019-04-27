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
my @the_rgx_a; # The libraric options passed to this wrapper
my @the_rgx_b; # The non-libraric options passed to this wrapper
my $hme;

$hme = $ENV{'HOME'};

@the_rgx_a = ();
@the_rgx_b = ();
while ( &argola::yet() )
{
  my $lc_new;
  my $lc_bgn;
  my $lc_ok;
  $lc_new = &argola::getrg();
  $lc_bgn = substr $lc_new, 0, 2;
  $lc_ok = 10;
  if ( $lc_bgn eq '-L' ) { $lc_ok = 0; }
  if ( $lc_bgn eq '-I' ) { $lc_ok = 0; }
  if ( $lc_ok > 5 ) { @the_rgx_b = (@the_rgx_b,$lc_new); }
  if ( $lc_ok < 5 ) { @the_rgx_a = (@the_rgx_a,$lc_new); }
}

@the_c_comd = ('gcc');
@the_c_comd = (@the_c_comd,@the_rgx_a);
@the_c_comd = (@the_c_comd,('-L' . $hme . '/chobakwrap/cliba'));
@the_c_comd = (@the_c_comd,@the_rgx_b);
@the_c_comd = (@the_c_comd,('-I' . $hme . '/chobakwrap/clibh'));


#@the_c_comd = ('echo',@the_c_comd);
system(@the_c_comd);


