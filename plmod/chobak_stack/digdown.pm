package chobak_stack::digdown;
use chobak_stack::digdown::res;
use strict;

# The digdown() method does in-module something
# that would otherwise require some complex looping
# on the part of the calling program.
#
# Simply-put - it makes sure that the top-layer
# of the stack is one matching certain criteria
# (tested for in the 'check' handler-function)
# and if it isn't, keeps removing the top element
# from the stack until the top-layer *is* the
# one we're looking for until the stack is empty.
# The method returns 'true' if the termination is
# as a result of finding what we're looking for
# and 'false' if the termination is a result of
# the stack being empty.
#
# Upon finding what we're looking for, it executes
# the 'onyes' handler-function before returning
# to the calling program if that function is
# provided among the handlers. In that event, the
# return-value of this handler over-rides the
# default 'true' return-value of this method after
# a successful dig.
#
# Upon finding that the top-element of the stack
# is *not* what we're looking for (but the stack
# isn't empty either) it calls the 'onno' handler-
# function --- who's 'true' or 'false' return
# value is of no consequence.
#
# Upon finding that the stack is empty, it
# executes the 'onempty' handler-function before
# returning to the calling program if that function
# is provided among the handlers. In that event,
# the return-value of this handler over-rides the
# default 'false' return-value of this method after
# a failed dig.


# ARGUMENTS TO THE METHOD:
#
# Argument #0:
#     A value of which a separate copy will be passed to each
#   and every handler used by this method each time it is used.
#   It is recommended, though in no way enforced, that this
#   argument be a PERL reference.
#     Just make sure that all handler functions specified in
#   the next argument are *consistent* about every detail of
#   the nature of this argument and what it points to.
#
# Argument #1:
#     A PERL reference to a hash of PERL CODE references.
#   These CODE references are to the handler functions used
#   by this method. A fresh copy of this argument will also
#   be passed to each handler each time it is used.


# HANDLER FUNCTION STRUCTURE:
#
#   The handler functions return a 'true' or 'false' value.
# However, unless it is a test function, the value of that
# return value is of little consequence.
#
# HINT: PERL's 'strict' mode (unfortunately) does not allow
# the use of the bare-words 'true' and 'false'. One can get
# around this, though, by simply returning instead the
# result of a parentheses-encapsulated always-true statement
# (such as '(2 > 1)') for 'true' -- and a parentheses-
# encapsulated always-false statement (such as '(1 > 2)')
# for 'false'. However, *please* do *not* succumb to the
# temptation to just return '1' for 'true' or '0' for
# 'false'. There's lots of talk in the programming world
# of various segregations such as the segregation of data
# and algorithms --- but one segregation that is lacking
# needs to be emphasized more -- the segregation of
# different data concept-layers. It's a long store to
# explain what it means in-general --- but the nutshell
# of how it applies here is that though the language may
# treat '1' and 'true' as synonymous and '0' and 'false'
# as synonymous, it is still sloppy-coding to flaunt that
# in every line of code.
#
# Argument #0:
#     A reference to the stack through which the digdown()
#   method is called.
#
# Argument #1:
#     A fresh copy of Argument #0 to the digdown() method.
#   Remember that only the argument itself is copied. If
#   the argument is a reference (which once again, is
#   highly recommended) the stuff that it *points* to is
#   *not* copied.
#
# Argument #2:
#     A fresh copy of Argument #1 to the digdown() method.
#   Remember that this argument is a reference and only
#   the reference is copied -- not the stuff that it points
#   to.




sub digdown
{
  my $this;
  my $lc_test;
  my $lc_onyes;
  my $lc_onno;
  my $lc_onempty;
  my @lc_rcpa;
  my @lc_rcpb;
  my $lc_ret;
  $this = shift;
  
  @lc_rcpa = ($this,@_);
  
  $lc_test = &chobak_stack::digdown::res::acod_yes($_[1]->{'check'});
  $lc_onyes = &chobak_stack::digdown::res::acod_yes($_[1]->{'onyes'});
  $lc_onno = &chobak_stack::digdown::res::acod_yes($_[1]->{'onno'});
  $lc_onempty = &chobak_stack::digdown::res::acod_no($_[1]->{'onempty'});
  
  while ( $this->siz() > 0.5 )
  {
    @lc_rcpb = @lc_rcpa;
    $lc_ret = &$lc_test(@lc_rcpb);
    if ( $lc_ret )
    {
      @lc_rcpb = @lc_rcpa;
      return &$lc_onyes(@lc_rcpb);
    }
    @lc_rcpb = @lc_rcpa;
    &$lc_onno(@lc_rcpb);
    
    $this->off();
  }
  
  @lc_rcpb = @lc_rcpa;
  return &$lc_onempty(@lc_rcpb);
}

1;
