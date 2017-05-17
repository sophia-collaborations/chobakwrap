use strict;
use argola;

my $volumas = 1;
my $sond_is = 0;
my $sond_at;


sub opto__snd__y {
  $sond_at = &argola::getrg();
  $sond_is = 10;
} &argola::setopt('-snd',\&opto__snd__y);

sub opto__vol__y {
  $volumas = &argola::getrg();
} &argola::setopt('-vol',\&opto__vol__y);

# Centralizing help-file in main 'chobakwrap' command.
&argola::osorc_opt('--help','chobakwrap','--help-sound');

&argola::runopts();


if ( $sond_is < 5 )
{
  die "\nFATAL ERROR: Use -snd option to specify sound file:\n\n"; 
}


#exec("afplay","-v",$volumas,$sond_at);
exec("mplayer",'-volume',($volumas * 100),$sond_at);


