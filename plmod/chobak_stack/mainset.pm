package chobak_stack::mainset;
use strict;

sub siz {
  my $this;
  my $lc_ryrf;
  my $lc_sizo;
  $this = shift;
  
  $lc_ryrf = $this->{'lmn'};
  $lc_sizo = @$lc_ryrf;
  return $lc_sizo;
}

sub on {
  # This function adds all the arguments onto the stack.
  # It first puts the first argument on the stack,
  # then (if applicable) the next argument, and so forth.
  my $this;
  my $lc_arg;
  my $lc_ryrf;  
  $this = shift;
  
  $lc_ryrf = $this->{'lmn'};
  foreach $lc_arg (@_)
  {
    @$lc_ryrf = ($lc_arg,@$lc_ryrf);
  }
}

sub off {
  # This function takes the top element off of the stack
  # and returns it's value to the calling program.
  my $this;
  my $lc_ryrf;
  my $lc_sizo;
  my $lc_ret;
  $this = shift;
  
  $lc_ryrf = $this->{'lmn'};
  $lc_sizo = @$lc_ryrf;
  if ( $lc_sizo < 0.5 ) { return undef; }
  
  $lc_ret = shift(@$lc_ryrf);
  return $lc_ret;
}

sub see {
  # This function returns the top value on the stack to
  # the calling program -- but it does so without removing
  # it from the stack.
  my $this;
  my $lc_ryrf;
  my $lc_sizo;
  my $lc_ret;
  $this = shift;
  
  $lc_ryrf = $this->{'lmn'};
  $lc_sizo = @$lc_ryrf;
  if ( $lc_sizo < 0.5 ) { return undef; }
  
  $lc_ret = $lc_ryrf->[0];
  return $lc_ret;
}

sub xsee {
  # This function takes the top element off of the stack
  # and returns to the calling program the value of the
  # top element that *remains* on the stack. (Believe it
  # or not, there is actual use for such a method or I
  # would not have included it.)
  my $this;
  $this = shift;
  $this->off();
  return ($this->see());
}


1;
