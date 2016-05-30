use strict;
use argola;

my @caffopt = ( '-d' );
my $dur_secon = 5;
my $do_caff = 10; # 0 = quit -- 5 = don't caffeinate -- 10 = do caffeinate

sub opto___help__do {
  exec("chobakwrap","--help-caff");
} &argola::setopt('--help',\&opto___help__do);


# MODE OPTIONS

sub opto__full__do {
  @caffopt = ( '-d' );
  $do_caff = 10;
} &argola::setopt('-full',\&opto__full__do);

sub opto__xscr1__do {
  @caffopt = ( '-i' );
  $do_caff = 10;
} &argola::setopt('-xscr1',\&opto__xscr1__do);

sub opto__nocaf__do {
  $do_caff = 5;
} &argola::setopt('-nocaf',\&opto__nocaf__do);

sub opto__none__do {
  $do_caff = 0;
} &argola::setopt('-none',\&opto__none__do);


# TIME DURATION OPTIONS

sub opto__sec__do {
  $dur_secon = &argola::getrg();
} &argola::setopt('-sec',\&opto__sec__do);


# RUN THE OPTIONS
&argola::runopts();

if ( $do_caff < 3 ) { exit(0); }
if ( $do_caff < 7 )
{
  sleep($dur_secon);
  exit(0);
}

exec('caffeinate',@caffopt,'-t',$dur_secon);




