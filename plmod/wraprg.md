# wraprg

## Function: rel_sm
This function takes two arguments \-
the first argument name of a directory (that may or may
not exist) and the second being the name of a file or of
another directory relative to
that directory which was named in the first argument.
This file or second directory _also_ may or may not exist.

It returns a reference to the file or directory specified
in the second argument that is independent of the directory
referenced in the first argument.
If either of the arguments is an absolute path,
then the return value is also an absolute path.
If both arguments are relative paths,
then the return value is relative to the same
directory that the first argument was specified
_relative_ to.


