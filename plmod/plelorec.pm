# This is the package used for calling separate scripts
# other than the main one:


package plelorec;
use argola;
use strict;

sub plow {
  my $lc_vrs; # Outer wrap version
  my $lc_res; # Command statires
  my @lc_comd; # OUtgoing command
  my @lc_pasd; # Volatile storage for arguments passed here:
  my $lc_ix;   # Counter for arguments passed to this function:
  my $lc_comname; # Name of target command:
  
  $lc_vrs = &argola::vrsn;
  $lc_res = &argola::srcd;
  
  
  @lc_comd = ("perl","-I" . $lc_res . "/plmod");
  
  @lc_pasd = @_;
  $lc_ix = @lc_pasd;
  if ( $lc_ix < 0.5 ) { die "\nINSUFFICIENT ARGUMENTS: to plexof:\n\n"; }
  $lc_comname = shift(@lc_pasd);
  
  @lc_comd = (@lc_comd, $lc_res . "/plcm/" . $lc_comname . ".pl");
  @lc_comd = (@lc_comd, $lc_vrs, $lc_res);
  @lc_comd = (@lc_comd,@lc_pasd);
  
  return @lc_comd;
}

sub flplow {
  my $lc_vrs; # Outer wrap version
  my $lc_res; # Command statires
  my @lc_comd; # OUtgoing command
  my @lc_pasd; # Volatile storage for arguments passed here:
  my $lc_ix;   # Counter for arguments passed to this function:
  my $lc_comname; # Name of target command:
  
  $lc_vrs = &argola::vrsn;
  $lc_res = &argola::srcd;
  
  
  @lc_comd = ("perl","-I" . $lc_res . "/plmod");
  
  @lc_pasd = @_;
  $lc_ix = @lc_pasd;
  if ( $lc_ix < 0.5 ) { die "\nINSUFFICIENT ARGUMENTS: to plexof:\n\n"; }
  $lc_comname = shift(@lc_pasd);
  
  @lc_comd = (@lc_comd, $lc_comname);
  @lc_comd = (@lc_comd, $lc_vrs, $lc_res);
  @lc_comd = (@lc_comd,@lc_pasd);
  
  return @lc_comd;
}

sub plex {
  exec(&plow(@_));
}

sub flplex {
  exec(&flplow(@_));
}

sub plesh {
  return system(&plow(@_));
}
sub sho {
  return system("echo",&plow(@_));
}

1;
