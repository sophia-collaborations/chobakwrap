package chobak_jsonf;
use strict;
use chobak_jsonf::cls;
use chobak_jsonf::util;
use chobak_json;
use chobak_errutil;
use Cwd qw(realpath);

sub byref {
  # Rg0 - The ref file's location-string
  # Rg1 - DEST of object
  # Rg2 - Parameter hash (and where this function can
  #       put detailed postmortem info)
  # RET - 'true' upon success - 'false' upon failure
  my $lc_prm; # Parameter hash
  my $lc_refraw; # Raw form of ref filename
  my $lc_reftru; # Realpath of ref filename
  my $lc_refbas;
  my $lc_can_create;
  
  $lc_prm = $_[2];
  if ( ref($lc_prm) ne 'HASH' ) { $lc_prm = {}; }
  
  $lc_can_create = 10;
  if ( $lc_prm->{'create'} eq 'no' ) { $lc_can_create = 0; }
  
  $lc_refraw = $_[0];
  {
    my $lc2_a;
    $lc2_a = substr($lc_refraw,-4);
    if ( $lc2_a ne '.ref' )
    {
      return &chobak_errutil::erfunc($lc_prm,1,'Filename of reference file must end in ".ref".');
    }
  }
  if ( ! ( -f $lc_refraw ) )
  {
    if ( $lc_can_create > 5 ) { system("touch",$lc_refraw); }
  }
  if ( ! ( -f $lc_refraw ) )
  {
    return &chobak_errutil::erfunc($lc_prm,2,'The reference file must exist - or be creatable.');
  }
  $lc_reftru = realpath($lc_refraw);
  {
    my $lc2_a;
    $lc_refbas = substr($lc_reftru,0,-4);
    $lc2_a = $lc_refbas . '.ref';
    #$lc2_a = substr($lc_reftru,-4);
    #if ( $lc2_a ne '.ref' )
    if ( $lc2_a ne $lc_reftru )
    {
      return &chobak_errutil::erfunc($lc_prm,3,'Filename of reference file must end in ".ref".');
    }
  }
  if ( ! ( -f $lc_reftru ) )
  {
    if ( $lc_can_create > 5 ) { system("touch",$lc_reftru); }
  }
  if ( ! ( -f $lc_reftru ) )
  {
    return &chobak_errutil::erfunc($lc_prm,4,'The reference file must exist - or be creatable.');
  }
  
  $_[1] = &new($lc_refbas,$lc_prm);
  return ( 2 > 1 );
  
}

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
  $lc_content = &chobak_json::readf($this->{'read'});
  
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


