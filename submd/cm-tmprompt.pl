use strict;
use Term::ReadKey;
use argola;
use wraprg;

my $filset = 0;
my $filgot;
my $numer = 100;
my $denom = 10;
my $startat = 0;
my @filcon;
my $thisline = 0;
my $eachline;
my $doneyet = 0;
my $attime;
my $hstart = 0;
my $shiftrate = 60; # How many keys a shift-request shifts
my $dbginfo = 0;

ReadMode 4;

sub opto__f_do {
  $filset = 10;
  $filgot = &argola::getrg();
} &argola::setopt('-f',\&opto__f_do);

sub opto__from_do {
  $startat = &argola::getrg();
} &argola::setopt('-from',\&opto__from_do);

sub opto__rat_do {
  $numer = &argola::getrg();
  $denom = &argola::getrg();
} &argola::setopt('-rat',\&opto__rat_do);

sub opto__hs_do {
  $hstart = &argola::getrg();
} &argola::setopt('-hs',\&opto__hs_do);

sub opto__dbg_do {
  $dbginfo = 10;
} &argola::setopt('-dbg',\&opto__dbg_do);

&argola::runopts();

if ( $filset < 5 )
{
  die "\nPLease use -f file to select file:\n\n";
}




{
  my $lc_cm;
  my $lc_con;
  $lc_cm = 'cat ' . &wraprg::bsc($filgot);
  $lc_con = `$lc_cm`;
  @filcon = split(/\n/,$lc_con);
}

foreach $eachline (@filcon)
{
  $thisline = int($thisline + 1.2);
  &zango($eachline);
}

sub zango {
  my $lc_clca;
  my $lc_clcb;
  if ( $thisline < ( $startat - 0.5 ) ) { return; }
  if ( $doneyet < 5 )
  {
    $attime = ( time() - ( $hstart * $denom / $numer ) );
  } $doneyet = 10;
  
  if ( $thisline < 9.5 ) { print ' '; }
  if ( $thisline < 99.5 ) { print ' '; }
  if ( $thisline < 999.5 ) { print ' '; }
  print $thisline . ': ';
  print $_[0] . "\n";

  $lc_clca = length($_[0]) + 1;
  $lc_clcb = ( ( $lc_clca * $denom ) / $numer );
  $attime += $lc_clcb;
  &takeyourtime();
}

sub takeyourtime {
  my $lc_key;
  while ( time() < $attime )
  {
    sleep(1);
    $lc_key = ReadKey -1;
    while ( defined($lc_key) )
    {
      &acton($lc_key);
      #print "--> " . $lc_key . "\n";
      $lc_key = ReadKey -1;
    }
  }
}

sub acton {
  my $lc_key;
  $lc_key = $_[0];

  if ( $lc_key eq 'x' )
  {
    print "\nINTERRUPT";
    &endico();
  }

  if ( &isitin($lc_key,['p','o','i','l','k']) )
  {
    return &fornow_advance();
  }

  if ( &isitin($lc_key,['q','w','e','a','s','d']) )
  {
    return &fornow_dowait();
  }

  if ( $dbginfo < 5 ) { return; }
  print '--> ' . ord($lc_key) . ":\n";
}

sub fornow_advance {
  $attime -= ( ( $shiftrate * $denom ) / $numer );
  $numer = int($numer + 1.2);
}

sub fornow_dowait {
  $numer = int($numer - 0.8);
  if ( $numer < 1 ) { $numer = 1; }
  $attime += ( ( $shiftrate * $denom ) / $numer );
}

sub isitin {
  my $lc_rg;
  my $lc_cm;
  $lc_rg = $_[1];
  foreach $lc_cm (@$lc_rg)
  {
    if ( $lc_cm eq $_[0] ) { return(2>1); }
  }
  return(1>2);
}

&endico();
sub endico {
  ReadMode 0;
  print "\n:  " . $numer . " / " . $denom . "  :\n";
  exit(0);
}



