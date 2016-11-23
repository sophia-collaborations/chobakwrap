
### llsearch
__IMPLEMENTATION PENDING__

__llsearch__ stands for "__l__ow __l__evel __search__".
It was not originally intended to be called from outside of this module -
but it was re-marked as eligible for that purpose just in case someone
might find doing so useful.
It's primary purpose, however, is as a tool for the __search()__ function.
This function takes three arguments:

  * __Argument 0:__
  This argument is a simple string - the name of whatever it is you're looking for.
  * __Argument 1:__
  This argument is an ArrayRef - and is a list of all the directories to be searched.
  * __Argument 2:__
  This argument is a HashRef of all additional options.
  Now follows the documentation of exactly what these options can be.

If successful, this function returns the HashRef that was returned by
the successful test (which the calling program will recognize because
it's _'ok'_ element has a value of _true_.

On the other hand, upon failure to find the resource being searched
for, this function returns a
freshly-generated HashRef with just one element
(_'ok'_)
with a value of _false_.

Now let us discuss the options that can be passed through __Argument 2__.

#### 'test'
This option is a CodeRef to a function that accepts one argument -- the possible
path-name of the item being searched for. It returns
a HashRef who's _'ok'_ element is _true_ if the item is found
at that location
and _false_ if the item is not found at that location.

The default is a simple test to see if the if the file exists (basically
using perl's __\-f__ thingie).

If the test is a failure, then _'ok'_ is the only element of the HashRef
returned that has any significance.
Otherwise, the HashRef will have also a _'loc'_ element that is the actual
location of the resource found
(which may be a simple copy of the argument that was passed to the here-referenced
function itself - but which alternatively may also have a suffix appended to it).

Also, if the test is successful, the function here-referenced may choose to
add other elements to this list passing other information that the calling
program needs to know - because in the event of such success, this HashRef
will be returned to the program that called __search()__ or __llsearch()__.

Of course - with the default function - _'ok'_ and _'loc'_ are the only
elements in the success HashRef - and the value of _'loc'_ does not have
any extra suffix appended to it.

#### 'stts'
This option is a simple string - and it references a function that could be
passed to _'test'_ but is built in to this module and has a simple string
assigned to it.

If _'stts'_ is provided and if it's value is a valid
string recognized as being assigned to such a function,
it then overrides the value of _'test'_ - otherwise it
does not.

Here are the currently-recognized values:

  * '__file__':
  Basically just reverts _'test'_ to it's default value.

### search
__IMPLEMENTATION PENDING__

__search()__ is the function called by the calling program to search for
something along a path.

  * __Argument 0:__
  This argument is a simple string - the name of whatever it is you're looking for.
  * __Argument 1:__
  The name of an environment variable containing the search-path in a colon-separated
  list.
  * __Argument 2:__
  A HashRef that gets passed to __Argument 2__ of __llsearch()__.
  It must therefore have any options in it that are to be passed to
  __llsearch()__ in such manner -- and in addition,
  may have the following
  that will be used by __search()__ itself:

#### 'dflt'
This is the default search-path.
It becomes _the_ search-path if the environment variable
named in __Argument 1__ turns out to be empty.
Furthermore, even if the environment variable
named in __Argument 1__ is _not_ empty, but happens
to contain empty elements (that is, if it either begins
or ends with a colon - or has two colons one immediately
after another)
then this default search-path will be spliced into the
greater search-path accordingly.

In theory, the default search-path will be spliced in
to replace every empty element of an environment-provided
search-path - but in practice, it may only be spliced
into the place of the first one so as to provide an
identical result with reduced testing-redundancy.

