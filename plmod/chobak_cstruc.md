# Module: chobak_cstruc

## Functions

### force_hash_has_array

  * __Arg #0:__ A reference to the hash you wish to assure has an array
  * __Arg #1:__ A string with the name of the array you wish to assure is contained in the hash

If the hash referenced in Argument 0 already has an element by the name contained
in Argument 1, and that element is a reference to an array, then this function
will do nothing at all.

If it has an element by that name that is anything other than a reference to an array, it
will replace that element with a reference to a newly-created empty array.

And if there is no element by that name - then it will create that element as a reference
to a newly-created empty array.