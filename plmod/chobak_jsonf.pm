package chobak_jsonf;
use strict;
use chobak_jsonf::cls;
use chobak_jsonf::util;
use chobak_json;

# Current implementation of new() assumes
# that either the provided filebase is an
# absolute path or the program's process will
# never change directory. Eventually, this
# implementation will need to be re-named and
# wrapped in a new implementation to accommodate
# the possibility of this presumption being false.
sub new {
  my $this;
  my $lc_content;
  my $lc_mode;
  $this = chobak_jsonf::cls->__raw_new;
  
  # First, we set the basic, predictable object
  # elements.
  $this->{'base'} = $_[0];
  $this->{'flag'} = $_[0] . '-c.flag';
  $this->{'fna'} = $_[0] . '-a.json';
  $this->{'fnb'} = $_[0] . '-b.json';
  
  # Our default assumption is that the flag-file
  # is ABSENT.
  $this->{'swap'} = \&chobak_jsonf::util::smp_on;
  $this->{'read'} = $this->{'fna'};
  $this->{'write'} = $this->{'fnb'};
  
  # Of course - our default assumption is open to
  # correction.
  if ( -f ( $this->{'flag'} ) )
  {
    $this->{'swap'} = \&chobak_jsonf::util::smp_off;
    $this->{'read'} = $this->{'fnb'};
    $this->{'write'} = $this->{'fna'};
  }
  
  # Now we load the file's contents
  $lc_content = &chobak_jsonf::readf($this->{'read'});
  
  # And to enforce the root-type (that being the
  # designation of whether the file opened is to
  # be a HASH or an ARRAY)
  $lc_mode = $_[1]->{'rtyp'};
  if ( $lc_mode eq 'h' )
  {
    if ( ref($lc_content) ne 'HASH' ) { $lc_content = {}; }
  }
  if ( $lc_mode eq 'a' )
  {
    if ( ref($lc_content) ne 'ARRAY' ) { $lc_content = []; }
  }
  
  # Now to embed the content in the object and return
  # to the calling program:
  $this->{'cont'} = $lc_content;
  return $this;
}



1;


