# wraprg

## Function: abro
It takes one argument - which is a shell command.
It runs that command, captures the output to a variable,
and returns that variable.

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
then the return value is a relative path.

Please do not include the trailing forward-slash at the
end of either argument - especially the first one (unless
it is the root directory in which case you have no choice).


