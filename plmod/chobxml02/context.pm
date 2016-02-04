package chobxml02::context;
use chobxml02::context::cls;

sub new {
  my $this;
  $this = chobxml02::context::cls->__raw_new;
  
  $this->{'tag-o'} = {}; # Opening handlers for known tags
  $this->{'tag-c'} = {}; # Closing handlers for known tags
  $this->{'gnr-o'} = \&gener_on;
  $this->{'gnr-c'} = \&gener_off;
  $this->{'dfl-chr'} = \&do_nothing;
  $this->{'flushf'} = \&do_nothing; # Handler for after all is done
  $this->{'initf'} = \&do_nothing; # Handler for before anything is done
  return $this;
}

sub do_nothing {
}

sub gener_on {
  die ( "\nCan not open unkown tag: " . $_[0]->mytag() . ":\n\n" );
}

sub gener_off {
  die ( "\nCan not close unkown tag: " . $_[0]->mytag() . ":\n\n" );
}


1;
