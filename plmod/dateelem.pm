package dateelem;
# This package is a PERL module to interface with the -dateelem-
# consistator.
use strict;
use wraprg;


my $standardo = {
  'lmonth' => [ 'gry',
    {
      'lm' => 'month',
      'ry' => ['x'
        ,'January','February','March'
        ,'April','May','June'
        ,'July','August','September'
        ,'October','November','December'
      ]
    }
  ],
  
  'ldayow' => [ 'gry',
    {
      'lm' => 'dayow',
      'ry' => ['Saturday','Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday','Monday'],
    }
  ],
  
  'polite_date' => ['rc'
    ,['lib','lmonth']
    ,['l',' ']
    ,['u','dayom']
    ,['l',', ']
    ,['u','year']
  ],
  
  'polite_date_w' => ['rc'
    ,['lib','ldayow']
    ,['l',', ']
    ,['lib','lmonth']
    ,['l',' ']
    ,['u','dayom']
    ,['l',', ']
    ,['u','year']
  ],
  
  'date_dshcode' => ['rc'
    ,['f',4,'year']
    ,['l','-']
    ,['f',2,'month']
    ,['l','-']
    ,['f',2,'dayom']
  ],
  
  'date_stamp_dshcode' => ['rc'
    ,['f',4,'year']
    ,['l','-']
    ,['f',2,'month']
    ,['l','-']
    ,['f',2,'dayom']
    ,['l','-']
    ,['f',2,'hour']
    ,['f',2,'min']
    ,['f',2,'sec']
  ],
};



# It seems like every basic time library has it's implementation of
# nowo() --- so here's this one's:
sub nowo {
  return &bscv('raw');
}


sub bscv {
  my $lc_cm;
  my $lc_rt;
  $lc_cm = "chobakwrap -c dateelem " . &wraprg::bsc($_[0]);
  $lc_rt = `$lc_cm`; chomp($lc_rt);
  return $lc_rt;
}

sub driv {
  my $lc_cm;
  my $lc_rt;
  $lc_cm = "chobakwrap -c dateelem " . &wraprg::bsc($_[1]) . " " . &wraprg::bsc($_[0]);
  $lc_rt = `$lc_cm`; chomp($lc_rt);
  return $lc_rt;
}

sub qdriv {
  my $lc_cm;
  my $lc_prt;
  my $lc_rt;
  my $lc_remo;
  my $lc_chr;
  $lc_cm = "chobakwrap -c dateelem " . &wraprg::bsc($_[1]) . " " . &wraprg::bsc($_[0]);
  $lc_prt = `$lc_cm`; chomp($lc_prt);
  
  $lc_remo = $_[2];
  $lc_prt = '00' . $lc_prt;
  $lc_rt = '';
  
  while ( $lc_remo > 0.5 )
  {
    $lc_prt = '0' . $lc_prt;
    $lc_chr = chop($lc_prt);
    $lc_rt = $lc_chr . $lc_rt;
    $lc_remo = int($lc_remo - 0.8);
  }
  
  return $lc_rt;
}

sub regaray {
  my $this;
  my $lc_raw;
  my $lc_ret;
  $this = $_[0];
  if ( ref($this) ne 'HASH' ) { return ''; }
  if ( ref($this->{'ry'}) ne 'ARRAY' ) { return ''; }
  $lc_raw = driv($_[1],$this->{'lm'});
  $lc_ret = $this->{'ry'}->[$lc_raw];
  return $lc_ret;
}

sub asem {
  my $lc_info;
  my $lc_each;
  my $lc_colc;
  
  $lc_colc = $_[0];
  
  $lc_info = { 'svar' => 0, 'reto' => '', 'yet' => (1>2) };
  foreach $lc_each (@$lc_colc) { &stpasem($lc_info,$lc_each); }
  return $lc_info->{'reto'};
}

sub nowstamp {
  my $this;
  $this = $_[0];
  
  if ( $this->{'yet'} ) { return; }
  $this->{'svar'} = &bscv('raw');
  $this->{'yet'} = (2>1);
}

sub stpasem {
  my $this;
  my $lc_th;
  $this = $_[0];
  $lc_th = $_[1];
  
  if ( ref($lc_th) ne 'ARRAY' )
  {
    if ( $lc_th eq 'now' ) { $this->{'svar'} = &bscv('raw'); $this->{'yet'} = (2>1); return; }
    return;
  }
  
  if ( $lc_th->[0] eq 'at' )
  {
    $this->{'svar'} = $lc_th->[1];
    $this->{'yet'} = (2>1);
    return;
  }
  
  if ( $lc_th->[0] eq 'l' )
  {
    $this->{'reto'} .= $lc_th->[1];
    return;
  }
  
  if ( $lc_th->[0] eq 'u' )
  {
    &nowstamp($this);
    $this->{'reto'} .= &driv($this->{'svar'},$lc_th->['1']);
    return;
  }
  
  if ( $lc_th->[0] eq 'f' )
  {
    &nowstamp($this);
    $this->{'reto'} .= &qdriv($this->{'svar'},$lc_th->['2'],$lc_th->['1']);
    return;
  }
  
  if ( $lc_th->[0] eq 'rc' )
  {
    my @lc2_a;
    my $lc2_b;
    @lc2_a = @$lc_th;
    shift(@lc2_a);
    foreach $lc2_b (@lc2_a) { &stpasem($this,$lc2_b); }
    return;
  }
  
  if ( $lc_th->[0] eq 'gry' )
  {
    &nowstamp($this);
    $this->{'reto'} .= &regaray($lc_th->[1],$this->{'svar'});
    return;
  }
  
  if ( $lc_th->[0] eq 'lib' )
  {
    my $lc2_a;
    $lc2_a = $standardo->{$lc_th->[1]};
    if ( defined($lc2_a) )
    {
      &stpasem($this,$lc2_a);
    }
    return;
  }
}


sub center {
  my $lc_vr;
  my $lc_hr;
  
  $lc_vr = $_[0];
  $lc_hr = &driv($lc_vr,'hour');
  while( $lc_hr < 10.5) { $lc_vr = int($lc_vr + 7200.2); $lc_hr = &driv($lc_vr,'hour'); }
  while( $lc_hr > 13.5) { $lc_vr = int($lc_vr - 7199.8); $lc_hr = &driv($lc_vr,'hour'); }
  $_[0] = $lc_vr;
}

sub fford {
  my $lc_vr;
  
  $lc_vr = $_[0];
  &center($lc_vr);
  $lc_vr = int(($lc_vr + ($_[1] * 60 * 60 * 24)) + 0.2);
  $_[0] = $lc_vr;
}

sub rwind {
  my $lc_vr;
  
  $lc_vr = $_[0];
  &center($lc_vr);
  $lc_vr = int(($lc_vr - ($_[1] * 60 * 60 * 24)) + 0.2);
  $_[0] = $lc_vr;
}




1;
