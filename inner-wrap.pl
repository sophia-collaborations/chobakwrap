use strict;
use plelorec;
use argola;
use wraprg;
use alarmica;
use chobaksemap;
use File::Basename;
use Cwd qw(realpath);

my $ourdiro;
$ourdiro = dirname(realpath($0));

sub opto__f_run {
  my @lc_a;
  @lc_a = &argola::remrg();
  &plelorec::flplex(@lc_a);
} &argola::setopt("-run",\&opto__f_run);

sub opto__f_lib {
  &plelorec::another_perl_libdir(&argola::getrg());
} &argola::setopt("-lib",\&opto__f_lib);


sub opto__f_set {
  my $lc_a;
  $lc_a = &argola::getrg();
  &alarmica::regmsg($lc_a);
} &argola::setopt("-set",\&opto__f_set);

sub opto__f_entr {
}

sub opto__sub_set {
  my $lc_subcm;
  my $lc_subcfil;
  my @lc_cmln;
  
  $lc_subcm = &argola::getrg();
  
  
  # BEGIN HIERARCHY OF OPTIONS FOR SUBCOMMANDS:
  
  # First, something OVERRIDING on PATH for this purpose:
  if ( 2 > 1 )
  {
    my $lc2_cm;
    my $lc2_rs;
    my @lc2_go;
    $lc2_cm = "which " . &wraprg::bsc(( 'chobakwrap--toputil--' . $lc_subcm ));
    $lc2_rs = `$lc2_cm`;
    chomp $lc2_rs;
    if ( $lc2_rs ne '' )
    {
      # For this option, we go ahead an EXECute rather than rely on
      # the chobakwrap library to invoke PERL for this.
      @lc2_go = ($lc2_rs);
      while ( &argola::yet() )
      {
        @lc2_go = (@lc2_go,&argola::getrg());
      }
      exec(@lc2_go);
    }
  }
  
  # Next, the OS-specific implementation:
  if ( 2 > 1 )
  {
    my $lc2_chk;
    my $lc2_cm;
    my $lc2_res;
    $lc2_chk = $ourdiro . '/submd/cm-osid.pl';
    $lc2_cm = 'perl ' . &wraprg::bsc($lc2_chk);
    $lc2_res = `$lc2_cm`; chomp($lc2_res);
    $lc_subcfil = $ourdiro . '/submd/os-' . $lc2_res . '-' . $lc_subcm . '.pl';
  }
  
  # Then, the OS-generic implementation:
  if ( ! ( -f $lc_subcfil ) )
  {
    $lc_subcfil = $ourdiro . '/submd/cm-' . $lc_subcm . '.pl';
  }
  
  # Then, something on PATH for this purpose:
  if ( ! ( -f $lc_subcfil ) )
  {
    my $lc2_cm;
    my $lc2_rs;
    my @lc2_go;
    $lc2_cm = "which " . &wraprg::bsc(( 'chobakwrap--util--' . $lc_subcm ));
    $lc2_rs = `$lc2_cm`;
    chomp $lc2_rs;
    if ( $lc2_rs ne '' )
    {
      # For this option, we go ahead an EXECute rather than rely on
      # the chobakwrap library to invoke PERL for this.
      @lc2_go = ($lc2_rs);
      while ( &argola::yet() )
      {
        @lc2_go = (@lc2_go,&argola::getrg());
      }
      exec(@lc2_go);
    }
  }
  
  # Then, the last-resort OS-generic implementation:
  if ( ! ( -f $lc_subcfil ) )
  {
    $lc_subcfil = $ourdiro . '/submd/lr-' . $lc_subcm . '.pl';
  }
  
  # END HIERARCHY OF OPTIONS FOR SUBCOMMANDS:
  
  
  if ( ! ( -f $lc_subcfil ) )
  {
    die("\nNo such 'chobakwrap' sub-command as '" . $lc_subcm . "':\n\n");
  }
  @lc_cmln = ($lc_subcfil);
  while ( &argola::yet() )
  {
    @lc_cmln = (@lc_cmln,&argola::getrg());
  }
  plelorec::flplex(@lc_cmln);
  exit(0);
} &argola::setopt("-sub",\&opto__sub_set);



# The '-deep-magic-sub' is similar to the '-sub' option - except
# that the command-line mention of the subcommand includes
# the hidden-prefix.
#   NOTE: This option should not be used from the actual command
# prompt. Rather, it is meant for the use of generic-implementations
# of subcommands to use if they need a more sophisticated method
# for identifying the system-specific subcommand than what would
# be wise to build into this wrapper script.
#   As a general rule, the 'os-' is the beginning of the prefix
# for OS-specific implementations identified automatically by
# the '-sub' option, 'cm-' is the entirety of the prefix for
# generic implementations invoked by the '-sub' option in the
# event of the option not finding an OS-specific implementation
# and 'xt-' is the beginning of the prefix for implementations
# that are written specifically with the '-deep-magic-sub' option
# in mind. Those of the 'xt-' category can refer to groups of
# operating systems (rather than one for every possible output
# of "chobakwrap -sub osid") and may also vary based on other
# system-configuration details.
#   Oh - and there is the 'lr-' prefix that is just like the
# 'cm-' prefix - except that one is for Last Resort, even after
# attempting to find an implementation on the command execution
# path (which would be prefixed by 'chobakwrap--util--').
sub opto__deep_magic_sub_set {
  my $lc_subcm;
  my $lc_subcfil;
  my @lc_cmln;
  
  $lc_subcm = &argola::getrg();
  
  
  # BEGIN HIERARCHY OF OPTIONS FOR SUBCOMMANDS:
  
  # First, the OS-specific implementation:
  if ( 2 > 1 )
  {
    $lc_subcfil = $ourdiro . '/submd/' . $lc_subcm . '.pl';
  }
  
  # END HIERARCHY OF OPTIONS FOR SUBCOMMANDS:
  
  
  if ( ! ( -f $lc_subcfil ) )
  {
    die("\nNo such 'chobakwrap' sub-command as '" . $lc_subcm . "':\n\n");
  }
  @lc_cmln = ($lc_subcfil);
  while ( &argola::yet() )
  {
    @lc_cmln = (@lc_cmln,&argola::getrg());
  }
  plelorec::flplex(@lc_cmln);
  exit(0);
} &argola::setopt("-deep-magic-sub",\&opto__deep_magic_sub_set);

sub opto__f_rloc {
  my $lc_a;
  $lc_a = &argola::srcd();
  exec("echo",$lc_a);
  exit(0);
} &argola::setopt("-rloc",\&opto__f_rloc);

sub opto__f_c {
  my $lc_semapres;
  my $lc_semapdir;
  my $lc_binary;
  my @lc_cmdon;
  $lc_semapres = $ourdiro . '/build/cbin';
  $lc_semapdir = &chobaksemap::smread($lc_semapres);
  $lc_binary = ( $lc_semapdir . '/' . &argola::getrg . '.out' );
  @lc_cmdon = ($lc_binary);
  while ( &argola::yet() ) { @lc_cmdon = (@lc_cmdon, &argola::getrg()); }
  exec(@lc_cmdon);
} &argola::setopt("-c",\&opto__f_c);

&argola::help_opt('--help-sound','manp/chobakwrap-sound.1');
&argola::help_opt('--help-caff','manp/chobakwrap-caff.1');
&argola::help_opt('--help','manp/chobakwrap.1');

&argola::txt_spit_opt('--out-install','pub-res/srv/install.sh.txt');
&argola::txt_spit_opt('--out-uninstall','pub-res/srv/uninstall.sh.txt');
&argola::txt_spit_opt('--out-gitignore','pub-res/srv/gitignore.txt');
&argola::txt_spit_opt('--out-promulga','pub-res/srv/main.dat.txt');

&argola::runopts;


