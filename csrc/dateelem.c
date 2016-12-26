/* ****
dateelem 1.3 - Finds one element of the current date
main.c
1.0: Copyright (C) 1998  Ultra-Flamin' Cool Computer Consulting
1.0: Copyright (C) 2001 Techno-Info Comprehensive Solutions
1.2: Copyright (C) 2002 Techno-Info Comprehensive Solutions
1.3: Copyright (C) 2002 Techno-Info Comprehensive Solutions

This software is licensed under the terms of the GNU General Public
License version 2.0 of the Free Software Foundation (http://www.gnu.org)
with NO WARRANTY, even the implied waranty of merchantability, or
usability for a particular purpose.

To contact the author of this program, visit the software web-site
at:  http://boxenv.com
**** */

/* ****
CHANGES FOR 1.2:

2002-04-29: I added the "lnsz" mode so that the command
"dateelem lnsz" simply outputs the size (in bytes) of
a long-integer on the system that this program is built
on.

******************************************************

CHANGES FOR 1.3:

2002-10-24: I added the "dayoy" mode so that we can tell
what day of the year it is.

**** */



#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int st_same ( char *rg_a, char *rg_b )
{
  char *a;
  char *b;

  if ( rg_a == rg_b ) return 10;
  if ( rg_a == ((char *)NULL) ) return 0;
  if ( rg_b == ((char *)NULL) ) return 0;

  a = rg_a;
  b = rg_b;
  while ( *a == *b )
  {
    if ( *a == '\0' ) return 10;
    a++; b++;
  }
  return 0;
}


#define lmstrg(b) if ( st_same(argv[1],b) > 5 )
#define emstrg(b) else if ( st_same(argv[1],b) > 5 )

int main(argc,argv,environ)
int argc;
char **argv;
char **environ;
{
  long a;
  time_t b;
  struct tm *c;
  if ( argc < 2 )
  {
    fprintf(stderr,"%s: usage: %s [element]\n",argv[0],argv[0]);
    exit(3);
  }
  b = time(0);
  if ( argc > 2 ) b = ((time_t)atol(argv[2]));
  a = (long)0;
  c = localtime(&b);
  lmstrg("year") a = (((long)(c->tm_year)) + (long)1900 );
  emstrg("dayom") a = ((long)(c->tm_mday));
  emstrg("dayoy") a = ((long)(c->tm_yday));
  emstrg("dayow") a = (((long)(c->tm_wday)) + (long)1);
  emstrg("month") a = (((long)(c->tm_mon)) + (long)1);
  emstrg("hour") a = (((long)(c->tm_hour)) + (long)0);
  emstrg("min") a = (((long)(c->tm_min)) + (long)0);
  emstrg("sec") a = (((long)(c->tm_sec)) + (long)0);
  emstrg("isdst") a = (((long)(c->tm_isdst)) + (long)0);
  emstrg("raw") a = (long)b;
  emstrg("lnsz") a = sizeof(long);
  printf ( "%ld\n", a );
  fflush(stdout);
  return 0;
}

