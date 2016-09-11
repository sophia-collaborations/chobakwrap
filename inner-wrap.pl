use strict;
use plelorec;
use argola;
use alarmica;
use File::Basename;
use Cwd qw(realpath);

my $ourdiro;
$ourdiro = dirname(realpath($0));

sub opto__f_run {
  my @lc_a;
  @lc_a = &argola::remrg();
  &plelorec::flplex(@lc_a);
} &argola::setopt("-run",\&opto__f_run);

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
  $lc_subcfil = $ourdiro . '/submd/cm-' . $lc_subcm . '.pl';
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

sub opto__f_rloc {
  my $lc_a;
  $lc_a = &argola::srcd();
  exec("echo",$lc_a);
  exit(0);
} &argola::setopt("-rloc",\&opto__f_rloc);

&argola::help_opt('--help-sound','manp/chobakwrap-sound.1');
&argola::help_opt('--help-caff','manp/chobakwrap-caff.1');
&argola::help_opt('--help','manp/chobakwrap.1');

&argola::txt_spit_opt('--out-install','pub-res/srv/install.sh.txt');
&argola::txt_spit_opt('--out-gitignore','pub-res/srv/gitignore.txt');
&argola::txt_spit_opt('--out-promulga','pub-res/srv/main.dat.txt');

&argola::runopts;


