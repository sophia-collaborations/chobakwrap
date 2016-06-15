use strict;
use argola;
use wraprg;

my $file_on = 0;
my $file_at;
my $procida;

$procida = $$;

sub verifstillon
{
  my $lc_cm;
  my $lc_rs;
  if ( $file_on < 5 ) { return; }
  $lc_cm = ('cat ' . &wraprg::bsc($file_at));
  $lc_rs = `$lc_cm`; chomp($lc_rs);
  if ( $lc_rs ne $procida ) { die "\nBATCH SHELLING INTERRUPTED\n\n"; }
}

sub opto_do__f_x {
  my $lc_cm;
  &verifstillon();
  if ( $file_on > 5 ) { system("rm","-rf",$file_on); }
  $file_at = &argola::getrg();
  $lc_cm = ('echo ' . &wraprg::bsc($procida) . ' > ' . &wraprg::bsc($file_at));
  system($lc_cm);
  $file_on = 10;
} &argola::setopt('-f',\&opto_do__f_x);

sub opto_do__do_x {
  &verifstillon();
  system(&argola::getrg());
} &argola::setopt('-do',\&opto_do__do_x);

sub opto_do__xf_x {
  &verifstillon();
  if ( $file_on > 5 ) { system("rm","-rf",$file_on); }
} &argola::setopt('-xf',\&opto_do__xf_x);

&argola::runopts();


