package chobak_lang01;
use strict;
use chobak_style::cls;
use chobak_fnc;

sub new {
  my $this;
  my $lc_prmfile;
  my $lc_pref;
  my $lc_flvar;
  
  $lc_flvar = 'lang01-prefs.txt';
  
  $lc_prmfile = $_[0] . '/' . $lc_flvar;
  $lc_pref = {
    'chobak-style' => 'no',
    'on-absent-template' => 'die',
    'on-unloaded-template' => 'die',
  };
  &chobak_fnc::hashfile($lc_pref,$lc_prmfile);
  if ( $lc_pref->{'chobak-lang'} ne 'yes' )
  {
    die "\nFATAL ERROR: Not a Valid Language Resource:\n"
      . "File '" . $lc_flvar . "' needs 'chobak-lang' variable with value of 'yes':\n"
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
