# This PERL script will automate the building of binaries for a
# project.
use strict;

my @compilor = ('gcc');
my $semapa;
my @codelines;
my @compiled_c_sr = ();
my @included_c_sr = ();


# Let us make sure that there is a gitignore
if ( !( -f '.gitignore' ) )
{
  die "\nFATAL ERROR: file '.gitignore' not found:\n\n";
}

# Let us also make sure that all necessary bases are covered in
# the gitignore.
{
  my $lc_raw;
  my @lc_lines;
  my @lc_ncsr;
  my $lc_lna;
  my $lc_nca;
  my $lc_ok;

  @lc_ncsr = ('/bnr-a','/bnr-b','/bnr-flag.txt','/bnr-prep');

  $lc_raw = `cat .gitignore`;
  @lc_lines = split(/\n/,$lc_raw);
  foreach $lc_nca (@lc_ncsr)
  {
    $lc_ok = 0;
    foreach $lc_lna (@lc_lines)
    {
      if ( $lc_lna eq $lc_nca ) { $lc_ok = 10; }
    }
    if ( $lc_ok < 5 )
    {
      die("\nFATAL ERROR:\n    Line missing from '.gitignore': '" . $lc_nca . "':\n\n");
    }
  }
}


if ( !( -f 'bnr-req.txt' ) )
{
  die "\nFATAL ERROR: file 'bnr-req.txt' not found:\n\n";
}

if ( !( -d 'bnr-src' ) )
{
  die "\nFATAL ERROR: directory 'bnr-src' not found:\n\n";
}

# Now, identify the semaphore state for write operations:
# (It will never be the same as the semaphore state for read
# operations):
$semapa = 'a';
if ( -f 'bnr-flag.txt' ) { $semapa = 'b'; }



system('rm -rf bnr-prep');
system('mkdir bnr-prep');
system('rm','-rf',('bnr-' . $semapa));
system('mkdir',('bnr-' . $semapa));

# Now we load the lines of the binary requisite file:
{
  my $lc_a;
  $lc_a = `cat bnr-req.txt`;
  @codelines = split(/\n/,$lc_a);
}

{
  my $lc_a;
  foreach $lc_a (@codelines) { &eachline($lc_a); }
}
sub eachline {
  my $lc_jnk;
  my $lc_ltype;
  my $lc_item;
  my $lc_each;
  ($lc_jnk,$lc_ltype,$lc_item) = split(/:/,('x' . $_[0]));

  if ( $lc_ltype eq '' ) { return; }

  if ( $lc_ltype eq 'csrc' )
  {
    if ( &absentee($lc_item,\@compiled_c_sr) )
    {
      system(@compilor,'-c','-o',('bnr-prep/' . $lc_item . '.o'),('bnr-src/' . $lc_item . '.c'));
      @compiled_c_sr = (@compiled_c_sr,$lc_item);
    }
    if ( &absentee($lc_item,\@included_c_sr) )
    {
      @included_c_sr = (@included_c_sr,$lc_item);
    }
    return;
  }

  if ( $lc_ltype eq 'cbin' )
  {
    my @lc_cm;
    @lc_cm = (@compilor,'-o',('bnr-' . $semapa . '/' . $lc_item));
    foreach $lc_each (@included_c_sr)
    {
      @lc_cm = (@lc_cm,('bnr-prep/' . $lc_each . '.o'));
    }
    system(@lc_cm);
    @included_c_sr = ();
    return;
  }

  die("\nNo such line type: " . $lc_ltype . ":\n\n");
}

sub absentee {
  my $lc_a;
  my @lc_b;
  $lc_a = $_[1];
  @lc_b = @$lc_a;
  foreach $lc_a (@lc_b)
  {
    if ( $_[0] eq $lc_a ) { return(1>2); }
  }
  return(2>1);
}

sub presentee {
  my $lc_a;
  my @lc_b;
  $lc_a = $_[1];
  @lc_b = @$lc_a;
  foreach $lc_a (@lc_b)
  {
    if ( $_[0] eq $lc_a ) { return(2>1); }
  }
  return(1>2);
}



system('rm -rf bnr-prep');

# Now -- swap the semaphore:
if ( $semapa eq 'a' ) { system('date +%s > bnr-flag.txt'); }
if ( $semapa eq 'b' ) { system('rm','-rf','bnr-flag.txt'); }




