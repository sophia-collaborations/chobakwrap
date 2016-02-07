package chobxml02::rgpack::bsc_start;
use strict;
use chobxml02::fnc::writing;


sub morph {
  my $this;
  my $lc_gem;
  $this = shift;
  
  $lc_gem = $this->{'gem'};
  
  $lc_gem->{'stack'}->on({
    'typ' => 'context',
    'cntx' => $lc_gem->{'context'}
  });
  
  $lc_gem->{'context'} = $_[0];
}

sub to_tag_data {
  # Create an empty string in tag-data labeled by $_[0],
  # point the writer to it, and set the function to
  # just add all char-data to the writer --- all in
  # one convenient object-method!!!
  my $this;
  my $lc_gem;
  $this = shift;
  
  $lc_gem = $this->{'gem'};
  
  # Create the string:
  $this->{'tagdata'}->{$_[0]} = '';
  
  # Point at the reference:
  $lc_gem->{'stack'}->on({
    'typ' => 'penpt',
    'penpt' => $lc_gem->{'penpt'}
  });
  $lc_gem->{'penpt'} = \$this->{'tagdata'}->{$_[0]};
  
  # Redirect the char-function:
  $lc_gem->{'stack'}->on({
    'typ' => 'charf',
    'charf' => $lc_gem->{'charf'}
  });
  $lc_gem->{'charf'} = \&chobxml02::fnc::writing::to_pen_raw;
}

sub esc_tag_data {
  # Just like 'to_tag_data()' - except this method selects
  # a char-data handler that escapes the string.
  my $this;
  my $lc_gem;
  $this = shift;
  
  $lc_gem = $this->{'gem'};
  
  # Create the string:
  $this->{'tagdata'}->{$_[0]} = '';
  
  # Point at the reference:
  $lc_gem->{'stack'}->on({
    'typ' => 'penpt',
    'penpt' => $lc_gem->{'penpt'}
  });
  $lc_gem->{'penpt'} = \$this->{'tagdata'}->{$_[0]};
  
  # Redirect the char-function:
  $lc_gem->{'stack'}->on({
    'typ' => 'charf',
    'charf' => $lc_gem->{'charf'}
  });
  $lc_gem->{'charf'} = \&chobxml02::fnc::writing::to_pen_esc;
}

sub pentotg {
  # This method does the exact same thing as to_tg_data,
  # except that it does not affect the char-data handler.
  my $this;
  my $lc_gem;
  $this = shift;
  
  $lc_gem = $this->{'gem'};
  
  # Create the string:
  $this->{'tagdata'}->{$_[0]} = '';
  
  # Point at the reference:
  $lc_gem->{'stack'}->on({
    'typ' => 'penpt',
    'penpt' => $lc_gem->{'penpt'}
  });
  $lc_gem->{'penpt'} = \$this->{'tagdata'}->{$_[0]};
}


1;
