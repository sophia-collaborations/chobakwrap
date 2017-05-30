#! /usr/bin/perl
use strict;
use argola;
my $minim;
my $maxim;
my $difren;
my $majrand;
my $resul;
my @sndcode = ();
my $outcode = '';
my $moment;

#($minim,$maxim) = @ARGV;

$minim = 5;
$maxim = 50;

sub opt__min__do {
  $minim = &argola::getrg();
}; &argola::setopt('-min',\&opt__min__do);

sub opt__max__do {
  $maxim = &argola::getrg();
}; &argola::setopt('-max',\&opt__max__do);

sub opto__ochs__do {
  @sndcode = (@sndcode,[\&out__varval__do,\$resul]);
}; &argola::setopt('-ochs',\&opto__ochs__do);

&argola::runopts();


sub out__varval__do {
  my $lc_ref;
  $lc_ref = $_[0]->[1];
  $outcode .= $$lc_ref;
}

if ( $maxim < ( $minim + 1.2 ) ) { exit(0); }

# The reason why $difren is one more than the actual difference
# is because both the minimum sleep-time and the maximum sleep-time
# must be in the reange of possibilities.
$difren = int(($maxim - $minim) + 1.2);

$majrand = int(rand($difren * 5));
$resul = int($minim + 0.2 + ($majrand % $difren));


foreach $moment (@sndcode)
{
  my $lc_mmn;
  $lc_mmn = $moment->[0];
  &$lc_mmn($moment);
}
if ( $outcode ne '' ) { system("echo",$outcode); }

exec("sleep",$resul);

