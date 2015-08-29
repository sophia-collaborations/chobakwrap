# This is the package used for calling separate scripts
# other than the main one:


package plelorec;
use argola;
use strict;

my @stv_command_act;

sub autopendent {
  my $lc_a;
  $lc_a = &argola::srcd();
  $lc_a .= "/plmod";
  if ( -d $lc_a )
  {
    &sufficient();
    return;
  }
  &dependent();
}
&autopendent();

sub sufficient {
  my $lc_a;
  my @lc_b;
  
  @lc_b = ("perl");
  
  $lc_a = &argola::srcd();
  @lc_b = (@lc_b,"-I" . $lc_a . "/lc_plmod");
  
  $lc_a = &argola::srcd();
  @lc_b = (@lc_b,"-I" . $lc_a . "/plmod");
  
  @stv_command_act = @lc_b;
}

sub dependent {
  my $lc_a;
  my @lc_b;
  
  @lc_b = ("perl");
  
  $lc_a = &argola::srcd();
  @lc_b = (@lc_b,"-I" . $lc_a . "/lc_plmod");
  
  $lc_a = `chobakwrap -rloc`; chomp($lc_a);
  @lc_b = (@lc_b,"-I" . $lc_a . "/plmod");
  
  @stv_command_act = @lc_b;
}



# The old version of plow() was reactivated so as not to
# spaghetti-code flplow().
#sub plow {
#  my $lc_vrs; # Outer wrap version
#  my $lc_res; # Command statires
#  my @lc_comd; # OUtgoing command
#  my @lc_pasd; # Volatile storage for arguments passed here:
#  my $lc_ix;   # Counter for arguments passed to this function:
#  my $lc_comname; # Name of target command:
#  
#  $lc_vrs = &argola::vrsn;
#  $lc_res = &argola::srcd;
#  
#  
#  @lc_comd = ("perl","-I" . $lc_res . "/plmod");
#  
#  @lc_pasd = @_;
#  $lc_ix = @lc_pasd;
#  if ( $lc_ix < 0.5 ) { die "\nINSUFFICIENT ARGUMENTS: to plexof:\n\n"; }
#  $lc_comname = shift(@lc_pasd);
#  
#  @lc_comd = (@lc_comd, $lc_res . "/plcm/" . $lc_comname . ".pl");
#  @lc_comd = (@lc_comd, $lc_vrs, $lc_res);
#  @lc_comd = (@lc_comd,@lc_pasd);
#  
#  return @lc_comd;
#}

sub plow {
  my @lc_allrg;
  my $lc_unrg;
  my $lc_count;
  my $lc_res;
  
  $lc_res = &argola::srcd;
  
  @lc_allrg = @_;
  $lc_count = @lc_allrg;
  if ( $lc_count > 0.5 )
  {
    $lc_unrg = shift(@lc_allrg);
    $lc_unrg = $lc_res . "/plcm/" . $lc_unrg . ".pl";
    @lc_allrg = ($lc_unrg,@lc_allrg);
  }
  return &flplow(@lc_allrg);
}

sub flplow {
  my $lc_vrs; # Outer wrap version
  my $lc_res; # Command statires
  my @lc_comd; # OUtgoing command
  my @lc_pasd; # Volatile storage for arguments passed here:
  my $lc_ix;   # Counter for arguments passed to this function:
  my $lc_comname; # Name of target command:
  
  $lc_vrs = &argola::vrsn();
  $lc_res = &argola::srcd();
  
  
  @lc_comd = (@stv_command_act);
  
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
