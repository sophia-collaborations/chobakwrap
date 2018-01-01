use strict;
use argola;
use wraprg;
use chobak_json;
use dateelem;

my $jrndir;
my $jrnset = 0;
my $thetmstamp;
my $apenda = 'main';
my $targfile;

my $polite_date;
my $date_dshcode;
my $json_cont;

$thetmstamp = &dateelem::nowo();


sub opto__d_do {
  $jrndir = &argola::getrg();
  $jrnset = 10;
}; &argola::setopt('-d',\&opto__d_do);

sub opto__apn_do {
  $apenda = &argola::getrg();
} &argola::setopt('-apn',\&opto__apn_do);

sub opto__dir_do {
  if ( $jrnset < 5 ) { die("\nPlease use the -d option to identify a journal directory _before_ the '-dir':\n\n"); }
  exec("chobakwrap","-sub","dir-open",$jrndir);
} &argola::setopt('-dir',\&opto__dir_do);

&argola::runopts();


if ( $jrnset < 5 )
{
  die("\nPlease use the -d option to identify a journal directory:\n\n");
}

$polite_date = &dateelem::asem([['at',$thetmstamp],['lib','polite_date_w']]);
$date_dshcode = &dateelem::asem([['at',$thetmstamp],['lib','date_dshcode']]);


$json_cont = &chobak_json::readf($jrndir . '/pref.json');
if ( ref($json_cont) ne 'HASH' ) { die "\nThis is DEFINITELY not a journal directory:\n\n"; }
if ( $json_cont->{'journal-type'} ne 'daily' )
{
  die "\nNot a -chobakwrap- daily journal:\n\n";
}


$targfile = $jrndir . '/dy-' . $date_dshcode . '-' . $apenda . '.txt';

if ( !( -f $targfile ) )
{
  my $lc_cm;
  $lc_cm = 'echo ' . &wraprg::bsc($polite_date . '\n') . ' > ' . &wraprg::bsc($targfile);
  system($lc_cm);
}

system("chobakwrap",'-sub','txtedit-obg',$targfile);



