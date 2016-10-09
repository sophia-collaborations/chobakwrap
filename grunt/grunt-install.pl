use strict;
# The Grunt Tools are low-level command-line tools present for the
# purpose of OS abstraction between different Unix-type operating
# systems.

#my $fruname;
my $osid;

#$osid = 'x';
#$fruname = `uname`; chomp($fruname);
#if ( $fruname eq 'Darwin' ) { $osid = 'osx'; }

#$osid = `perl grunt-detect.pl`; chomp($osid);
$osid = `perl ../submd/cm-osid.pl`; chomp($osid);

if ( $osid eq 'x' ) { die "\nWe could not identify the OS type:\n\n"; }

exec("sh",("grunt-for-" . $osid . ".sh"));

