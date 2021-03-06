package chobak_style;
use strict;
use chobak_style::cls;
use chobak_fnc;

sub new {
  my $this;
  my $lc_prmfile;
  my $lc_pref;
  my $lc_flvar;
  
  $lc_flvar = 'style-prefs.txt';
  
  $lc_prmfile = $_[0] . '/' . $lc_flvar;
  $lc_pref = {
    'chobak-style' => 'no',
    'on-absent-template' => 'die',
    'on-unloaded-template' => 'die',
  };
  
  if ( 1 > 2 ) { # START FALSEHOOD
  &besure_present({
    'deck' => $lc_pref,
    'var' => 'on-absent-template',
    'src' => $lc_flvar,
    'maybe' =>
    [
      ['skip'],
      ['blank'],
      ['die'],
    ],
  });
  } # END FALSEHOOD
  
  &chobak_fnc::hashfile($lc_pref,$lc_prmfile);
  if ( $lc_pref->{'chobak-style'} ne 'yes' )
  {
    die "\nFATAL ERROR: Not a Valid Style:\n"
      . "File '" . $lc_flvar . "' needs 'chobak-style' variable with value of 'yes':\n"
      . "directory: " . $_[0] . ":\n\n"
    ;
  }
  
  $this = chobak_style::cls->__raw_new;
  
  $this->{'path'} = [@_];
  $this->{'tmpl'} = {}; # The Array of Parsed Template objects
  $this->{'pref'} = $lc_pref;
  
  return $this;
}


1;
