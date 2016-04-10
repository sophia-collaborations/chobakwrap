package chobak_hk;
# These are functions for doing some things with references that
# PERL might choke on if you try to do them within a statement
# *without* these functions.

sub hky {
  # Returns an array of the keys to the hash that
  # a reference points to.
  my $lc_a;
  my %lc_b;
  my @lc_c;
  
  $lc_a = $_[0];
  %lc_b = %$lc_a;
  @lc_c = keys %lc_b;
  return @lc_c;
}

sub hry {
  # Returns an array that is a copy of the one that
  # a reference points to.
  my $lc_a;
  my @lc_b;
  
  $lc_a = $_[0];
  @lc_b = @$lc_a;
  return @lc_b;
}

1;
