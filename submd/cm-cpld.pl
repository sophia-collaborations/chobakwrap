# This command submodule copies one directory to another by only
# copying that which was different and leaving untouched whatever
# is already the same to begin with.
use strict;
use argola;
use wraprg;

my @obsol_dirs = ();
my @obsol_files = ();
my @neos_dirs = ();
my @neos_files = ();

my $srcdir;
my $dstdir;
my @srcrawcon;
my @dstrawcon;

$srcdir = &argola::getrg();
$dstdir = &argola::getrg();

sub kystem {
  #system('echo',"\n",'#',@_);
  system(@_);
}

# PHASE ONE: POPULATE THE @obsol_ AND @neos_ ARRAYS:
@srcrawcon = &afindula($srcdir);
@dstrawcon = &afindula($dstdir);
sub afindula {
  my $lc_cm;
  my $lc_raw;
  my @lc_ret;
  $lc_cm = '( cd ' . &wraprg::bsc($_[0]) . ' && find . )';
  $lc_raw = `$lc_cm`;
  @lc_ret = split(/\n/,$lc_raw);
  return @lc_ret;
}
sub zango {
  $_[0] = ( $srcdir . '/' . $_[2] );
  $_[1] = ( $dstdir . '/' . $_[2] );
}
sub uniquod {
  if ( -d $_[1] ) { return(1>2); }
  if ( -d $_[0] ) { return(2>1); }
  return(1>2);
}
sub uniquof {
  if ( -f $_[1] ) { return(1>2); }
  if ( -f $_[0] ) { return(2>1); }
  return(1>2);
}
sub dif_ar_ef {
  my $lc_cm;
  my $lc_rs;
  if ( ! ( -f $_[1] ) ) { return(1>2); }
  if ( ! ( -f $_[0] ) ) { return(1>2); }
  $lc_cm = 'diff ' . &wraprg::bsc($_[0]) . ' ' . &wraprg::bsc($_[1]);
  $lc_rs = `$lc_cm`;
  return($lc_rs ne '');
}
sub difaref {
  if ( &uniquof(@_) ) { return(2>1); }
  return &dif_ar_ef(@_);
}
{
  my $lc_each;
  my $lc_srcv;
  my $lc_dstv;
  foreach $lc_each (@srcrawcon) {
    &zango($lc_srcv,$lc_dstv,$lc_each);
    if ( &uniquod($lc_srcv,$lc_dstv) ) { @neos_dirs = (@neos_dirs,$lc_each); }
    if ( &difaref($lc_srcv,$lc_dstv) ) { @neos_files = (@neos_files,$lc_each); }
  }
  foreach $lc_each (@dstrawcon) {
    &zango($lc_srcv,$lc_dstv,$lc_each);
    if ( &uniquod($lc_dstv,$lc_srcv) ) { @obsol_dirs = (@obsol_dirs,$lc_each); }
    if ( &uniquof($lc_dstv,$lc_srcv) ) { @obsol_files = (@obsol_files,$lc_each); }
  }
}

# PHASE TWO: DELETE OBSOLTE FILES:
{
  my $lc_each;
  foreach $lc_each (@obsol_files)
  {
    &kystem('rm',($dstdir . '/' . $lc_each));
  }
}

# PHASE THREE: DELETE OBSOLETE DIRECTORIES:
{
  my $lc_each;
  foreach $lc_each (@obsol_dirs)
  {
    &kystem('rmdir',($dstdir . '/' . $lc_each));
  }
}

# PHASE FOUR: CREATE NEW DIRECTORIES:
{
  my $lc_each;
  my $lc_creato;
  my $lc_sokay;
  my $lc_counto;
  $lc_counto = 0;
  $lc_sokay = 0;
  while ( $lc_sokay < 5 )
  {
    $lc_sokay = 10;
    $lc_counto = int($lc_counto + 1.2);
    if ( $lc_counto > 50.5 ) { die "\nFAILED TO DO THE COPY:\n\n"; }
    #system('echo',('DEBUG: Round ' . $lc_counto));
    foreach $lc_each (@neos_dirs)
    {
      $lc_creato = ($dstdir . '/' . $lc_each);
      &kystem('mkdir',$lc_creato);
      if ( ! ( -d $lc_creato ) ) { $lc_sokay = 0; }
    }
  }
}

# PHASE FIVE: COPY NEW AND CHANGED
{
  my $lc_each;
  foreach $lc_each (@neos_files)
  {
    &kystem('cp',($srcdir . '/' . $lc_each),($dstdir . '/' . $lc_each));
  }
}


