package chobak_style;
use strict;
use chobak_style::cls;
use chobak_fnc;

sub new {
  my $this;
  my $lc_prmfile;
  my $lc_pref;
  
  $lc_prmfile = $_[0] . '/style-prefs.txt';
  $lc_pref = {
    'chobak-style' => 'no',
    'on-absent-template' => 'die',
    'on-unloaded-template' => 'die',
  };
  &chobak_fnc::hashfile($lc_pref,$lc_prmfile);
  if ( $lc_pref->{'chobak-style'} ne 'yes' )
  {
    die "\nFATAL ERROR: Not a Valid Style:\n"
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
